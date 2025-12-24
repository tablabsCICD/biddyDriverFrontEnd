class RideBid {
  int? bidAmount;
  int? driverId;
  int? id;
  int? rideId;
  String? status;
  int? vehicleId;
  String? lattitude;
  String? longitude;

  RideBid({
    this.bidAmount,
    this.driverId,
    this.id,
    this.rideId,
    this.status,
    this.vehicleId,
    this.lattitude,
    this.longitude,
  });

  factory RideBid.fromJson(Map<String, dynamic> json) {
    return RideBid(
      bidAmount: json['bidAmount'],
      driverId: json['driverId'],
      id: json['id'],
      rideId: json['rideId'],
      status: json['status'],
      vehicleId: json['vehicleId'],
      lattitude: json['lattitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "bidAmount": bidAmount,
      "driverId": driverId,
      "id": id,
      "rideId": rideId,
      "status": status,
      "vehicleId": vehicleId,
      "lattitude": lattitude,
      "longitude": longitude,
    };
  }
}
