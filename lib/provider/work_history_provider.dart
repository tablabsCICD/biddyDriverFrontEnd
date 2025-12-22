import 'package:biddy_driver/provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkHistoryProvider extends BaseProvider {
  WorkHistoryProvider(super.appState);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? totalWorkingHrs,totalRestTime,remainingWorkingHrs,remainingRestTime;
  String? totalAmt = '900';
  bool online=true;



}

