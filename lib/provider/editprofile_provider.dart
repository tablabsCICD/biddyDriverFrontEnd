import 'dart:convert';

import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/provider/provider.dart';
import 'package:biddy_driver/util/get_date.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class EditProfileProvider extends BaseProvider {

  EditProfileProvider(BuildContext context):super(''){
    inData();
  }

  DriverModel? userData;
  void inData() async {
    userData= await LocalSharePreferences().getLoginData();
    getDriverDetails();
   notifyListeners();
  }

  TextEditingController firstNameController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passwordController = TextEditingController();

  setData(){
    firstNameController.text = userData!.data!.firstName!;
    lastNameController.text = userData!.data!.lastName!;
    emailController.text = userData!.data!.emailId??'';
    mobileController.text = userData!.data!.phoneNumber??'';
    passwordController.text = userData!.data!.password??'';
  }

 editProfile()async {
      String myUrl = APIConstants.EDIT_PROFILR;
   Map<String, dynamic> data = {
       "backgroundCheckDate": userData!.data!.backgroundCheckDate,
       "backgroundCheckStatus": userData!.data!.backgroundCheckDate,
       "createdDate":   userData!.data!.createdDate,
       "deviceId":  userData!.data!.deviceId,
       "dob":  userData!.data!.dob,
       "driverLicensenExpirationDate":  userData!.data!.driverLicensenExpirationDate,
       "driverLicensenState":  userData!.data!.driverLicensenumber,
       "emailId": emailController.text,
       "first_name": firstNameController.text,
       "id":  userData!.data!.id,
       "isActive":  userData!.data!.isActive,
       "isBook":  userData!.data!.isBook,
       "last_name": lastNameController.text,
       "offlineTime":  userData!.data!.offlineTime,
       "onlineTime":  userData!.data!.onlineTime,
       "os":  userData!.data!.os,
       "otp":  userData!.data!.otp,
       "password":  userData!.data!.password,
       "phoneNumber":  userData!.data!.phoneNumber,
       "photo":  userData!.data!.photo,
       "preferedRoute":  userData!.data!.preferedRoute,
       "registerState":  userData!.data!.registerState,
       "socialSecurityNumber":  userData!.data!.socialSecurityNumber,
       "status":  userData!.data!.status,
       "updatedDate": GetDateFormat.getCurrentDate(),
       "zone":  userData!.data!.zone

    };
  
   ApiResponse apiResponse= await AppConstant.apiHelper.ApiPutDataWithBody(myUrl,data);
   print("Api response"+ apiResponse.status.toString());
    notifyListeners();
    return apiResponse;
  }

  getDriverDetails() async {
    String myUrl = APIConstants.BASE_URL+"api/driver-details/${userData!.data!.id}";
    print(myUrl);
    appState="Busy";
    notifyListeners();
    ApiResponse apiResponse =await AppConstant.apiHelper.ApiGetData(myUrl);
    print("Response : ${apiResponse.response}");
    if(apiResponse.status==200||apiResponse.status==201){
      final driverResponse = json.decode(apiResponse.response);
      userData = DriverModel.fromJson(driverResponse);
      setData();
      print('the sccussess:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }else{
      print('the Failed:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }
  }

  deleteAccount(DriverModel userData) async {
    String myUrl = APIConstants.BASE_URL+"api/driver-details/${userData.data!.id}";
    print(myUrl);
    appState="Busy";
    notifyListeners();
    ApiResponse apiResponse =await AppConstant.apiHelper.ApiDeleteData(myUrl);
    print("Response : ${apiResponse.response}");

    if(apiResponse.status==200||apiResponse.status==201){
      print('the sccussess:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }else{
      print('the Failed:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }
  }


  profilePhotoUpload(){
    //AppConstant.apiHelper.ApiPutData(URL)

  }


}