import 'package:biddy_driver/model/base_model/preffered_route.dart';

class GetAllPrefferedRoute {
  String? message;
  List<PrefferedRoute>? data;
  bool? success;

  GetAllPrefferedRoute({this.message, this.data, this.success});

  GetAllPrefferedRoute.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <PrefferedRoute>[];
      json['data'].forEach((v) {
        data!.add(new PrefferedRoute.fromJson(v));
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