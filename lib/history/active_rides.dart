import 'dart:convert';

import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/base_model/ride_model.dart';
import 'package:biddy_driver/provider/ride_provider.dart';
import 'package:biddy_driver/util/get_date_string.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:biddy_driver/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ActiveRides extends StatefulWidget {
  List<RideData>? rideList;
  ActiveRides({super.key,this.rideList});

  @override
  State<ActiveRides> createState() => _ActiveRidesState();
}

class _ActiveRidesState extends State<ActiveRides> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => RideProvider(context),
      builder: (context, child) => _build(context),
    );
  }

  _build(context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(20),
        child: widget.rideList!.isEmpty?Center(child: Text(
          "No Active Ride Found",style: TextStyle(
          fontSize: 16,fontWeight: FontWeight.bold,
        ),
        )):Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey[100],
                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage('assets/profile.jpg')))),
                            SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextView(
                                    title:"${widget.rideList![0].customerId!.firstName} ${widget.rideList![0].customerId!.lastName}",
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                                TextView(
                                    title: "${widget.rideList![0].customerId!.email}",
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),

                              ],
                            ),

                          ],
                        ),
                        SizedBox(
                          width: 70,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.green
                                ),
                                child: TextView(
                                    title:"Active",
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                              ),
                              TextView(
                                  title:"MR-AF-212",
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined),
                          SizedBox(width: 5,),
                          TextView(
                              title:"${widget.rideList![0].endLocation}",
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined),
                          SizedBox(width: 5,),
                          TextView(
                              title:"${GetDateInString.getTime(widget.rideList![0].endTime.toString())}",
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.money),
                          SizedBox(width: 5,),
                          TextView(
                              title:widget.rideList![0].bidAmount.toString(),
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextView(
                          title:"Date & Time",
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                      Row(
                        children: [
                          TextView(
                              title:"${GetDateInString.getDate(widget.rideList![0].endTime.toString())}",
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                          SizedBox(width: 5,),
                          TextView(
                              title:"| ${GetDateInString.getTime(widget.rideList![0].endTime.toString())}",
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 12),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(thickness: 2,),
                  SizedBox(height: 10,),
                  getLatLongLine(),
                  SizedBox(height: 10,),
                  mapView()
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child:Consumer<RideProvider>(
                builder: (context, rideProvider, child)=> SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: widget.rideList![0].status!
                              .toLowerCase()
                              .compareTo(AppConstant.status_accepted.toLowerCase()) ==
                              0
                              ? true
                              : false,
                          child: AppButton(
                              buttonTitle: "Start Ride",
                              onClick: () {
                                rideProvider.changeStatus(context,AppConstant.status_ride_ongoing,widget.rideList![0]);
                              },
                              enbale: true),
                        ),
                        Visibility(
                          visible: widget.rideList![0].status!.toLowerCase()
                              .compareTo(AppConstant.status_accepted.toLowerCase()) ==
                              0
                              ? true
                              : false,
                          child: AppButton(
                              buttonTitle: "Cancel Ride",
                              onClick: () {
                                rideProvider.changeStatus(context,AppConstant.status_ride_cancel_by_driver,widget.rideList![0]);
                              },
                              enbale: true),
                        ),
                        Visibility(
                          // visible: booking.data!.requestStatus!
                          //             .toLowerCase()
                          //             .compareTo(AppConstant.status_ride_ongoing) ==
                          //         0
                          //     ? true
                          //     : false,
                          child: AppButton(
                              buttonTitle: "End Ride",
                              onClick: () {
                                rideProvider.changeStatus(context,AppConstant.status_end_ride,widget.rideList![0]);
                              },
                              enbale: true),
                        ),
                      ],
                    )
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Consumer<RideProvider>(
                builder: (context, rideProvider, child)=> SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                      buttonTitle: "End Ride",
                      onClick: (){
                        rideProvider.changeStatus(context,AppConstant.status_end_ride,widget.rideList![0]);
                      }, enbale: true),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  LatLng centerLatLong =  LatLng(45.521563, -122.677433 );
  GoogleMapController? googleMapController;

  mapView() {
    return SizedBox(
      height: 200,
      child: GoogleMap(
       // markers: markers,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: centerLatLong,
          zoom: 14.0,
        ),
        onMapCreated: _onMapCreated,
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      googleMapController = controller;
    });
  }

  getLatLongLine() {
    return SizedBox(
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.my_location,size: 30,color: Colors.green,),
              SizedBox(width: 7,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                      title:"${widget.rideList![0].startLocation.toString()}",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                  TextView(
                      title:"${GetDateInString.getDate(widget.rideList![0].startTime.toString())} At ${GetDateInString.getTime(widget.rideList![0].startTime.toString())}",
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 10),
                ],
              ),
            ],
          ),
          SizedBox(height: 7,),
          Container(
            height: 40,
            width: 2,
            color: Colors.green,),
          SizedBox(height: 7,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.pin_drop_outlined,size: 30,color: Colors.green,),
              SizedBox(width: 7,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextView(
                      title:"${widget.rideList![0].endLocation.toString()}",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                  TextView(
                      title:"${GetDateInString.getDate(widget.rideList![0].endTime.toString())} At ${GetDateInString.getTime(widget.rideList![0].endTime.toString())}",
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 10),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


}
