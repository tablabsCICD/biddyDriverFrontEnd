class RideBid {
  int? bidAmount;
  int? driverId;
  int? id;
  int? rideId;
  String? status;
  int? vehicleId;
  String? lattitude;
  String? longitude;

  RideBid(
      {this.bidAmount,

        this.driverId,
        this.id,
        this.rideId,
        this.status,
        });

  RideBid.fromJson(Map<String, dynamic> json) {
    bidAmount = json['bidAmount'];
    driverId = json['driverId'];
    id = json['id'];
    rideId = json['rideId'];
    status = json['status'];
    vehicleId = json['vehicleId'];
    lattitude = json['lattitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bidAmount'] = this.bidAmount;
    data['driverId'] = this.driverId;
    data['id'] = this.id;
    data['rideId'] = this.rideId;
    data['status'] = this.status;
    data['vehicleId'] = this.vehicleId;
    data['lattitude'] = this.lattitude;
    data['longitude'] = this.longitude;
    return data;
  }
}