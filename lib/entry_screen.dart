import 'dart:convert';

import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/constant/prefrenseconstant.dart';
import 'package:biddy_driver/model/activeRideResponse.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/driverinfo.dart';
import 'package:biddy_driver/model/response/driverActiveRide.dart';
import 'package:biddy_driver/model/ride_status_change_response.dart';
import 'package:biddy_driver/network/common_api.dart';
import 'package:biddy_driver/route/app_routes.dart';
import 'package:biddy_driver/model/cabDetails.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/base_model/driver_model.dart';

class EntryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EntryState();
  }
}

class EntryState extends State<EntryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Replace spinner with animated icon
              Icon(
                Icons.directions_car,
                size: 60,
                color: Colors.blueAccent,
              ),
              const SizedBox(height: 20),
              // ✅ Engaging loading message
              const Text(
                "Getting things ready for you...",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Please wait while we check your account.",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),

              // ✅ Small progress indicator (optional)
              const LinearProgressIndicator(
                minHeight: 4,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void checkIsLoggedIn() async {
    bool isLogin = await LocalSharePreferences().getBool(
      SharedPreferencesConstan.LoginKeyBool,
    );
    if (isLogin == true) {
      DriverDetailsInfo detailsInfo =
      await CommonApi().getDriverOnlineOffLineInfo();
      AppConstant.info = detailsInfo;
      // ✅ Proper null & empty check
      if (detailsInfo.data == null || detailsInfo.data!.isEmpty) {
        // Show dialog instead of snackbar
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("No Vehicle Found"),
            content: const Text("You don't have any vehicle added. Please add a vehicle to continue."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // close dialog
                  Navigator.pushNamed(
                    context,
                    AppRoutes.driverCabRegistration, // ✅ navigate to your add vehicle screen
                  );
                },
                child: const Text("Add Vehicle"),
              ),
            ],
          ),
        );
      } else {
        if (detailsInfo.data![0].driverId?.isBook == true) {
          callApiRide();
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        }
      }
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }


  void callApiRide() async {
    DriverModel userData = await LocalSharePreferences().getLoginData();
    int? uId = userData.data!.id;
    print("get booked rides:::"+APIConstants.ACTIVE_RIDE_DRIVERID + uId.toString());
    ApiResponse apiResponse = await AppConstant.apiHelper.ApiGetData(
      APIConstants.ACTIVE_RIDE_DRIVERID + uId.toString(),
    );
    var response = jsonDecode(apiResponse.response);
    GetActiveRide getActiveRide = GetActiveRide.fromJson(response);
    if (apiResponse.status == 200) {
      if (getActiveRide.success == true) {
        SnackBar snackBar = SnackBar(
          content: Text(getActiveRide.message.toString()),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (getActiveRide.data == []) {
          SnackBar snackBar = SnackBar(
            content: Text(
              "Your ride is ongoing...but something went wrong to display ongoing ride!!",
            ),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacementNamed(context, AppRoutes.home);
        } else {
          ActiveRideListResponse rideBooking = ActiveRideListResponse.fromJson(
            response,
          );
          if (rideBooking.data!.isEmpty) {
            SnackBar snackBar = SnackBar(
              content: Text(
                "Your ride is ongoing...but something went wrong to display ongoing ride!!",
              ),
              duration: Duration(seconds: 2),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else {
            Navigator.pushReplacementNamed(
              context,
              AppRoutes.bookedride,
              arguments: rideBooking.data![0],
            );
          }
        }
      } else {
        SnackBar snackBar = SnackBar(
          content: Text(getActiveRide.message.toString()),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      }
    } else {
      SnackBar snackBar = SnackBar(
        content: Text("${apiResponse.status} something went wrong!!"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    // Navigator.pushReplacementNamed(context, AppRoutes.register,arguments: "8379939930");
  }
}
