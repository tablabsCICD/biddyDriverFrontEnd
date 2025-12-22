import 'dart:convert';
import 'dart:typed_data';
import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/provider/vehicle_provider.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:biddy_driver/widgets/app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:biddy_driver/provider/registration_provider.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:biddy_driver/widgets/profile_custom_textfeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../route/app_routes.dart';
import '../../model/cabDetails.dart';
import '../../widgets/button.dart';
import '../../widgets/text_input_Field.dart';

class DriverCabRegistration extends StatefulWidget {
 /* CabDetails saveDriverDetails;
*/
  DriverCabRegistration({Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DriverCabRegistrationState();
  }
}

class DriverCabRegistrationState extends State<DriverCabRegistration> {
  late VehicleProvider cabregistrationProvider;

  TextEditingController maxNumberOfPassengersController =
      TextEditingController();
  TextEditingController vehiclemodelController = TextEditingController();
  TextEditingController vehicelsCompanyController = TextEditingController();
  TextEditingController vehicelsNumberController = TextEditingController();
  TextEditingController vehicelcategoryController = TextEditingController();
  TextEditingController vinNumberCopyController = TextEditingController();
  TextEditingController registrationCopyController = TextEditingController();
  TextEditingController tncCopyController = TextEditingController();
  TextEditingController stateCopyController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();

  final List<String> yearList = [
    '2024',
    '2023',
    '2022',
    '2021',
    '2020',
    '2019',
    '2018',
    '2017',
    '2016',
    '2015',
    '2014',
    '2013',
    '2012',
    '2011',
    '2010',
    '2009',
    '2008',
    '2007',
    '2006',
    '2005',
    '2004',
    '2003',
    '2002',
    '2001',
    '2000',
  ];
  String? selectedYear;
  final List<String> categoryList = ['MINI', 'MACRO', 'AUTO', 'BIKE'];
  String? selectedVehicleType;
  //CabDetails cabDetails;

  DriverCabRegistrationState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => VehicleProvider(context),
      builder: (context, child) => _buildPage(context),
    );
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
        registrationCopyController.text = result.files.first.name;
      });
      try {
        fileName = result.files.first.name;
        print(result.files.first.toString());
        imageBytes = result.files.first.bytes;
        print(fileName);
        print(await result.files.first.toString().length);
        if (await result.files.first.toString().length >= 500) {
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
          Map<String, String> headers = {"Content-Type": "multipart/form-data"};
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

  final _formKey = GlobalKey<FormState>();

  dropDwon(bool isYear, List<String> items) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 0),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Colors.black54),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: DropdownButton(
          hint: TextView(
            title: isYear ? "Select year" : "Select Cab Category",
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
          items: items
              .map((value) => DropdownMenuItem(
                    value: value,
                    child: Container(
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
          value: isYear ? selectedYear : selectedVehicleType,
          onChanged: (value) {
            setState(() {
              if (isYear) {
                selectedYear = value as String;
              } else {
                selectedVehicleType = value as String;
              }
            });
          },
        ));
  }

  _buildPage(context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: AppButton(
              buttonTitle: "Next",
              onClick: () async {
               // cabRegister();
                DriverModel userData= await LocalSharePreferences().getLoginData();
                CabDetails cab = CabDetails(
                    driverId: userData.data!.id,
                    model: vehiclemodelController.text,
                    make: vehicelsCompanyController.text,
                    typeOfVehicle: selectedVehicleType,
                    vehicleLicensePlateNumber: vehicelsNumberController.text,
                    vinNumber: vinNumberCopyController.text,
                    year: selectedYear);
                Navigator.pushNamed(context, AppRoutes.uploadRegistrationCopy,
                    arguments: cab);

              },
              enbale: true),
        ),
        appBar: ApplicationAppBar().commonAppBar(context, "Add Vehicle"),
        body: Consumer<VehicleProvider>(
          builder: (context, provider, child) {
            this.cabregistrationProvider = provider;
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        pickFile(true);
                      },
                      child: Container(
                        height: 120,
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white),
                        child: registrationCopyController.text.isEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 70,
                                    color: Colors.grey[300],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Upload Car Image",
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey),
                                  )
                                ],
                              )
                            : Container(
                                width: 100.0,
                                height: 100.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(imgPath)))),
                      ),
                    ),
                    ProfileCustomTextField(
                      hintText: 'Enter vehicle company Name',
                      controller: vehicelsCompanyController,
                      textInputType: TextInputType.text,
                      validatorMsg: "please enter vehicle company name",
                      isValidator: true,
                      isName: true,
                    ),
                    ProfileCustomTextField(
                      hintText: 'Enter Vehicle Model',
                      controller: vehiclemodelController,
                      textInputType: TextInputType.text,
                      validatorMsg: "please enter vehicle model",
                      isValidator: true,
                    ),
                    ProfileCustomTextField(
                      hintText: 'Enter Vehicle Number',
                      controller: vehicelsNumberController,
                      textInputType: TextInputType.text,
                      validatorMsg: "please enter your vehicle number",
                      isValidator: true,
                    ),
                    dropDwon(true, yearList),
                    dropDwon(false, categoryList),
                    ProfileCustomTextField(
                      hintText: 'VIN Number',
                      controller: vinNumberCopyController,
                      textInputType: TextInputType.text,
                      validatorMsg: "please enter vin number",
                      isValidator: true,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}
