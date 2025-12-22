import 'package:biddy_driver/constant/text_constant.dart';
import 'package:biddy_driver/model/base_model/ride_model.dart';
import 'package:biddy_driver/provider/ride_provider.dart';
import 'package:biddy_driver/util/colors.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CompletedScreen extends StatefulWidget {
  List<RideData>? rideList;
  CompletedScreen({super.key,this.rideList});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RideProvider(context),
      builder: (context, child) => _build(context),
    );
  }

  _build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<RideProvider>(
          builder: (context, rideProvider, child)=> Container(
          padding: EdgeInsets.all(16),
          child: rideProvider.completedRideList.isEmpty?Center(child: Text(
            "No Rides Found",style: TextStyle(
            fontSize: 16,fontWeight: FontWeight.bold,
          ),
          )):ListView.builder(
            itemCount: rideProvider.completedRideList.length,
              itemBuilder: (context,index){
              return getRidesWidget(rideProvider.completedRideList[index]);
            }
          ),
        ),
      ),
    );
  }

  Widget getRidesWidget(RideData rideData) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.my_location,size: 30,color: Colors.green,),
                SizedBox(width: 7,),
                TextView(
                    title:rideData.startLocation.toString(),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.location_on_outlined,size: 30,color: Colors.green,),
                SizedBox(width: 7,),
                TextView(
                    title:rideData.endLocation.toString(),
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ],
            ),
            SizedBox(height: 16,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextView(
                    title:TextConstant.currency+"${rideData.bidAmount.toString()}",
                    color: ThemeColor.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                TextView(
                    title:"${getDate(rideData.endTime.toString())} at ${getTime(rideData.endTime.toString())}",
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12),
              ],
            ),
          ],
        ),
      ),
    );
  }

  getDate(String dateTimeString){
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    print("Date: $formattedDate");
    return formattedDate;
  }

  getTime(String dateTimeString){
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
    print("Time: $formattedTime");
    return formattedTime;
  }
}
