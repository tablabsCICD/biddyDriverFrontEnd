
import 'dart:convert';
import 'dart:typed_data';
import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/provider/vehicle_provider.dart';
import 'package:biddy_driver/widgets/app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:biddy_driver/provider/registration_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../route/app_routes.dart';
import '../../model/cabDetails.dart';
import '../../widgets/button.dart';


class RegistrationCopy extends StatefulWidget{

  CabDetails saveDriverDetails;
  RegistrationCopy({Key? key, required this.saveDriverDetails}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return RegistrationCopyState(saveDriverDetails);
  }
}

class RegistrationCopyState extends State<RegistrationCopy>{
  late VehicleProvider cabregistrationProvider;
  TextEditingController registrationCopyController = TextEditingController();
  TextEditingController tncCopyController = TextEditingController();
  TextEditingController stateCopyController = TextEditingController();
  TextEditingController insuranceController = TextEditingController();

  CabDetails cabDetails;
  RegistrationCopyState(this.cabDetails);


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) =>VehicleProvider(context),
      builder: (context, child) => _buildPage(context),
    );
  }

  String RCPath = '';
  String ICPath = '';
  String SCPath = '';
  String TCPath = '';
  String documentPath = '';
  PlatformFile? objFile;
  Uint8List? imageBytes;
  String? fileName;
  String? uploadedDocument;

  pickFile(bool isRC,bool isSC,bool isIC,bool isTC) async {

    var result = await FilePicker.platform.pickFiles(
      withReadStream:
      true, // this will return PlatformFile object with read stream
    );
    if (result != null) {
      setState(() {
        objFile = result.files.single;

        if (isRC) {
          registrationCopyController.text = result.files.first.name;
        }
        if (isIC) {
          insuranceController.text = result.files.first.name;
        }
        if (isSC) {
          stateCopyController.text = result.files.first.name;
        }
        if (isTC) {
          tncCopyController.text = result.files.first.name;
        }
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
            if (isRC) {
              RCPath = stringWithoutQuotes;
            }
            if (isIC) {
              ICPath = stringWithoutQuotes;
            }
            if (isSC) {
              SCPath = stringWithoutQuotes;
            }
            if (isTC) {
              TCPath = stringWithoutQuotes;
            }
            print("Uploaded Img Path From s3 bucket::" +
                RCPath );
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

  _buildPage(context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
          child: AppButton(buttonTitle: "Register", onClick: (){
      
      
           if (_formKey.currentState!.validate()) {
              cabRegister();
            } else {
              SnackBar snackBar = const SnackBar(
                content: Text("Please fill required data"),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          }, enbale: true),
        ),
        appBar: ApplicationAppBar().commonAppBar(context, "Upload Documents"),
        body: Consumer<VehicleProvider>(
          builder: (context, provider, child) {
            this.cabregistrationProvider = provider;
            return  Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                  /* ProfileCustomTextField(
                      hintText: 'click here to upload registration copy',
                      controller: registrationCopyController,
                      textInputType: TextInputType.text,
                      validatorMsg: "please upload registration copy",
                      isValidator: true,
                      onTap: (){
                        pickFile(true,0);
                      },
                    ),
                    ProfileCustomTextField(
                      hintText: 'click here to upload state copy',
                      controller: stateCopyController,
                      textInputType: TextInputType.text,
                      validatorMsg: "please upload stae copy",
                      isValidator: true,
                      onTap: (){
                        pickFile(true,1);
                      },
                    ),
                    ProfileCustomTextField(
                      hintText: 'click here to upload insurance copy',
                      controller: insuranceController,
                      textInputType: TextInputType.text,
                      validatorMsg: "please upload insurance copy",
                      isValidator: true,
                      onTap: (){
                        pickFile(true,2);
                      },
                    ),
                    ProfileCustomTextField(
                      hintText: 'click here to upload tnc copy',
                      controller: tncCopyController,
                      textInputType: TextInputType.text,
                      validatorMsg: "please upload tnc copy",
                      isValidator: true,
                      onTap: (){
                        pickFile(true,3);
                      },
                    ),*/
                    GestureDetector(
                      onTap: () async {
                        pickFile(true,false,false,false);
                      },
                      child: Container(
                        height: 120,
                        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white
                        ),
                        child: registrationCopyController.text.isEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_file,size: 70,color: Colors.grey[300],),
                            SizedBox(height: 10,),
                            Text("Upload Vehicle Registration Copy",style: TextStyle(fontSize: 14,color: Colors.grey),)
                          ],
                        ):Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(RCPath)))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        pickFile(false,true,false,false);
                      },
                      child: Container(
                        height: 120,
                        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white
                        ),
                        child: stateCopyController.text.isEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_file,size: 70,color: Colors.grey[300],),
                            SizedBox(height: 10,),
                            Text("Upload State Copy",style: TextStyle(fontSize: 14,color: Colors.grey),)
                          ],
                        ):Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(SCPath)))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        pickFile(false,false,true,false);
                      },
                      child: Container(
                        height: 120,
                        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white
                        ),
                        child: insuranceController.text.isEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_file,size: 70,color: Colors.grey[300],),
                            SizedBox(height: 10,),
                            Text("Upload Insurance Copy",style: TextStyle(fontSize: 14,color: Colors.grey),)
                          ],
                        ):Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(ICPath)))),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        pickFile(false,false,false,true);
                      },
                      child: Container(
                        height: 120,
                        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white
                        ),
                        child: tncCopyController.text.isEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.upload_file,size: 70,color: Colors.grey[300],),
                            SizedBox(height: 10,),
                            Text("Upload TNC Copy",style: TextStyle(fontSize: 14,color: Colors.grey),)
                          ],
                        ):Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(TCPath)))),
                      ),
                    ),
                  /*  Center(
                      child: TextView(
                        title: "OR",
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        pickFile(true);
                      },
                      child: Container(
                        height: 150,
                        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white
                        ),
                        child: registrationCopyController.text.isEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt,size: 100,color: Colors.grey[300],),
                            SizedBox(height: 16,),
                            Text("Upload Registration Copy",style: TextStyle(fontSize: 14,color: Colors.grey),)
                          ],
                        ):Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(imgPath)))),
                      ),
                    ),
                    Divider(),
                    ProfileCustomTextField(
                      hintText: 'click here to upload insurance copy',
                      controller: insuranceController,
                      textInputType: TextInputType.text,
                      validatorMsg: "please upload insurance copy",
                      isValidator: true,
                      onTap: (){
                        pickFile(true);
                      },
                    ),
                    Center(
                      child: TextView(
                        title: "OR",
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        pickFile(true);
                      },
                      child: Container(
                        height: 150,
                        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: Colors.grey),
                            color: Colors.white
                        ),
                        child: insuranceController.text.isEmpty?Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt,size: 100,color: Colors.grey[300],),
                            SizedBox(height: 16,),
                            Text("Upload Insurance Copy",style: TextStyle(fontSize: 14,color: Colors.grey),)
                          ],
                        ):Container(
                            width: 100.0,
                            height: 100.0,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: new NetworkImage(documentPath)))),
                      ),
                    ),*/
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  void cabRegister() async {
    if (_formKey.currentState!.validate()) {
      CabDetails cab = CabDetails(
          driverId: cabDetails.driverId,
          model: cabDetails.model,
          make: cabDetails.make,
          typeOfVehicle: cabDetails.typeOfVehicle,
          vehicleLicensePlateNumber: cabDetails.vehicleLicensePlateNumber,
          vinNumber: cabDetails.vinNumber,
          year: cabDetails.year,
        copyofTNCInspection: TCPath,
        copyofStateInspection: SCPath,
        copyofInsurance: ICPath,
        copofRegistration: RCPath
      );
      ApiResponse cabregister = await cabregistrationProvider.cabRegister(cab);
      final response = json.decode(cabregister.response);

      if (cabregister.status == 200 || cabregister.status == 201) {

        print("MAIN SCREEN RESPONSE${response["message"]}");
        Navigator.pushReplacementNamed(context, AppRoutes.direverCar);

      } else {
        SnackBar snackBar = SnackBar(
          content: Text("${cabregister.status} something went wrong!!"),
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