import 'dart:convert';


import 'package:biddy_driver/constant/prefrenseconstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/base_model/driver_model.dart';

class LocalSharePreferences{
  static final LocalSharePreferences localSharePreferences = LocalSharePreferences._internal();
  factory LocalSharePreferences() {
    return localSharePreferences;
  }
  LocalSharePreferences._internal();
  setString(String key,String val)async{
   SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString(key,val);
  }
  setBool(String key,bool val)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool(key,val);
  }
  Future<String> getString(String key)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key)!;
  }

 Future<bool> getBool(String key)async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
   bool val =false;
   if(_prefs.getBool(key)!=null){
     val=_prefs.getBool(key)!;
   }
    return val;
  }

  Future<DriverModel> getLoginData() async{
   String data  = await getString(SharedPreferencesConstan.LoginKey);
   DriverModel datas=DriverModel.fromJson(jsonDecode(data));
   print('the data is ${datas.data!.firstName}');
   return datas;
  }

  Future<bool> logOut()async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    setBool(SharedPreferencesConstan.LoginKeyBool, false);
    return true;
  }


}