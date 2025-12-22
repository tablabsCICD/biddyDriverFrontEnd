import 'dart:convert';

import 'package:biddy_driver/constant/imageconstant.dart';
import 'package:biddy_driver/constant/prefrenseconstant.dart';
import 'package:biddy_driver/constant/text_constant.dart';
import 'package:biddy_driver/provider/editprofile_provider.dart';
import 'package:biddy_driver/route/app_routes.dart';

import 'package:biddy_driver/util/camerabottomsheet.dart';
import 'package:biddy_driver/util/colors.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:biddy_driver/widgets/app_bar.dart';
import 'package:biddy_driver/widgets/button.dart';
import 'package:biddy_driver/widgets/profile_custom_textfeild.dart';
import 'package:biddy_driver/widgets/toast.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../constant/api_constant.dart';
import '../../constant/app_constant.dart';
import '../../model/api_response.dart';
import '../../model/base_model/driver_model.dart';

class UpdateProfileScreen extends StatefulWidget {

  UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UpdateProfileState();
  }

}

class UpdateProfileState extends State<UpdateProfileScreen>{
  final _formKey = GlobalKey<FormState>();
  UpdateProfileState();



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => EditProfileProvider(context),
      builder: (context, child) => _buildPage(context),
    );
  }


  _buildPage(BuildContext context) {

    return Consumer<EditProfileProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: ApplicationAppBar().commonAppBar(context, "Edit Profile"),
          bottomNavigationBar: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 120,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.0), // Adjust as needed
                    border: Border.all(
                      color: Colors.grey, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Delete Account',style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w600,
                            ),),
                            content: Text('Are you sure you want to delete your account?',style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('No',style: TextStyle(color: ThemeColor.theme_blue, fontSize: 12,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w600,),),
                              ),
                              TextButton(
                                onPressed: () async {
                                  ApiResponse apiResponse = await provider.deleteAccount(provider.userData!);
                                  final response = json.decode(apiResponse.response);

                                  if(response["success"]==true){
                                    ToastMessage.show(context, response["message"]);
                                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.entryScreen, (route) => false) ;
                                  }else{
                                    ToastMessage.show(context, response["message"]);
                                  }
                                  Navigator.of(context).pop();// Close the dialog

                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.green, fontSize: 12,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w600,),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        foregroundColor: Colors.red,
                        shape: const StadiumBorder(),
                        side: BorderSide.none),
                    child:  Text(TextConstant.delete_account),
                  ),
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                      buttonTitle: 'Update Profile',
                      onClick: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Update Profile',style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w600,
                              ),),
                              content: Text('Are you sure you want to update your profile?',style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                fontWeight: FontWeight.w400,
                              ),),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('No',style: TextStyle(color: ThemeColor.theme_blue, fontSize: 12,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w600,),),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      ApiResponse res = await provider.editProfile();
                                      final response = json.decode(res.response);
                                      if(response["success"]==true){
                                        ToastMessage.show(context, response["message"]);
                                      }else{
                                        ToastMessage.show(context, response["message"]);
                                      }
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.green, fontSize: 12,
                                      fontFamily: GoogleFonts.poppins().fontFamily,
                                      fontWeight: FontWeight.w600,),
                                  ),
                                ),
                              ],
                            );
                          },
                        );


                      }, enbale: true),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:  Image(image: AssetImage(ImageConstant.PROFILE_IMAGE))),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration:
                            BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.grey),
                            child:  InkWell(onTap: ()async{
                              XFile file =await CameraBottomsheet().show(context);
                            },child: Icon(Icons.camera, color: Colors.black, size: 20)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                
                    // -- Form Fields
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height-400,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ProfileCustomTextField(
                                hintText: TextConstant.firstname,
                                controller: provider.firstNameController,
                                textInputType: TextInputType.text,
                                validatorMsg: TextConstant.fullname,
                                isValidator: true,
                                // isName: true,
                                prefixIcon: Icons.account_circle_outlined,
                              ),
                              ProfileCustomTextField(
                                hintText: TextConstant.lastname,
                                controller: provider.lastNameController,
                                textInputType: TextInputType.text,
                                validatorMsg: TextConstant.fullname,
                                isValidator: true,
                                // isName: true,
                                prefixIcon: Icons.account_circle_outlined,
                              ),
                              ProfileCustomTextField(
                                hintText: TextConstant.email,
                                controller: provider.emailController,
                                textInputType: TextInputType.emailAddress,
                                validatorMsg: TextConstant.email,
                                isValidator: true,
                                isEmail: true,
                                prefixIcon: Icons.email_outlined,
                              ),
                              //const SizedBox(height: 20),
                              ProfileCustomTextField(
                                hintText: TextConstant.mobile,
                                controller: provider.mobileController,
                                textInputType: TextInputType.number,
                                validatorMsg: TextConstant.mobile,
                                isValidator: true,
                                isPhoneNumber: true,
                                prefixIcon: Icons.phone_outlined,
                              ),
                
                              //const SizedBox(height: 20),
                             /* ProfileCustomTextField(
                                hintText: TextConstant.password,
                                controller: passwordController,
                                textInputType: TextInputType.text,
                                validatorMsg: TextConstant.password,
                                isValidator: true,
                                prefixIcon: Icons.lock_outline,
                              ),*/
                
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }



}