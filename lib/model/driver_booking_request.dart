import 'package:biddy_driver/model/base_model/customer_model.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/model/base_model/vehicle_model.dart';

class RideBookingModel {
  String? message;
  List<RideBookingData>? data;
  bool? success;

  RideBookingModel({this.message, this.data, this.success});

  RideBookingModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <RideBookingData>[];
      json['data'].forEach((v) {
        data!.add(new RideBookingData.fromJson(v));
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

class RideBookingData {
  int? id;
  Customer? customerId;
  Driver? driverId;
  Vehicle? vehicleId;
  String? startLocation;
  String? endLocation;
  double? startLocationLatitude;
  double? startLocationLongitude;
  double? endLocationLatitude;
  double? endLocationLongitude;
  String? startTime;
  String? endTime;
  double? distance;
  double? duration;
  double? fare;
  String? paymentMethod;
  double? rating;
  String? feedback;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? typeOfVehicle;
  bool? isActive;
  String? typeOfRide;
  String? scheduledTime;
  String? stop1;
  String? stop1time;
  String? stop2;
  String? stop2time;
  String? stop3;
  String? stop3time;
  String? stop4;
  String? stop4time;
  String? stop5;
  String? stop5time;
  double? bidAmount;
  String? cancellationReason;

  RideBookingData(
      {this.id,
        this.customerId,
        this.driverId,
        this.vehicleId,
        this.startLocation,
        this.endLocation,
        this.startLocationLatitude,
        this.startLocationLongitude,
        this.endLocationLatitude,
        this.endLocationLongitude,
        this.startTime,
        this.endTime,
        this.distance,
        this.duration,
        this.fare,
        this.paymentMethod,
        this.rating,
        this.feedback,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.typeOfVehicle,
        this.isActive,
        this.typeOfRide,
        this.scheduledTime,
        this.stop1,
        this.stop1time,
        this.stop2,
        this.stop2time,
        this.stop3,
        this.stop3time,
        this.stop4,
        this.stop4time,
        this.stop5,
        this.stop5time,
        this.bidAmount,
        this.cancellationReason});

  RideBookingData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customerId'] != null
        ? new Customer.fromJson(json['customerId'])
        : null;
    driverId = json['driverId'] != null
        ? new Driver.fromJson(json['driverId'])
        : null;
    vehicleId = json['vehicleId'] != null
        ? new Vehicle.fromJson(json['vehicleId'])
        : null;
    startLocation = json['startLocation'];
    endLocation = json['endLocation'];
    startLocationLatitude = json['startLocationLatitude'];
    startLocationLongitude = json['startLocationLongitude'];
    endLocationLatitude = json['endLocationLatitude'];
    endLocationLongitude = json['endLocationLongitude'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    distance = double.parse(json['distance'].toString());
    duration = double.parse(json['duration'].toString());
    fare = json['fare'];
    paymentMethod = json['paymentMethod'];
    rating = double.parse(json['rating'].toString());
    feedback = json['feedback'];
    status = json['status'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    typeOfVehicle = json['typeOfVehicle'];
    isActive = json['isActive'];
    typeOfRide = json['typeOfRide'];
    scheduledTime = json['scheduledTime'];
    stop1 = json['stop1'];
    stop1time = json['stop1time'];
    stop2 = json['stop2'];
    stop2time = json['stop2time'];
    stop3 = json['stop3'];
    stop3time = json['stop3time'];
    stop4 = json['stop4'];
    stop4time = json['stop4time'];
    stop5 = json['stop5'];
    stop5time = json['stop5time'];
    bidAmount = json['bidAmount'];
    cancellationReason = json['cancellationReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customerId != null) {
      data['customerId'] = this.customerId!.toJson();
    }
    if (this.driverId != null) {
      data['driverId'] = this.driverId!.toJson();
    }
    if (this.vehicleId != null) {
      data['vehicleId'] = this.vehicleId!.toJson();
    }
    data['startLocation'] = this.startLocation;
    data['endLocation'] = this.endLocation;
    data['startLocationLatitude'] = this.startLocationLatitude;
    data['startLocationLongitude'] = this.startLocationLongitude;
    data['endLocationLatitude'] = this.endLocationLatitude;
    data['endLocationLongitude'] = this.endLocationLongitude;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['distance'] = this.distance;
    data['duration'] = this.duration;
    data['fare'] = this.fare;
    data['paymentMethod'] = this.paymentMethod;
    data['rating'] = this.rating;
    data['feedback'] = this.feedback;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['typeOfVehicle'] = this.typeOfVehicle;
    data['isActive'] = this.isActive;
    data['typeOfRide'] = this.typeOfRide;
    data['scheduledTime'] = this.scheduledTime;
    data['stop1'] = this.stop1;
    data['stop1time'] = this.stop1time;
    data['stop2'] = this.stop2;
    data['stop2time'] = this.stop2time;
    data['stop3'] = this.stop3;
    data['stop3time'] = this.stop3time;
    data['stop4'] = this.stop4;
    data['stop4time'] = this.stop4time;
    data['stop5'] = this.stop5;
    data['stop5time'] = this.stop5time;
    data['bidAmount'] = this.bidAmount;
    data['cancellationReason'] = this.cancellationReason;
    return data;
  }
}




