import 'dart:convert';

import 'package:biddy_driver/model/activeRideResponse.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/bank_reponse.dart';
import 'package:biddy_driver/model/base_model/bank_model.dart';
import 'package:biddy_driver/model/ride_status_change_response.dart';
import 'package:biddy_driver/model/saveDriverCabDetails.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/provider/provider.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/model/cabDetails.dart';
import 'package:biddy_driver/route/app_routes.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant/api_constant.dart';
import '../model/base_model/ride_model.dart';

class RideProvider extends BaseProvider {

  RideProvider(BuildContext context):super(""){
    getRideListByDriverId(context);

  }


  List<RideData> rideList = [];
  List<RideData> activeRideList = [];
  List<RideData> cancelledRideList = [];
  List<RideData> completedRideList = [];
  bool isLoading = false;

  getRideListByDriverId(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    DriverModel  userData= await LocalSharePreferences().getLoginData();
    int? uId= userData.data!.id;
    String myUrl = APIConstants.ALL_RIDE_DRIVERID+uId.toString();
    print("get ride:"+myUrl);
    ApiResponse apiResponse = await AppConstant.apiHelper.ApiGetData(myUrl);
    if(apiResponse.status==200){
      final res = json.decode(apiResponse.response);
      print('the sccussess:${apiResponse.response}');
      ActiveRideListResponse rideBooking=ActiveRideListResponse.fromJson(res);
      rideList.addAll(rideBooking.data!);
      if(rideBooking.data!.isEmpty){
        SnackBar snackBar = SnackBar(
          content: Text("Your don't have any ride history"),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        rideList.forEach((element) {
          if(element.status==AppConstant.status_accepted){
            activeRideList.add(element);
          }else if(element.status == AppConstant.status_end_ride){
            completedRideList.add(element);
          }else if(element.status == AppConstant.status_accepted){
            cancelledRideList.add(element);
          }
        });
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

  bool isLoad = false;
  changeStatus(BuildContext context,String status,RideData rideData) async {
    isLoad = true;
    notifyListeners();

    String url = APIConstants.RIDE_STATUS_CHANGE;
    print(url);
    ApiResponse apiResponse = await AppConstant.apiHelper
        .putDataArgument(url,{
      "id": rideData.id,
      "status": status
    });
    print(apiResponse.response);
    var res = jsonDecode(apiResponse.response);
    if(apiResponse.status==200){
      RideStatusChangeResponse rideAcceptResponse = RideStatusChangeResponse.fromJson(res);
      rideData = rideAcceptResponse.data!;
      if(status.compareTo(AppConstant.status_end_ride)==0){
        Navigator.pushReplacementNamed(context, AppRoutes.endride,arguments: rideData);
      }
    }else{

    }
  }

}


