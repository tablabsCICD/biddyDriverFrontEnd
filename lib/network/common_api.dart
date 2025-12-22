import 'dart:convert';

import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/network/api_helper.dart';

import '../model/driverinfo.dart';
import '../model/base_model/driver_model.dart';
import '../util/sharepreferences.dart';

class CommonApi {



  Future<DriverDetailsInfo> getDriverOnlineOffLineInfo()async{
   DriverModel  userData= await LocalSharePreferences().getLoginData();
   int? uId= userData.data!.id;
   print(uId);
   print('the data is ${APIConstants.GETINFOOFDRIVER+uId.toString()}');
   ApiResponse response=await AppConstant.apiHelper.ApiGetData(APIConstants.GETINFOOFDRIVER+uId.toString());
   final body = json.decode(response.response);
   print('the response is ${response.response}');
    return DriverDetailsInfo.fromJson(body);

  }
  
  
}