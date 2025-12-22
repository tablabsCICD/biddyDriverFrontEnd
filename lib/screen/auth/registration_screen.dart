import 'package:biddy_driver/constant/text_constant.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'custom_button.dart';
import 'divider.dart';


class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Text(TextConstant.ennter_mobile_number,style: TextStyle(fontSize: 20 )),
              SizedBox(height: 30,),

              mobileFiled(),
              CustomButton(onTap: (){
                 // Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>OtpScreen()));
                Navigator.pushNamed(context, "/OTP",arguments: "1234");

              },
                buttonText: 'Continue',),
              GetDivider(),
              SizedBox(height: 30,),
              socialLoginButton(TextConstant.google_login,SocialLoginButtonType.google),
              SizedBox(height: 20,),
              socialLoginButton(TextConstant.apple_login,SocialLoginButtonType.apple),
              SizedBox(height: 20,),
              socialLoginButton(TextConstant.facebook_login,SocialLoginButtonType.facebook),
              SizedBox(height: 30,),
              GetDivider(),
              SizedBox(height: 30,),
              Text(TextConstant.login_instrction,style: TextStyle(fontSize: 16,))
            ],
          ),
        ),
      ),
    );
  }

  Widget socialLoginButton(String text,SocialLoginButtonType buttonType){
    return  SocialLoginButton(
      backgroundColor: Colors.grey[300],
      height: 50,
      text: text,
      textColor: Colors.black,
      borderRadius: 10,
      fontSize: 16,
      buttonType: buttonType,
      onPressed: () {

      },
    );
  }

  mobileFiled() {
    return Row(
      children: [
    Center(
    child: CountryListPick(
    theme: CountryTheme(
    isShowFlag: true,
    isShowTitle: true,
    isShowCode: false,
    isDownIcon: true,
    showEnglishName: true,
    labelColor: Colors.blueAccent,

    ),
    ),
    ),

      ],
    );

  }
}
