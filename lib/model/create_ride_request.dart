class CreateRideRequest {
  String? bokkingType;
  int? cabcategoriesIdR;
  double? dropLat;
  String? dropLocation;
  double? dropLong;
  int? id;
  int? maxDistance;
  String? pickupLocation;
  int? price;
  int? userIdTemp;
  double? userLat;
  double? userLong;

  CreateRideRequest(
      {this.bokkingType,
        this.cabcategoriesIdR,
        this.dropLat,
        this.dropLocation,
        this.dropLong,
        this.id,
        this.maxDistance,
        this.pickupLocation,
        this.price,
        this.userIdTemp,
        this.userLat,
        this.userLong});

  CreateRideRequest.fromJson(Map<String, dynamic> json) {
    bokkingType = json['bokkingType'];
    cabcategoriesIdR = json['cabcategoriesIdR'];
    dropLat = json['dropLat'];
    dropLocation = json['dropLocation'];
    dropLong = json['dropLong'];
    id = json['id'];
    maxDistance = json['maxDistance'];
    pickupLocation = json['pickupLocation'];
    price = json['price'];
    userIdTemp = json['userIdTemp'];
    userLat = json['userLat'];
    userLong = json['userLong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bokkingType'] = this.bokkingType;
    data['cabcategoriesIdR'] = this.cabcategoriesIdR;
    data['dropLat'] = this.dropLat;
    data['dropLocation'] = this.dropLocation;
    data['dropLong'] = this.dropLong;
    data['id'] = this.id;
    data['maxDistance'] = this.maxDistance;
    data['pickupLocation'] = this.pickupLocation;
    data['price'] = this.price;
    data['userIdTemp'] = this.userIdTemp;
    data['userLat'] = this.userLat;
    data['userLong'] = this.userLong;
    return data;
  }
}