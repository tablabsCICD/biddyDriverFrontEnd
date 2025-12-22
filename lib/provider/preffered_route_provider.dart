import 'dart:convert';

import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/bank_reponse.dart';
import 'package:biddy_driver/model/base_model/bank_model.dart';
import 'package:biddy_driver/model/base_model/preffered_route.dart';
import 'package:biddy_driver/model/response/get_routes_response.dart';
import 'package:biddy_driver/model/saveDriverCabDetails.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/provider/provider.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/model/cabDetails.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant/api_constant.dart';

class PrefferedRouteProvider extends BaseProvider {

  PrefferedRouteProvider(BuildContext context):super(""){
    getRoutesByDriverId(context);

  }

  Future<ApiResponse> addPrefferedRouteApi(BuildContext context,
      String source,
      String destination
      )async{
    DriverModel  userData= await LocalSharePreferences().getLoginData();
    int? uId= userData.data!.id;
    appState="Busy";
    notifyListeners();
    Map<String, dynamic> data = {
      "city": "string",
      "destination": destination,
      "driverId": uId,
      "driverLatitude": 0,
      "driverLongitude": 0,
      "pincode": "string",
      "source": source
    };
    print(data);
    ApiResponse apiResponse =await AppConstant.apiHelper.postDataArgument(APIConstants.ADD_ROUTE,data);
    print("Add Route Response : ${apiResponse.response} ${apiResponse.status}");
    if(apiResponse.status==200||apiResponse.status==201){
      getRoutesByDriverId(context);
      appState="Ideal";
      notifyListeners();
      print('the sccussess:${apiResponse.response}');
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

  List<PrefferedRoute> routeList = [];
  bool isLoading = false;

  getRoutesByDriverId(BuildContext context) async {
    DriverModel  userData= await LocalSharePreferences().getLoginData();
    int? uId= userData.data!.id;
    isLoading = true;
    notifyListeners();
   String myUrl = APIConstants.VIEW_ROUTE + "$uId";
   // String myUrl = APIConstants.BASE_URL +'api/getAll?page=0&size=10&sortDir=asc';
    print(myUrl);
    ApiResponse apiResponse =await AppConstant.apiHelper.ApiGetData(myUrl);
    print("Route List Response : ${apiResponse.response} ${apiResponse.status}");
    isLoading = false;
    if(apiResponse.status==200||apiResponse.status==201){
      final res = json.decode(apiResponse.response);
      print('the sccussess:${apiResponse.response}');
      GetAllPrefferedRoute getAllRouteResponse = GetAllPrefferedRoute.fromJson(res);
      if(getAllRouteResponse.success==true){
        routeList.addAll(getAllRouteResponse.data!);
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


  deleteRoute(PrefferedRoute prefferedRoute) async {
    String myUrl = APIConstants.DELETE_ROUTE+"${prefferedRoute.id}";
    print(myUrl);
    appState="Busy";
    notifyListeners();
    ApiResponse apiResponse =await AppConstant.apiHelper.ApiDeleteData(myUrl);
    print("Response : ${apiResponse.response}");

    if(apiResponse.status==200||apiResponse.status==201){
      print('the sccussess:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      routeList.remove(prefferedRoute);
      return apiResponse;
    }else{
      print('the Failed:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }
  }
}