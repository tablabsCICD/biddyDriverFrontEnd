
import 'package:biddy_driver/model/base_model/driver_model.dart';

class PrefferedRoute {
  int? id;
  Driver? driverId;
  String? source;
  String? destination;
  String? city;
  String? pincode;
  double? driverLatitude;
  double? driverLongitude;

  PrefferedRoute(
      {this.id,
        this.driverId,
        this.source,
        this.destination,
        this.city,
        this.pincode,
        this.driverLatitude,
        this.driverLongitude});

  PrefferedRoute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driverId'] != null
        ? new Driver.fromJson(json['driverId'])
        : null;
    source = json['source'];
    destination = json['destination'];
    city = json['city'];
    pincode = json['pincode'];
    driverLatitude = json['driverLatitude'];
    driverLongitude = json['driverLongitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.driverId != null) {
      data['driverId'] = this.driverId!.toJson();
    }
    data['source'] = this.source;
    data['destination'] = this.destination;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['driverLatitude'] = this.driverLatitude;
    data['driverLongitude'] = this.driverLongitude;
    return data;
  }
}


