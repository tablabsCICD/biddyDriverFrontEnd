

import 'dart:convert';

import 'package:biddy_driver/provider/provider.dart';
import 'package:biddy_driver/constant/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/api_response.dart';
import '../constant/app_constant.dart';

class LoginProvider extends BaseProvider {
  LoginProvider(super.appState);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> setUserData(String data) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("UserSession", data);
    prefs.setBool("isLoggedIn", true);
  }

  Future<ApiResponse> sendOtp(String mobileNumber)async{
    print('the number is $mobileNumber');
    appState="Busy";
    notifyListeners();
    print('the url is ${APIConstants.SENDOTP+mobileNumber}');
    ApiResponse apiResponse =await AppConstant.apiHelper.ApiPostData(APIConstants.SENDOTP+mobileNumber);
    if(apiResponse.status==200){
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }else{
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }
  }

  Future<ApiResponse> VerifyOtp(String mobileNumber, String otp)async{
    print('the number is $mobileNumber');
    appState="Busy";
    notifyListeners();
    ApiResponse apiResponse =await AppConstant.apiHelper.ApiPostData(APIConstants.VERIFYOTP+"otp=${otp}&mobileNumber=${mobileNumber}");
    if(apiResponse.status==200) {
      appState = "Ideal";
      notifyListeners();
      return apiResponse;
    }else{
      appState = "Ideal";
      notifyListeners();
      return apiResponse;
    }
  }
}

