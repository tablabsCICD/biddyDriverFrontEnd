class DriverCabData {
  String? message;
  List<Data>? data;
  bool? success;

  DriverCabData({this.message, this.data, this.success});

  DriverCabData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  CabCategoriesid? cabCategoriesid;
  String? cabcategoriesId;
  String? model;
  String? maxNumberOfPassengers;
  Userid? userid;
  String? userId;
  bool? isOnline;
  int? currentLatitude;
  int? currentLongitude;
  bool? isBook;
  String? requestStatus;
  String? vehicelsCompany;
  String? vehicelsNumber;

  Data(
      {this.id,
        this.cabCategoriesid,
        this.cabcategoriesId,
        this.model,
        this.maxNumberOfPassengers,
        this.userid,
        this.userId,
        this.isOnline,
        this.currentLatitude,
        this.currentLongitude,
        this.isBook,
        this.requestStatus,
        this.vehicelsCompany,
        this.vehicelsNumber});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cabCategoriesid = json['cab_categoriesid'] != null
        ? new CabCategoriesid.fromJson(json['cab_categoriesid'])
        : null;
    cabcategoriesId = json['cabcategoriesId'];
    model = json['model'];
    maxNumberOfPassengers = json['maxNumberOfPassengers'];
    userid =
    json['userid'] != null ? new Userid.fromJson(json['userid']) : null;
    userId = json['userId'];
    isOnline = json['isOnline'];
    currentLatitude = json['currentLatitude'];
    currentLongitude = json['currentLongitude'];
    isBook = json['isBook'];
    requestStatus = json['requestStatus'];
    vehicelsCompany = json['vehicelsCompany'];
    vehicelsNumber = json['vehicelsNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.cabCategoriesid != null) {
      data['cab_categoriesid'] = this.cabCategoriesid!.toJson();
    }
    data['cabcategoriesId'] = this.cabcategoriesId;
    data['model'] = this.model;
    data['maxNumberOfPassengers'] = this.maxNumberOfPassengers;
    if (this.userid != null) {
      data['userid'] = this.userid!.toJson();
    }
    data['userId'] = this.userId;
    data['isOnline'] = this.isOnline;
    data['currentLatitude'] = this.currentLatitude;
    data['currentLongitude'] = this.currentLongitude;
    data['isBook'] = this.isBook;
    data['requestStatus'] = this.requestStatus;
    data['vehicelsCompany'] = this.vehicelsCompany;
    data['vehicelsNumber'] = this.vehicelsNumber;
    return data;
  }
}

class CabCategoriesid {
  int? id;
  String? name;
  int? basePriceAtDayTime;
  int? basePriceInNightTime;
  int? ratePerKmAtDayTime;
  int? ratePerKmInNightTime;
  bool? active;
  String? image;

  CabCategoriesid(
      {this.id,
        this.name,
        this.basePriceAtDayTime,
        this.basePriceInNightTime,
        this.ratePerKmAtDayTime,
        this.ratePerKmInNightTime,
        this.active,
        this.image});

  CabCategoriesid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    basePriceAtDayTime = json['basePriceAtDayTime'];
    basePriceInNightTime = json['basePriceInNightTime'];
    ratePerKmAtDayTime = json['ratePerKmAtDayTime'];
    ratePerKmInNightTime = json['ratePerKmInNightTime'];
    active = json['active'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['basePriceAtDayTime'] = this.basePriceAtDayTime;
    data['basePriceInNightTime'] = this.basePriceInNightTime;
    data['ratePerKmAtDayTime'] = this.ratePerKmAtDayTime;
    data['ratePerKmInNightTime'] = this.ratePerKmInNightTime;
    data['active'] = this.active;
    data['image'] = this.image;
    return data;
  }
}

class Userid {
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
  bool? driver;
  bool? online;

  Userid(
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
        this.driver,
        this.online});

  Userid.fromJson(Map<String, dynamic> json) {
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
    driver = json['driver'];
    online = json['online'];
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
    data['driver'] = this.driver;
    data['online'] = this.online;
    return data;
  }
}
