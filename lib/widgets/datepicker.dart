import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class DateTimePickerDialog{
  late DateTime _selectedDate;

  String selectedDate = "";
  String TimeCnt = "";
  String? _hour, _minute, _time;
  String? dateTime;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  DateTime _currentDate = DateTime.now();


  Future<String> pickDateDialog(context) async{
    DateTime? _datePicker = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(1947),
      lastDate: DateTime(2030),
    );
    if (_datePicker != null && _datePicker != _currentDate) {
      DateTime? date;
      if (_datePicker.isBefore(DateTime.now())) {
        date = _datePicker;
        selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
      } else {
        date = _datePicker;
        selectedDate = DateFormat("yyyy-MM-dd").format(_datePicker);           //resFromDateCnt;
      }
    }
    return selectedDate;

    /*await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return null;
      }
      _selectedDate=pickedDate;
    });
    if(_selectedDate!=null){
      return GetDateFormat.getFormatedDate(_selectedDate);
    }
    return "Select Date";*/
  }

  Future<String> pickDateAfterDialog(context,String fromDate) async{

    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(fromDate);
    DateTime? _datePicker = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(1947),
      lastDate: DateTime(2030),
    );
    if (_datePicker != null && _datePicker != _currentDate) {
      DateTime? date;
      if (_datePicker.isAfter(tempDate)) {
        date = _datePicker;
        selectedDate = DateFormat("yyyy-MM-dd").format(_datePicker);
      } else {
        date = _datePicker;
        selectedDate = DateFormat("yyyy-MM-dd").format(tempDate.add(const Duration(days: 5)));           //resFromDateCnt;
      }
    }
    return selectedDate;

    /*await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return null;
      }
      _selectedDate=pickedDate;
    });
    if(_selectedDate!=null){
      return GetDateFormat.getFormatedDate(_selectedDate);
    }
    return "Select Date";*/
  }

  Future<String> pickBeforeDateDialog(context) async{
    DateTime? _datePicker = await showDatePicker(
      initialDatePickerMode: DatePickerMode.day,
      context: context,
      initialDate: _currentDate,
      firstDate: DateTime(1947),
      lastDate: DateTime(2030),
    );
    if (_datePicker != null && _datePicker != _currentDate) {
      // selectedDate = DateFormat("yyyy-MM-dd").format(_datePicker);           //resFromDateCnt;
      DateTime? date;
      if (_datePicker.isBefore(DateTime.now())) {
        date = _datePicker;
        selectedDate = DateFormat("yyyy-MM-dd").format(_datePicker);
      } else {
        date = _datePicker;
        selectedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());           //resFromDateCnt;
      }
    }

    return selectedDate;

    /*await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //which date will display when user open the picker
        firstDate: DateTime(1950),
        //what will be the previous supported year in picker
        lastDate: DateTime
            .now()) //what will be the up to supported date in picker
        .then((pickedDate) {
      //then usually do the future job
      if (pickedDate == null) {
        //if user tap cancel then this function will stop
        return null;
      }
      _selectedDate=pickedDate;
    });
    if(_selectedDate!=null){
      return GetDateFormat.getFormatedDate(_selectedDate);
    }
    return "Select Date";*/
  }


  Future<String> selectTime(BuildContext context) async {

    /*TimeOfDay initialTime = TimeOfDay.now();
    TimeOfDay? picked =await showTimePicker(context: context, initialTime: initialTime);
    if (picked != null && picked != TimeOfDay.now() ){
     String time="${picked.hour}:${picked.minute}";
      return time;
    }

    return "Select Time";*/


    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) selectedTime = picked;
    _hour = selectedTime.hour.toString();
    _minute = selectedTime.minute.toString();

    _hour = _hour!.length == 1 ? "0$_hour" : _hour;
    _minute = _minute!.length == 1 ? "0$_minute" : _minute;
    _time = _hour! + ' : ' + _minute!;

    if (picked?.periodOffset.toString() == '0') {
      TimeCnt = (_time).toString();
    } else if (picked?.periodOffset.toString() == '12') {
      TimeCnt = (_time).toString();
    }
    return TimeCnt;
  }


}