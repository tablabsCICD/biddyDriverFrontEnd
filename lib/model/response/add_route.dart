import 'package:biddy_driver/model/base_model/preffered_route.dart';
import 'package:biddy_driver/screen/add_routes.dart';

class AddPrefferedRouteResponse {
  String? message;
  PrefferedRoute? data;
  bool? success;

  AddPrefferedRouteResponse({this.message, this.data, this.success});

  AddPrefferedRouteResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new PrefferedRoute.fromJson(json['data']) : null;
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

