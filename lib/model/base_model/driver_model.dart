class DriverModel {
  String? message;
  Driver? data;
  bool? success;

  DriverModel({this.message, this.data, this.success});

  DriverModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Driver.fromJson(json['data']) : null;
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

class Driver {
  int? id;
  String? firstName;
  String? lastName;
  String? zone;
  String? dob;
  String? driverLicensenumber;
  String? driverLicensenState;
  String? driverLicensenExpirationDate;
  String? backgroundCheckStatus;
  String? backgroundCheckDate;
  String? isActive;
  String? registerState;
  String? socialSecurityNumber;
  String? os;
  String? deviceId;
  String? otp;
  String? onlineTime;
  String? offlineTime;
  bool? preferedRoute;
  bool? isBook;
  String? emailId;
  String? phoneNumber;
  String? password;
  String? photo;
  String? createdDate;
  String? updatedDate;
  String? status;

  Driver(
      {this.id,
        this.firstName,
        this.lastName,
        this.zone,
        this.dob,
        this.driverLicensenumber,
        this.driverLicensenState,
        this.driverLicensenExpirationDate,
        this.backgroundCheckStatus,
        this.backgroundCheckDate,
        this.isActive,
        this.registerState,
        this.socialSecurityNumber,
        this.os,
        this.deviceId,
        this.otp,
        this.onlineTime,
        this.offlineTime,
        this.preferedRoute,
        this.isBook,
        this.emailId,
        this.phoneNumber,
        this.password,
        this.photo,
        this.createdDate,
        this.updatedDate,
        this.status});

  Driver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    zone = json['zone'];
    dob = json['dob'];
    driverLicensenumber = json['driverLicensenumber'];
    driverLicensenState = json['driverLicensenState'];
    driverLicensenExpirationDate = json['driverLicensenExpirationDate'];
    backgroundCheckStatus = json['backgroundCheckStatus'];
    backgroundCheckDate = json['backgroundCheckDate'];
    isActive = json['isActive'].toString();
    registerState = json['registerState'];
    socialSecurityNumber = json['socialSecurityNumber'];
    os = json['os'];
    deviceId = json['deviceId'];
    otp = json['otp'];
    onlineTime = json['onlineTime'];
    offlineTime = json['offlineTime'];
    preferedRoute = json['preferedRoute'];
    isBook = json['isBook'];
    emailId = json['emailId'];
    phoneNumber = json['phoneNumber'];
    password = json['password'];
    photo = json['photo'];
    createdDate = json['createdDate'].toString();
    updatedDate = json['updatedDate'].toString();
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['zone'] = this.zone;
    data['dob'] = this.dob;
    data['driverLicensenumber'] = this.driverLicensenumber;
    data['driverLicensenState'] = this.driverLicensenState;
    data['driverLicensenExpirationDate'] = this.driverLicensenExpirationDate;
    data['backgroundCheckStatus'] = this.backgroundCheckStatus;
    data['backgroundCheckDate'] = this.backgroundCheckDate;
    data['isActive'] = this.isActive;
    data['registerState'] = this.registerState;
    data['socialSecurityNumber'] = this.socialSecurityNumber;
    data['os'] = this.os;
    data['deviceId'] = this.deviceId;
    data['otp'] = this.otp;
    data['onlineTime'] = this.onlineTime;
    data['offlineTime'] = this.offlineTime;
    data['preferedRoute'] = this.preferedRoute;
    data['isBook'] = this.isBook;
    data['emailId'] = this.emailId;
    data['phoneNumber'] = this.phoneNumber;
    data['password'] = this.password;
    data['photo'] = this.photo;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['status'] = this.status;
    return data;
  }
}
