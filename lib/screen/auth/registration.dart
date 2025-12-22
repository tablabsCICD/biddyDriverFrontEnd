import 'dart:convert';
import 'dart:typed_data';

import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/constant/prefrenseconstant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/saveDriverCabDetails.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/provider/registration_provider.dart';
import 'package:biddy_driver/model/cabDetails.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:biddy_driver/widgets/app_bar.dart';
import 'package:biddy_driver/widgets/custom_dropdown_list.dart';
import 'package:biddy_driver/widgets/datepicker.dart';
import 'package:biddy_driver/widgets/profile_custom_textfeild.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../route/app_routes.dart';
import '../../widgets/button.dart';
import '../../widgets/text_input_Field.dart';

class RegistrationScreen extends StatefulWidget {
  final String mobileNumber;

  const RegistrationScreen({
    super.key,
    required this.mobileNumber,
  });

  @override
  State<StatefulWidget> createState() {
    return RegistartionState(mobileNumber);
  }
}

class RegistartionState extends State<RegistrationScreen> {
  late RegistrationProvider registrationProvider;

  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController ssnController = TextEditingController();
  TextEditingController licenseExpiryDateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController licenceNumberController = TextEditingController();
  TextEditingController onlineTimeController = TextEditingController();
  TextEditingController offlineController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List<String> genderList = [
    'Male',
    'Female',
    'Other',
  ];
  String? selectedGender;

  String? onlineTime, offlineTime;
  String mob;

