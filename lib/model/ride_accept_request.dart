class RideAcceptRequest {
  double? bidAmount;
  int? driverId;
  double? fare;
  int? id;
  String? paymentMode;
  String? status;
  int? vehicleId;

  RideAcceptRequest(
      {this.bidAmount,
        this.driverId,
        this.fare,
        this.id,
        this.paymentMode,
        this.status,
        this.vehicleId});

  RideAcceptRequest.fromJson(Map<String, dynamic> json) {
    bidAmount = json['bidAmount'];
    driverId = json['driverId'];
    fare = json['fare'];
    id = json['id'];
    paymentMode = json['paymentMode'];
    status = json['status'];
    vehicleId = json['vehicleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bidAmount'] = this.bidAmount;
    data['driverId'] = this.driverId;
    data['fare'] = this.fare;
    data['id'] = this.id;
    data['paymentMode'] = this.paymentMode;
    data['status'] = this.status;
    data['vehicleId'] = this.vehicleId;
    return data;
  }
}
