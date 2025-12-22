import 'package:biddy_driver/util/colors.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget{
  final String buttonTitle;
  final Function onClick;
  final enbale;

  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
      padding: EdgeInsets.all(12),backgroundColor: ThemeColor.primary,disabledBackgroundColor: Colors.grey,foregroundColor: Colors.white

  );

  AppButton({super.key, required this.buttonTitle, required this.onClick, required this.enbale});


  @override
  Widget build(BuildContext context) {

    return ElevatedButton(onPressed: enbale==true ?(){
      onClick();

    }:null, child:TextView(
        title: buttonTitle,
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 16),style: style,);

  }



}



class AppButtonCircular extends StatelessWidget{
  final String buttonTitle;
  final Function onClick;
  final enbale;

  final ButtonStyle bstyle =
  ElevatedButton.styleFrom(textStyle: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),
    padding: EdgeInsets.all(12),backgroundColor: Colors.white,disabledBackgroundColor: Colors.grey,shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),side: BorderSide(color: Colors.grey)
    ),


  );

  AppButtonCircular({super.key, required this.buttonTitle, required this.onClick, required this.enbale});


  @override
  Widget build(BuildContext context) {

    return ElevatedButton(onPressed: enbale==true ?(){
      onClick();

    }:null, child: Text(buttonTitle,style:TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.grey) ,),style: bstyle,);

  }



}