class RideType {
  String? message;
  List<RideCatData>? data;
  bool? success;

  RideType({this.message, this.data, this.success});

  RideType.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <RideCatData>[];
      json['data'].forEach((v) {
        data!.add(new RideCatData.fromJson(v));
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

class RideCatData {
  int? catId;
  String? catName;
  double? fairAmount;
  String? catImage;
  bool ? isSelect=false;

  RideCatData({this.catId, this.catName, this.fairAmount, this.catImage});

  RideCatData.fromJson(Map<String, dynamic> json) {
    catId = json['catId'];
    catName = json['catName'];
    fairAmount = json['fairAmount'];
    catImage = json['catImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catId'] = this.catId;
    data['catName'] = this.catName;
    data['fairAmount'] = this.fairAmount;
    data['catImage'] = this.catImage;
    return data;
  }
}