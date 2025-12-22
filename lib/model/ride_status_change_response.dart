import 'package:biddy_driver/model/base_model/ride_model.dart';
import 'package:biddy_driver/model/driver_booking_request.dart';

class RideStatusChangeResponse {
  String? message;
  RideData? data;
  bool? success;

  RideStatusChangeResponse({this.message, this.data, this.success});

  RideStatusChangeResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new RideData.fromJson(json['data']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}


