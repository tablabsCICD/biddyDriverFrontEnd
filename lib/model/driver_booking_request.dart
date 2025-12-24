import 'package:biddy_driver/model/base_model/customer_model.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/model/base_model/vehicle_model.dart';

import 'base_model/ride_model.dart';

class RideBookingModel {
  String? message;
  List<RideData>? data;
  bool? success;

  RideBookingModel({this.message, this.data, this.success});

  RideBookingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <RideData>[];
      json['data'].forEach((v) {
        data!.add(new RideData.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}






