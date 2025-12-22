

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextInputFiled extends StatelessWidget{
  final String labelText;
  final TextInputType inputType;
  final TextEditingController textController ;

  const TextInputFiled({super.key, required this.labelText, required this.inputType,required this.textController});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20,bottom: 0,top: 20),
      child: TextField(
        controller: textController,
       // keyboardType: TextInputType.number,
        keyboardType: inputType,
       maxLines: 1,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(),
          labelText: labelText,
          counterText: "",


        ),
      ),
    );
  }


}