  RegistartionState(this.mob);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RegistrationProvider("Ideal"),
      builder: (context, child) => _buildPage(context),
    );

    /*
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
        child: AppButton(buttonTitle: "Register", onClick: (){
          registeruser();
          Navigator.pushNamed(context, AppRoutes.crearebiz);
        }, enbale: true),
      ),
      appBar: AppBar(title: Text("Registration"),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Center(
              child: Image.asset('assets/img_login.jpg',height: 150,width: 150,),
            ),

            TextInputFiled(labelText: 'Enter First Name', inputType: TextInputType.text,),
            TextInputFiled(labelText: 'Enter Last Name', inputType: TextInputType.text,),
            TextInputFiled(labelText: 'Enter Your Address', inputType: TextInputType.text,),
            TextInputFiled(labelText: 'Enter Your Email Id ', inputType: TextInputType.text,),
            TextInputFiled(labelText: 'Enter Your Birth Date ', inputType: TextInputType.datetime,),
           // TextInputFiled(labelText: 'Enter Your Gender ', inputType: TextInputType.datetime,),
          SizedBox(height: 10,),
            dropDwon(),
          ],
        ),
      ),
    );*/
  }

  dropDwon() {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
        // height: 60,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.black54),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        //height: 60,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: DropdownButton(
            hint: TextView(
              title: "hint",
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            borderRadius: new BorderRadius.circular(25.0),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            isDense: false,
            isExpanded: true,
            underline: Container(),
            style: TextStyle(
              decoration: TextDecoration.none, // Removes underline
            ),
            items: genderList
                .map((value) => DropdownMenuItem(
              value: value,
              child: Container(
                // height: 50,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15),
                  child: TextView(
                    title: "$value",
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
            ))
                .toList(),
            value: selectedGender,
            onChanged: (value) {
              setState(() {
                selectedGender = value as String;
              });
            },

          ),
        ));
  }

  String imgPath = '';
  String documentPath = '';
  PlatformFile? objFile;
  Uint8List? imageBytes;
  String? fileName;
  String? uploadedDocument;

  pickFile(bool isImg) async {

    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      setState(() {
        objFile = result.files.single;
      });
      try {
        fileName = result.files.first.name;
        print(result.files.first.toString());
        imageBytes = result.files.first.bytes;
        print(fileName);
        print(await result.files.first
            .toString()
            .length);
        if (await result.files.first
            .toString()
            .length >= 500) {
          SnackBar snackBar = SnackBar(
            content: Text("Image Size should be less than 500 KB"),
            duration: Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);

        } else {
          uploadedDocument = isImg ? null : fileName;
          print('the url is ${APIConstants.UPLOAD_LEAD_IMG}');
          var postUri = Uri.parse(APIConstants.UPLOAD_LEAD_IMG);
          var request = new http.MultipartRequest("POST", postUri);
          Map<String,String> headers = {"Content-Type": "multipart/form-data"};
          request.headers.addAll(headers);
          request.files.add(new http.MultipartFile(
              "profilePicture", objFile!.readStream!, objFile!.size,
              filename: objFile!.name));
          var response = await request.send();
          print(response.statusCode);
          response.stream.transform(utf8.decoder).listen((value) {
            print(value);
            String stringWithoutQuotes = value.replaceAll('"', '');
            print(stringWithoutQuotes);
            if (isImg) {
              imgPath = stringWithoutQuotes;
            } else {
              documentPath = stringWithoutQuotes;
            }
            print("Uploaded Img Path From s3 bucket::" +
                imgPath +
                "\ndocumentPath" +
                documentPath);
            setState(() {});
          });
          print('the response is ${response}');

          if (response.statusCode == 200) {
            SnackBar snackBar = SnackBar(
              content: Text("Image uploaded"),
              duration: Duration(seconds: 5),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      } catch (ex) {
        throw Exception("Exception Occurred ${ex.toString()}");
      }
    }
  }

  _buildPage(context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: AppButton(
              buttonTitle: "Register",
              onClick: () {
               registeruser();
      
               // Navigator.pushReplacementNamed(context, AppRoutes.driverCabRegistration);
              },
              enbale: true),
        ),
        appBar: ApplicationAppBar().commonAppBar(context, "Register"),
        body: Consumer<RegistrationProvider>(
          builder: (context, provider, child) {
            this.registrationProvider = provider;
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () async {
                          pickFile(true);
                        },
                        child: Container(
                          height: 120,
                          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                          width: 120,
      
                          child: imgPath.isEmpty || imgPath == ''?SvgPicture.asset('assets/upload_profile.svg',
                              height: 100, width: 100):Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(imgPath)))),
                        ),
                      ),
                    ),
                    ProfileCustomTextField(
                      hintText: 'Enter First Name',
                      controller: fnameController,
                      textInputType: TextInputType.text,
                      validatorMsg: "please enter your name",
                      isValidator: true,
                      isName: true,
                      prefixIcon: Icons.account_circle_outlined,
                    ),
                    ProfileCustomTextField(
                      hintText: 'Enter Last Name',
                      controller: lnameController,
                      textInputType: TextInputType.text,
                      validatorMsg: "please enter your name",
                      isValidator: true,
                      isName: true,
                      prefixIcon: Icons.account_circle_outlined,
                    ),
                    ProfileCustomTextField(
                      hintText: 'Enter Your Email',
                      controller: emailController,
                      textInputType: TextInputType.emailAddress,
                      validatorMsg: "please enter your emailid",
                      isValidator: true,
                      // isName: true,
                      prefixIcon: Icons.email_outlined,
                    ),
                    ProfileCustomTextField(
                      hintText: 'Enter Your Birth Date',
                      controller: birthdateController,
                      textInputType: TextInputType.number,
                      validatorMsg: "please enter your birth date",
                      isValidator: true,
                      onTap: () async {
                        String selectedDate = await DateTimePickerDialog()
                            .pickBeforeDateDialog(context);
                        if (selectedDate.isEmpty) {
                          birthdateController.text = "Select your birth date";
                        } else {
                          _checkAge(selectedDate);
                          birthdateController.text = selectedDate;
                        }
                      },
                      prefixIcon: Icons.calendar_month,
                    ),
                    ProfileCustomTextField(
                      hintText: 'Enter Driving Licence Number',
                      controller: licenceNumberController,
                      textInputType: TextInputType.number,
                      validatorMsg: "please enter driving licence number",
                      isValidator: true,
                      //   prefixIcon: Icons.calendar_month,
                    ),
                    ProfileCustomTextField(
                      hintText: 'Enter Licence Expiry Date',
                      controller: licenseExpiryDateController,
                      textInputType: TextInputType.number,
                      validatorMsg: "please enter licence expiry date",
                      isValidator: true,
                        onTap: () async {
                          String selectedDate = await DateTimePickerDialog()
                              .pickDateAfterDialog(context,DateFormat("yyyy-MM-dd").format(DateTime.now()));
                          if (selectedDate.isEmpty) {
                            licenseExpiryDateController.text = "Select licence expiry Date";
                          } else {
                            _checkAge(selectedDate);
                            licenseExpiryDateController.text = selectedDate;
                          }
                        }
                    ),
                    ProfileCustomTextField(
                      hintText: 'Enter Social Security Number',
                      controller: ssnController,
                      textInputType: TextInputType.number,
                      validatorMsg: "please enter social security number",
                      isValidator: true,
                      //  prefixIcon: Icons.calendar_month,
                    ),
                   /* dropDwon(),
                    SizedBox(
                      height: 10,
                    ),*/
                    CustomDropdownList(
                      hintText: "Select Gender",
                      items: genderList,
                      selectedType: selectedGender??genderList[0],
                      onChange: (String value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: ProfileCustomTextField(
                              onTap: () async {
                                onlineTime =
                                await DateTimePickerDialog()
                                    .selectTime(context);
                                if (onlineTime == null) {
                                  onlineTimeController.text =
                                  "Select Online Time";
                                } else {
                                  onlineTimeController.text = onlineTime!;
                                }
                                setState(() {});
                              },
                              controller: onlineTimeController,
                              hintText: "Online Time",
                              isValidator:true,
                              readOnly: true,
                              textInputType: TextInputType.text,
                              validatorMsg: "Select online time",
                              iconData: Icons.lock),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: ProfileCustomTextField(
                              onTap: () async {
                                offlineTime =
                                await DateTimePickerDialog()
                                    .selectTime(context);
                                if (offlineTime == null) {
                                  offlineController.text =
                                  "Select Offline Time";
                                } else {
                                  offlineController.text =
                                  offlineTime!;
                                }
                                setState(() {});
                              },
                              controller: offlineController,
                              hintText: "Offline Time",
                              isValidator:true,
                              readOnly: true,
                              validatorMsg: "Select offline time",
                              textInputType: TextInputType.text,
                              iconData: Icons.lock),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  bool _result = false;

  _checkAge(String dob) {
    // Get the birthdate from the text field
    DateTime birthdate = DateTime.parse(dob);

    // Calculate the age
    DateTime now = DateTime.now();
    int age = now.year - birthdate.year;
    if (now.month < birthdate.month ||
        (now.month == birthdate.month && now.day < birthdate.day)) {
      age--;
    }

    // Check if age is below 18
    if (age < 18) {
      setState(() {
        _result = false;
      });
    } else {
      setState(() {
        _result = true;
      });
    }
  }

  void registeruser() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse apiResponse = await registrationProvider.RegisterUser(
          fnameController.text,
          lnameController.text,
          emailController.text,
          birthdateController.text,
          selectedGender.toString(),
          mob,
          licenceNumberController.text,
          licenseExpiryDateController.text,
          'Maharashtra',
          onlineTimeController.text,
          offlineController.text,
          ssnController.text,
          "online",
          imgPath,
          "Pending"
      );
      final register = json.decode(apiResponse.response);
      print(register);
      if (apiResponse.status == 200 ||apiResponse.status==201) {
        if (register["success"] == true) {
          print("MAIN SCREEN RESPONSE${register["message"]}");
          int userId = register["data"]["id"];
         print(userId.toString());
          String response = jsonEncode(register);
          LocalSharePreferences()
              .setString(SharedPreferencesConstan.LoginKey, response);
          DriverModel  userData= await LocalSharePreferences().getLoginData();
          int? uId= userData.data!.id;
          Navigator.pushReplacementNamed(context, AppRoutes.driverCabRegistration);
        } else {
          print("MAIN SCREEN ELSE RESPONSE${register["message"]}");
          SnackBar snackBar = SnackBar(
            content: Text(register["message"]),
            duration: Duration(seconds: 5),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } else {
        SnackBar snackBar = SnackBar(
          content: Text("${apiResponse.status} ${register["message"]}"),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      SnackBar snackBar = const SnackBar(
        content: Text("Please fill required data"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
