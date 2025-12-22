import 'package:biddy_driver/network/api_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/driverinfo.dart';

class AppConstant {

  static ApiHelper apiHelper=ApiHelper();
  static DriverDetailsInfo info=DriverDetailsInfo();



  //Ride Status
  static const String status_pending="PENDING";
  static const String status_accepted="ACCEPTED";
  static const String status_end_ride="COMPLETED";
  static const String status_ride_request="REQUESTED";
  static const String status_ride_ongoing="IN_PROGRESS";
  static const String type_of_ride_default="Default";
  static const String type_of_ride_bidding="Bidding";
  static const String status_notfond_driver="not_found_driver";
  static const String status_ride_cancel_by_customer="cancel_by_customer";
  static const String status_ride_cancel_by_driver="cancel_by_driver";
  static final String GOOGLE_KEY ="AIzaSyAm332fBuy8QoCC6ZFv7pizIqdmaT-jz30";


}
