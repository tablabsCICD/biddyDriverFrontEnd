import 'package:biddy_driver/model/base_model/vehicle_model.dart';

class DriverDetailsInfo {
  String? message;
  List<Vehicle>? data;
  bool? success;

  DriverDetailsInfo({this.message, this.data, this.success});

  DriverDetailsInfo.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null || json['data'] != []) {
      data = <Vehicle>[];
      json['data'].forEach((v) {
        data!.add(new Vehicle.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = message;
    if (this.data != null || this.data != []) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['success'] = success;
    return data;
  }
}

