import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GetDateInString {

 // static String formatDate="dd-MM-yyyy";


  static String getDate(String dateTimeString){
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    print("Date: $formattedDate");
    return formattedDate;
  }

  static String getTime(String dateTimeString){
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime = DateFormat('HH:mm:ss').format(dateTime);
    print("Time: $formattedTime");
    return formattedTime;
  }


}