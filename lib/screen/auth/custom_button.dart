import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  Function onTap;
  final String? buttonText;

  CustomButton({required this.onTap, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 0,vertical: 15),
       height: 50,
      child: ElevatedButton(
        onPressed: (){
          onTap();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 0),
          child: Text(buttonText!,
              style: TextStyle(color: Colors.white,fontSize: 20)),
        ),
      ),
    );
  }
}

