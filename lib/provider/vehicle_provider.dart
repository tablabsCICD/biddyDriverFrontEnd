import 'dart:convert';

import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/bank_reponse.dart';
import 'package:biddy_driver/model/base_model/bank_model.dart';
import 'package:biddy_driver/model/base_model/vehicle_model.dart';
import 'package:biddy_driver/model/driverinfo.dart';
import 'package:biddy_driver/model/saveDriverCabDetails.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/network/common_api.dart';
import 'package:biddy_driver/provider/provider.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/model/cabDetails.dart';
import 'package:biddy_driver/util/get_date.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant/api_constant.dart';

class VehicleProvider extends BaseProvider {

  VehicleProvider(BuildContext context):super(""){
    getVehicleList(context);

  }

  Future<ApiResponse> cabRegister(cab)async{
    CabDetails cabDetails = cab;
    String date = DateTime.now().toUtc().toIso8601String();
    appState="Busy";
    notifyListeners();
    Map<String,dynamic> data = {
      "carPhoto": cabDetails.carPhoto,
      "color": "White",
      "copofRegistration": cabDetails.copofRegistration,
      "copyofInsurance": cabDetails.copyofInsurance,
      "copyofStateInspection": cabDetails.copyofStateInspection,
      "copyofTNCInspection": cabDetails.copyofTNCInspection,
      "createdDate": date,
      "document": cabDetails.copofRegistration,
      "driverId": cabDetails.driverId,
      "id": 0,
      "make": cabDetails.make,
      "model": cabDetails.model,
      "selected": "true",
      "typeOfVehicle": cabDetails.typeOfVehicle,
      "updatedDate": date,
      "validateDate": GetDateFormat.getCurrentDate(),
      "vehicleLicensePlateNumber": cabDetails.vehicleLicensePlateNumber,
      "vinNumber": cabDetails.vinNumber,
      "year": cabDetails.year
    };
    ApiResponse apiResponse =await AppConstant.apiHelper.postDataArgument(APIConstants.CABREGISTER,data);
    print("Cab registration Response : ${apiResponse.response}");

    if(apiResponse.status==200||apiResponse.status==201){

      appState="Ideal";
      notifyListeners();
      print('the sccussess:${apiResponse.response}');
      //class name=jsonEncode(apiResponse.response);
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }else{
      appState="Ideal";
      notifyListeners();
      print('the Failed:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }
  }

  List<Vehicle> vehicleList = [];
  bool isLoading = false;

  getVehicleList(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    DriverModel  userData= await LocalSharePreferences().getLoginData();
    int? uId= userData.data!.id;
    print('the data is ${APIConstants.GETINFOOFDRIVER+uId.toString()}');
    ApiResponse apiResponse=await AppConstant.apiHelper.ApiGetData(APIConstants.GETINFOOFDRIVER+uId.toString());
    isLoading = false;
    if(apiResponse.status==200||apiResponse.status==201){
      final res = json.decode(apiResponse.response);
      print('the sccussess:${apiResponse.response}');
      DriverDetailsInfo detailsInfo= await CommonApi().getDriverOnlineOffLineInfo();
      if(detailsInfo.success==true){
        vehicleList.addAll(detailsInfo.data!);
      }
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }else{
      appState="Ideal";
      notifyListeners();
      print('the Failed:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }
  }

  Future<ApiResponse> updateVehicle(cab)async{
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    CabDetails cabDetails = cab;
    String myUrl = APIConstants.UPDATECAB+"${cabDetails.id}";
    print(myUrl);
    appState="Busy";
    notifyListeners();
    Map<String,dynamic> data = {
      "carPhoto": cabDetails.carPhoto,
      "color": "White",
      "copofRegistration": cabDetails.copofRegistration,
      "copyofInsurance": cabDetails.copyofInsurance,
      "copyofStateInspection": cabDetails.copyofStateInspection,
      "copyofTNCInspection": cabDetails.copyofTNCInspection,
      "createdDate": date,
      "document": cabDetails.copofRegistration,
      "driverId": cabDetails.driverId,
      "id": cabDetails.id,
      "make": cabDetails.make,
      "model": cabDetails.model,
      "selected": "true",
      "typeOfVehicle": cabDetails.typeOfVehicle,
      "updatedDate": date,
      "validateDate": date,
      "vehicleLicensePlateNumber": cabDetails.vehicleLicensePlateNumber,
      "vinNumber": cabDetails.vinNumber,
      "year": cabDetails.year
    };
    ApiResponse apiResponse =await AppConstant.apiHelper.putDataArgument(myUrl,data);
    print("Cab registration Response : ${apiResponse.response}");

    if(apiResponse.status==200||apiResponse.status==201){

      appState="Ideal";
      notifyListeners();
      print('the sccussess:${apiResponse.response}');
      //class name=jsonEncode(apiResponse.response);
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }else{
      appState="Ideal";
      notifyListeners();
      print('the Failed:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }
  }

  deleteVehicle(Vehicle vehicle) async {
    String myUrl = APIConstants.DELETECAB+"${vehicle.id}";
    print(myUrl);
    appState="Busy";
    notifyListeners();
    ApiResponse apiResponse =await AppConstant.apiHelper.ApiDeleteData(myUrl);
    print("Response : ${apiResponse.response}");

    if(apiResponse.status==200||apiResponse.status==201){
      print('the sccussess:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      vehicleList.remove(vehicle);
      return apiResponse;
    }else{
      print('the Failed:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }
  }
}