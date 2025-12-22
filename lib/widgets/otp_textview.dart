import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtpTextView extends StatelessWidget{

 final TextEditingController otpController ;
final Function onChnage;
  const OtpTextView({super.key, required this.otpController, required this.onChnage});
  @override
  Widget build(BuildContext context) {
   return Container(
     height: 45,
     width: 45,
     child: TextFormField(
       controller: otpController,
       maxLength: 1,
       obscureText: false,
       keyboardType: TextInputType.number,
          autofocus: true,
       decoration: InputDecoration(
         border: OutlineInputBorder(),
         labelText: "",

         counterText: "",

       ),
       onChanged: (value){
         if(value.length>=1){
           FocusScope.of(context).nextFocus();
         }else{
           FocusScope.of(context).previousFocus();
         }

         onChnage();

       },
     ),
   );

  }




}