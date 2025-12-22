
import 'package:biddy_driver/history/active_rides.dart';
import 'package:biddy_driver/history/completed_rides.dart';
import 'package:biddy_driver/provider/ride_provider.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class HistoryScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HistoryScreenState();
  }

}

class HistoryScreenState extends State<HistoryScreen>{
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RideProvider(context),
      builder: (context, child) => _build(context),
    );
  }

  _build(context){
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor:Colors.white,
          title: TextView(
              title: "History",
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14),
          bottom: const TabBar(
            tabs: [
              Tab(
                //icon: Icon(Icons.chat_bubble),
                text: "Active Now",
              ),
              Tab(
                //icon: Icon(Icons.video_call),
                text: "Completed",
              ),
              Tab(
                //icon: Icon(Icons.settings),
                text: "Accepted",
              )
            ],
          ),
        ),
        body: Consumer<RideProvider>(
    builder: (context, rideProvider, child) {
    return TabBarView(
            children: [
              ActiveRides(rideList:rideProvider.activeRideList),
              CompletedScreen(rideList:rideProvider.completedRideList),
              CompletedScreen(rideList:rideProvider.cancelledRideList),
            ],);
      }),

      ),
    );
  }

  header() {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text("Your Past Rides",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
    );
  }


}