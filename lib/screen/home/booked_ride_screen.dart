import 'dart:convert';

import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/constant/imageconstant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/base_model/ride_model.dart';
import 'package:biddy_driver/model/ride_accept_request.dart';
import 'package:biddy_driver/route/app_routes.dart';
import 'package:biddy_driver/util/get_date_string.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:biddy_driver/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import '../../model/ride_status_change_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookedRideScreen extends StatefulWidget {
  RideData booking;

  BookedRideScreen({super.key, required this.booking});

  @override
  State<StatefulWidget> createState() {
    return BookedRideState(booking);
  }
}

class BookedRideState extends State<BookedRideScreen> {
  RideData booking;
  bool isLoad = false;

  BookedRideState(this.booking);

  PolylinePoints polylinePoints = PolylinePoints();
  List<LatLng> polylineCoordinates = [];
  Map<PolylineId, Polyline> polylines = {};
  Set<Marker> markers = {};
  GoogleMapController? googleMapController;
  LatLng centerLatLong = LatLng(45.521563, -122.677433);

  @override
  void initState() {
    super.initState();
    _createPolylines(
      booking.startLocationLatitude!,
      booking.startLocationLongitude!,
      booking.endLocationLatitude!,
      booking.endLocationLongitude!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            "Current Ride",
            textAlign: TextAlign.center,
          ),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.menu);
              },
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 30,
              ),
            ),
          ],
        ),

          body: Column(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rideHeader(),
                  const SizedBox(height: 10),
                  _rideDetails(),
                  const SizedBox(height: 10),
                  Divider(thickness: 2),
                  const SizedBox(height: 10),
                  getLatLongLine(),
                  const SizedBox(height: 20),
                  mapView(),
                ],
              ),
            ),
            _bottomActionBar(),
          ],
        ),
      ),
    );
  }

  /// ---------------- Ride Top Section ----------------
  Widget _rideHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12,vertical: 0),
        leading:  Image.asset(
          ImageConstant.PROFILE_IMAGE,
          height: 50,
          width: 50,
        ),// your avatar/user widget
        title:Text(
          "${booking.customerId!.firstName!} ${booking.customerId!.lastName!}",
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
        ),
        subtitle:InkWell(
          onTap: () {},
          child: Row(
            children: [
              const Icon(
                Icons.call,
                color: Colors.indigoAccent,
                size: 15,
              ),
              Text(
                booking.customerId!.phoneNumber!,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.indigoAccent),
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  /// ---------------- Ride Details Row ----------------
  Widget _rideDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _iconText(Icons.location_on_outlined, booking.endLocation ?? ""),
        const SizedBox(height: 5),
        _iconText(Icons.access_time_outlined, formatDateTime(booking.endTime?.toString()),),
        const SizedBox(height: 5),
        _iconText(Icons.money, "${booking.fare ?? ""}"),
      ],
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.black87),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            maxLines: 3, // allow up to 3 lines
            softWrap: true,
            overflow: TextOverflow.ellipsis, // will show "..." if more than 3 lines
            style: const TextStyle(
              fontSize: 14,
              height: 1.4, // better readability for multi-line
            ),
          ),
        ),
      ],
    );
  }


  /// ---------------- Bottom Action Bar ----------------
  Widget _bottomActionBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_isStatus(AppConstant.status_accepted))
              AppButton(
                buttonTitle: "Start Ride",
                onClick: () => showOtpDialog(context),
                enbale: true,
              ),
            if (_isStatus(AppConstant.status_accepted))
              AppButton(
                buttonTitle: "Cancel Ride",
                onClick: () =>
                    changeStatus(AppConstant.status_ride_cancel_by_driver),
                enbale: true,
              ),
            if (_isStatus(AppConstant.status_ride_ongoing))
              AppButton(
                buttonTitle: "End Ride",
                onClick: () => changeStatus(AppConstant.status_end_ride),
                enbale: true,
              ),
            if (_isStatus(AppConstant.status_ride_ongoing))
              AppButton(
                buttonTitle: "Ride History",
                onClick: () {
                  changeStatus(AppConstant.status_ride_ongoing);
                },
                enbale: true,
              ),
          ],
        ),
      ),
    );
  }

  bool _isStatus(String status) =>
      booking.status?.toLowerCase() == status.toLowerCase();

  /// ---------------- Map Section ----------------
  Widget mapView() {
    return SizedBox(
      height: 300,
      child:  Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                booking.startLocationLatitude!,
                booking.startLocationLongitude!,
              ),
              zoom: 12,
            ),
            polylines: Set<Polyline>.of(polylines.values),
            markers: markers,
            onMapCreated: (controller) {
              googleMapController = controller;
            },
          ),

          // Distance Card on top
          if (tripDistance != null)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Text(
                  "Distance: ${tripDistance!.toStringAsFixed(2)} km",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      )
    );
  }


  /// ---------------- OTP Dialog ----------------
  Future<void> showOtpDialog(BuildContext context) async {
    final otpController = TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Enter OTP", style: TextStyle(fontWeight: FontWeight.bold)),
        content: SizedBox(
          height: 80,
          child: TextField(
            controller: otpController,
            maxLength: 4,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(4),
            ],
            decoration: const InputDecoration(
              counterText: "",
              border: OutlineInputBorder(),
              hintText: "----",
            ),
            style: const TextStyle(
              letterSpacing: 32,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (otpController.text.length == 4) {
                changeStatus(AppConstant.status_ride_ongoing);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter a 4-digit OTP")),
                );
              }
            },
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }

  /// ---------------- API: Change Ride Status ----------------
  Future<void> changeStatus(String status) async {
    setState(() => isLoad = true);

    final url = APIConstants.RIDE_STATUS_CHANGE;
    final apiResponse = await AppConstant.apiHelper.putDataArgument(url, {
      "id": booking.id,
      "status": status,
    });

    if (apiResponse.status == 200) {
      final res = jsonDecode(apiResponse.response);
      booking = RideStatusChangeResponse.fromJson(res).data!;
      setState(() => isLoad = false);

      if (status == AppConstant.status_end_ride) {
        Navigator.pushReplacementNamed(context, AppRoutes.endride,
            arguments: booking);
      }
    } else {
      setState(() => isLoad = false);
    }
  }
  double? tripDistance;


  // ---------------- Polyline ----------------

  Future<void> _createPolylines(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,
      ) async {
    // reset
    polylines.clear();
    polylineCoordinates.clear();
    markers.removeWhere((m) => m.markerId == const MarkerId('start') || m.markerId == const MarkerId('end'));

    // Markers
    final start = LatLng(startLatitude, startLongitude);
    final end = LatLng(destinationLatitude, destinationLongitude);

    markers.add(Marker(
      markerId: MarkerId('start'),
      infoWindow: InfoWindow(title: 'Start'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: LatLng(0, 0), // will set below
    ));
    markers.add(Marker(
      markerId: MarkerId('end'),
      infoWindow: InfoWindow(title: 'Destination'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: LatLng(0, 0), // will set below
    ));

    // Update markers with actual positions
    markers = markers.map((m) {
      if (m.markerId.value == 'start') {
        return m.copyWith(positionParam: start);
      } else if (m.markerId.value == 'end') {
        return m.copyWith(positionParam: end);
      }
      return m;
    }).toSet();

    // Fetch polyline points
    polylinePoints = PolylinePoints();
    final result = await polylinePoints.getRouteBetweenCoordinates(
      APIConstants.GOOGLEAPIKEY,
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
    );

    // Build coordinates
    if (result.points.isNotEmpty) {
      polylineCoordinates.addAll(
        result.points.map((p) => LatLng(p.latitude, p.longitude)),
      );
    } else {
      // Fallback: draw straight line if API returned nothing
      polylineCoordinates.addAll([start, end]);
    }

    // Add the route polyline
    const id = PolylineId('route');
    polylines[id] = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 6,
      color: Colors.blueAccent,
      geodesic: true,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      jointType: JointType.round,
    );

    if (mounted) {
      setState(() {});
    }

    // Fit the camera to the route/markers
    _fitCameraToBounds();

    if (result.points.isNotEmpty) {
      polylineCoordinates.addAll(result.points
          .map((p) => LatLng(p.latitude, p.longitude))
          .toList());
    }

// calculate distance and set state
    tripDistance = await getDistanceInKm(
      startLatitude,
      startLongitude,
      destinationLatitude,
      destinationLongitude,
    );

    setState(() {});

  }

  Future<double> getDistanceInKm(
      double startLat, double startLng, double endLat, double endLng) async {
    double distanceInMeters =
    Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
    return distanceInMeters / 1000; // meters → km
  }


  void _fitCameraToBounds() {
    if (googleMapController == null) return;

    // Build bounds from all route points (or just start/end as fallback)
    final pts = polylineCoordinates.isNotEmpty
        ? polylineCoordinates
        : [
      LatLng(booking.startLocationLatitude!, booking.startLocationLongitude!),
      LatLng(booking.endLocationLatitude!, booking.endLocationLongitude!),
    ];

    final bounds = _boundsFromLatLngList(pts);
    if (bounds == null) return;

    // Animate with padding
    googleMapController!.animateCamera(
      CameraUpdate.newLatLngBounds(bounds, 60),
    );
  }

  /// Utility: compute LatLngBounds from a list
  LatLngBounds? _boundsFromLatLngList(List<LatLng> list) {
    if (list.isEmpty) return null;

    double? x0, x1, y0, y1;
    for (final latLng in list) {
      if (x0 == null) {
        x0 = x1 = latLng.latitude;
        y0 = y1 = latLng.longitude;
      } else {
        if (latLng.latitude < x0) x0 = latLng.latitude;
        if (latLng.latitude > x1!) x1 = latLng.latitude;
        if (latLng.longitude < y0!) y0 = latLng.longitude;
        if (latLng.longitude > y1!) y1 = latLng.longitude;
      }
    }
    return LatLngBounds(
      southwest: LatLng(x0!, y0!),
      northeast: LatLng(x1!, y1!),
    );
  }


  /// ---------------- Start & End Location Section ----------------
  Widget getLatLongLine() {
    return SizedBox(
      height: 130,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,   // center vertically
        crossAxisAlignment: CrossAxisAlignment.start, // center horizontally
        children: [
          _locationRow(
            Icons.my_location,
            Colors.green,
            booking.startLocation!,
            formatDateTime(booking.startTime?.toString()),
          ),
          const SizedBox(height: 7),
          Container(
            height: 30,
            width: 2,
            color: Colors.green,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.2),
          ),
          const SizedBox(height: 7),
          _locationRow(
            Icons.pin_drop_outlined,
            Colors.red,
            booking.endLocation!,
            formatDateTime(booking.endTime?.toString()),
          ),
        ],
      ),
    );
  }


  Widget _locationRow(
      IconData icon, Color color, String title, String timeText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 30, color: color),
        const SizedBox(width: 7),
        Expanded( // 🔹 allows wrapping into multiple lines
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 3, // wrap up to 2–3 lines
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
              Text(
                "At $timeText",
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );
  }


  String formatDateTime(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return "";

    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
    } catch (e) {
      return dateTimeString; // fallback if parsing fails
    }
  }

}



