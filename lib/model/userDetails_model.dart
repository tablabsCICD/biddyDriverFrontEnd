class userDetailsModel {
  String? message;
  Data? data;
  bool? success;

  userDetailsModel({this.message, this.data, this.success});

  userDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? id;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? emailId;
  String? otp;
  String? deviceId;
  String? os;
  String? identityNumber;
  String? liscenceNumber;
  String? profilePhoto;
  String? password;
  int? isverified;
  bool? online;
  bool? driver;

  Data(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobileNumber,
        this.emailId,
        this.otp,
        this.deviceId,
        this.os,
        this.identityNumber,
        this.liscenceNumber,
        this.profilePhoto,
        this.password,
        this.isverified,
        this.online,
        this.driver});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobileNumber = json['mobileNumber'];
    emailId = json['emailId'];
    otp = json['otp'];
    deviceId = json['deviceId'];
    os = json['os'];
    identityNumber = json['identityNumber'];
    liscenceNumber = json['liscenceNumber'];
    profilePhoto = json['profilePhoto'];
    password = json['password'];
    isverified = json['isverified'];
    online = json['online'];
    driver = json['driver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['mobileNumber'] = this.mobileNumber;
    data['emailId'] = this.emailId;
    data['otp'] = this.otp;
    data['deviceId'] = this.deviceId;
    data['os'] = this.os;
    data['identityNumber'] = this.identityNumber;
    data['liscenceNumber'] = this.liscenceNumber;
    data['profilePhoto'] = this.profilePhoto;
    data['password'] = this.password;
    data['isverified'] = this.isverified;
    data['online'] = this.online;
    data['driver'] = this.driver;
    return data;
  }
}
