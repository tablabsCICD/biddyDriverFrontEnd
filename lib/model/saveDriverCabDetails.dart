class SaveDriverCabDetails {
  String? cabcategoriesId;
  String? currentLatitude;
  String? currentLongitude;
  int? id;
  bool? isBook;
  bool? isOnline;
  String? maxNumberOfPassengers;
  String? model;
  String? requestStatus;
  int? userId;
  String? vehicelsCompany;
  String? vehicelsNumber;

  SaveDriverCabDetails(
      {this.cabcategoriesId,
        this.currentLatitude,
        this.currentLongitude,
        this.id,
        this.isBook,
        this.isOnline,
        this.maxNumberOfPassengers,
        this.model,
        this.requestStatus,
        this.userId,
        this.vehicelsCompany,
        this.vehicelsNumber});

  SaveDriverCabDetails.fromJson(Map<String, dynamic> json) {
    cabcategoriesId = json['cabcategoriesId'];
    currentLatitude = json['currentLatitude'];
    currentLongitude = json['currentLongitude'];
    id = json['id'];
    isBook = json['isBook'];
    isOnline = json['isOnline'];
    maxNumberOfPassengers = json['maxNumberOfPassengers'];
    model = json['model'];
    requestStatus = json['requestStatus'];
    userId = json['userId'];
    vehicelsCompany = json['vehicelsCompany'];
    vehicelsNumber = json['vehicelsNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cabcategoriesId'] = this.cabcategoriesId;
    data['currentLatitude'] = this.currentLatitude;
    data['currentLongitude'] = this.currentLongitude;
    data['id'] = this.id;
    data['isBook'] = this.isBook;
    data['isOnline'] = this.isOnline;
    data['maxNumberOfPassengers'] = this.maxNumberOfPassengers;
    data['model'] = this.model;
    data['requestStatus'] = this.requestStatus;
    data['userId'] = this.userId;
    data['vehicelsCompany'] = this.vehicelsCompany;
    data['vehicelsNumber'] = this.vehicelsNumber;
    return data;
  }
}
