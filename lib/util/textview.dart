import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class TextView extends StatelessWidget{
  final String title;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;


  TextView({Key? key, required this.title,required this.fontSize,required this.color,required this.fontWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,style: TextStyle(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      fontFamily: GoogleFonts.poppins().fontFamily,
    ),
    maxLines: 3,);
  }



}