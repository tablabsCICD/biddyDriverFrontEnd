import 'dart:async';
import 'dart:convert';
import 'package:biddy_driver/constant/imageconstant.dart';
import 'package:biddy_driver/constant/prefrenseconstant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/provider/login_provider.dart';
import 'package:biddy_driver/constant/text_constant.dart';
import 'package:biddy_driver/util/colors.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import '../../route/app_routes.dart';
import '../../widgets/button.dart';
import '../../widgets/otp_textview.dart';
import '../../widgets/toast.dart';

class OtpScreen extends StatefulWidget {
  final String mobileNumber;

  const OtpScreen({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState(mobileNumber);
}

class _OtpScreenState extends State<OtpScreen> {
  late LoginProvider provider;
  String mob;

  bool isResendEnble = false;
  bool enbleLoginButton = false;

  _OtpScreenState(this.mob);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginProvider("Ideal"),
      builder: (context, child) => _buildPage(context),
    );
  }

  cardView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        enterOtpWidget(),
        SizedBox(
          height: 20,
        ),
        verifyButton(),
        SizedBox(
          height: 20,
        ),
        resendButton()
      ],
    );
  }

  textEnterMobile() {
    return TextView(
      title: TextConstant.enter_otp,
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Colors.black54,
    );
  }

  enterOtpWidget() {
    return Form(
      key: formKey,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: PinCodeTextField(
            appContext: context,
            pastedTextStyle: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
            ),
            length: 6,
            obscureText: true,
            obscuringCharacter: '*',
            // animationType: AnimationType.fade,
            validator: (v) {
              if (v!.length < 6 || v.isEmpty) {
                return "*Please fill up all the cells properly";
              } else {
                return null;
              }
            },
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 40,
              fieldWidth: 40,
              //activeFillColor:
              //  hasError ? Colors.white : Colors.white,
            ),
            cursorColor: Colors.black,
            textStyle: TextStyle(fontSize: 20, height: 1.6),
            errorAnimationController: errorController,
            controller: otpController,
            keyboardType: TextInputType.number,
            boxShadows: [
              BoxShadow(
                offset: Offset(0, 1),
                color: Colors.black12,
              )
            ],
            onCompleted: (v) {
              setState(() {
                currentText = v;
              });
            },
            onChanged: (value) {
              print(value);
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              return true;
            },
          )),
    );
  }

  TextEditingController otpController = new TextEditingController();
  var onTapRecognizer;

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  verifyButton() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: AppButton(
            buttonTitle: "Login",
            onClick: () async {
              //  Navigator.pushReplacementNamed(context, AppRoutes.earning);
              callVerfiyOtp();
            },
            enbale: true),
      ),
    );
  }

  registerAccount() {
    return Center(
      child: Text(" Register Here "),
    );
  }

  OtpSend() {
    return isResendEnble == true
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                TextView(
                  title: TextConstant.resend_otp,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.primary,
                  fontSize: 14,
                )
              ])
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                TextView(
                  title: TextConstant.resendOTPSec(_start),
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 14,
                )
              ]);
  }

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    startTimer();
  }

  _buildPage(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          this.provider = provider;
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.grey,
                    height: 100,
                    child: Image.asset(
                      ImageConstant.LOGIN_IMAGE,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextView(
                      title: "SMS Code",
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Center(
                      child: TextView(
                          title:
                              "Enter 6 digit code which was sent to ${widget.mobileNumber}",
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  cardView(),
                ],
              ),
            ),
          ));
        },
      ),
    );
  }

  // String otp;

  checkOTPEnble() {
    if (otpController.text.length == 6) {
      enbleLoginButton = true;
      setState(() {});
    } else {
      enbleLoginButton = false;
      setState(() {});
    }
  }

  void callVerfiyOtp() async {
    ApiResponse apiResponse = await provider.VerifyOtp(mob, otpController.text);
    final verify = json.decode(apiResponse.response);
    if (verify["message"].toString().contains("verify OTP sucess") || verify["success"]==true) {
      ToastMessage.show(context, "${verify["message"]}");
      DriverModel userData = DriverModel.fromJson(verify);
      if (userData.data!.emailId == null) {
        Navigator.pushReplacementNamed(context, AppRoutes.register,
            arguments: mob);
      } else {
        String response = jsonEncode(verify);
        LocalSharePreferences()
            .setString(SharedPreferencesConstan.LoginKey, response);
        LocalSharePreferences()
            .setBool(SharedPreferencesConstan.LoginKeyBool, true);
        Navigator.pushReplacementNamed(context, AppRoutes.entryScreen);
      }
    } else {
      ToastMessage.show(context, "${verify["message"]}");
    }
  }

  late Timer _timer;
  int _start = 160;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (!mounted) return; // widget is no longer in the tree
        if (_start == 0) {
          setState(() {
            isResendEnble = true;
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }


  @override
  void dispose() {
    _timer.cancel(); // cancel the timer when widget is disposed
    errorController.close(); // also close the stream controller
    otpController.dispose(); // dispose text controller
    super.dispose();
  }


  resendButton() {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
      child: ElevatedButton(
        onPressed: isResendEnble == true
            ? () {
                _start = 160;
                isResendEnble = false;
                startTimer();
                setState(() {});
                provider.sendOtp(mob);
              }
            : null,
        style: ElevatedButton.styleFrom(
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            padding: EdgeInsets.all(12),
            backgroundColor: ThemeColor.white,
            disabledBackgroundColor: Colors.grey.shade200,
            foregroundColor: Colors.white),
        child: OtpSend(),
      ),
    );
  }
}
