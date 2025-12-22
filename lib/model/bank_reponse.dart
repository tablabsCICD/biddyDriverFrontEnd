import 'package:biddy_driver/model/base_model/bank_model.dart';

class BankDetailsResponse {
  String? message;
  List<BankDetails>? data;
  bool? success;

  BankDetailsResponse({this.message, this.data, this.success});

  BankDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <BankDetails>[];
      json['data'].forEach((v) {
        data!.add(new BankDetails.fromJson(v));
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


