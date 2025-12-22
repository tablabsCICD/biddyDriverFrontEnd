

import 'dart:convert';

import 'package:biddy_driver/provider/provider.dart';
import 'package:biddy_driver/constant/api_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/api_response.dart';
import '../constant/app_constant.dart';

class EarningProvider extends BaseProvider {
  EarningProvider(super.appState);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? selectedFromDate="2024-04-12",selectedToDate="2024-05-12";
  String? totalAmt = '900';



}

