
import 'package:biddy_driver/model/base_model/driver_model.dart';

class Vehicle {
  int? id;
  Driver? driverId;
  String? make;
  String? model;
  String? year;
  String? color;
  String? vehicleLicensePlateNumber;
  List<String>? carPhoto;
  String? createdDate;
  String? updatedDate;
  String? document;
  String? selected;
  String? vinNumber;
  String? validateDate;
  String? typeOfVehicle;
  String? copofRegistration;
  String? copyofInsurance;
  String? copyofStateInspection;
  String? copyofTNCInspection;

  Vehicle(
      {this.id,
        this.driverId,
        this.make,
        this.model,
        this.year,
        this.color,
        this.vehicleLicensePlateNumber,
        this.carPhoto,
        this.createdDate,
        this.updatedDate,
        this.document,
        this.selected,
        this.vinNumber,
        this.validateDate,
        this.typeOfVehicle,
        this.copofRegistration,
        this.copyofInsurance,
        this.copyofStateInspection,
        this.copyofTNCInspection});

  Vehicle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driverId'] != null
        ? new Driver.fromJson(json['driverId'])
        : null;
    make = json['make'];
    model = json['model'];
    year = json['year'];
    color = json['color'];
    vehicleLicensePlateNumber = json['vehicleLicensePlateNumber'];
    carPhoto = json['carPhoto'].cast<String>();
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    document = json['document'];
    selected = json['selected'];
    vinNumber = json['vinNumber'];
    validateDate = json['validateDate'];
    typeOfVehicle = json['typeOfVehicle'];
    copofRegistration = json['copofRegistration'];
    copyofInsurance = json['copyofInsurance'];
    copyofStateInspection = json['copyofStateInspection'];
    copyofTNCInspection = json['copyofTNCInspection'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.driverId != null) {
      data['driverId'] = this.driverId!.toJson();
    }
    data['make'] = this.make;
    data['model'] = this.model;
    data['year'] = this.year;
    data['color'] = this.color;
    data['vehicleLicensePlateNumber'] = this.vehicleLicensePlateNumber;
    data['carPhoto'] = this.carPhoto;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['document'] = this.document;
    data['selected'] = this.selected;
    data['vinNumber'] = this.vinNumber;
    data['validateDate'] = this.validateDate;
    data['typeOfVehicle'] = this.typeOfVehicle;
    data['copofRegistration'] = this.copofRegistration;
    data['copyofInsurance'] = this.copyofInsurance;
    data['copyofStateInspection'] = this.copyofStateInspection;
    data['copyofTNCInspection'] = this.copyofTNCInspection;
    return data;
  }
}