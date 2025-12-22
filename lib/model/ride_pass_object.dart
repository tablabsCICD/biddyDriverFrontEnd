import 'package:google_maps_flutter/google_maps_flutter.dart';

class RidePass{
  final String amount;
  final LatLng pickUpLatLang;
  final LatLng dropUpLatLang;
  final String pickUpLocation;
  final String dropLocation;
  final String distance;
  final String estTime;
  final Map<PolylineId, Polyline> polylines;

  RidePass(this.amount, this.pickUpLatLang, this.dropUpLatLang, this.pickUpLocation, this.dropLocation, this.polylines, this.distance, this.estTime);



}