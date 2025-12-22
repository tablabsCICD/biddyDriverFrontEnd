import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/constant/imageconstant.dart';
import 'package:biddy_driver/model/base_model/ride_model.dart';
import 'package:biddy_driver/model/ride_status_change_response.dart';
import 'package:biddy_driver/route/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EndRideScreen extends StatelessWidget{

   RideData rideBooking;

   EndRideScreen({super.key, required this.rideBooking});


  @override
  Widget build(BuildContext context) {
    callApi();

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Text("Ride is Completed",style: TextStyle(fontSize: 30),),
            SizedBox(height: 20,),
            Text("Fair Amount \$ ${rideBooking.fare.toString()} ",style: TextStyle(fontSize: 20),),
            Image.asset(ImageConstant.TAXI,height: 200,width: 220)
            ,Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
               color: Colors.black,
               height: 10,
              ),
            ),
            SizedBox(height: 40,),
            InkWell(
                onTap: (){
                  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
                },
                child: Text("Click Here to Find New Ride",style: TextStyle(fontSize: 20,color: Colors.blueAccent),))


          ],

        ),

      ),

    );



  }

   callApi()async {
    await AppConstant.apiHelper.ApiGetData(APIConstants.END_RIDE+rideBooking.id!.toString()+"/"+rideBooking.driverId!.id.toString());
   }

}