import 'package:biddy_driver/util/colors.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class ApplicationAppBar{

  commonAppBar(BuildContext context,String title){
    return AppBar(
      title: Text(
        title,
       style: TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

  }

  appBarWithAddButton(BuildContext context,String title,String buttonTitle,Function onTap){
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          child: TextView(
              title: buttonTitle,
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 12),
          onPressed: (){
            onTap();
          },
          style: ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),backgroundColor: ThemeColor.primary,disabledBackgroundColor: Colors.grey,foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),

        ),
      ],
    );

  }


}