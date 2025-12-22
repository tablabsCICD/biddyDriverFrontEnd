import 'dart:convert';
import 'package:biddy_driver/constant/imageconstant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/provider/login_provider.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_field/intl_phone_number_field.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../route/app_routes.dart';
import '../../widgets/button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late LoginProvider provider;
  TextEditingController mobileController = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> slideAnimation;
  late Animation<double> fadeAnimation;

  bool isLoading = false; // For shimmer loader

  @override
  void initState() {
    super.initState();

    loadFromJson();

    // Animation
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );

    slideAnimation =
        Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        );

    fadeAnimation =
        Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider("Ideal"),
      builder: (_, __) => _buildPage(context),
    );
  }

  // -------------------------
  // MAIN PAGE
  // -------------------------
  _buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          this.provider = provider;

          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: FadeTransition(
                  opacity: fadeAnimation,
                  child: SlideTransition(
                    position: slideAnimation,
                    child: Column(
                      children: [
                        Image.asset(ImageConstant.LOGIN_IMAGE,
                            height: 160),

                        const SizedBox(height: 20),

                        // Modern Rounded Card
                        AnimatedContainer(
                          duration: Duration(milliseconds: 400),
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 4,
                                blurRadius: 12,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              TextView(
                                title: "Enter Mobile Number",
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                              ),
                              SizedBox(height: 10),

                              mobileTextField(),
                              SizedBox(height: 25),

                              // Shimmer Login Button
                              isLoading
                                  ? Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor:
                                Colors.grey.shade100,
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(15),
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                                  : loginButton(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // -------------------------
  // PHONE FIELD
  // -------------------------
  Widget mobileTextField() {
    return InternationalPhoneNumberInput(
      height: 52,
      controller: mobileController,
      formatter: MaskedInputFormatter('##########'),
      initCountry: CountryCodeModel(
          name: "India", dial_code: "+91", code: "IN"),
      betweenPadding: 10,
      loadFromJson: loadFromJson,
      onInputChanged: (phone) {},
      countryConfig: CountryConfig(
        decoration: BoxDecoration(
          border: Border.all(width: 1.4, color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      phoneConfig: PhoneConfig(
        radius: 12,
        focusedColor: Colors.indigo,
        enabledColor: Colors.grey.shade500,
        hintText: "Phone Number",
        borderWidth: 1.4,
      ),
    );
  }

  Future<String> loadFromJson() async {
    return await rootBundle.loadString(
        'assets/countries/country_list_en.json');
  }

  // -------------------------
  // LOGIN BUTTON
  // -------------------------
  Widget loginButton() {
    return AppButton(
      buttonTitle: "Continue",
      enbale: true,
      onClick: () {
        if (mobileController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Please enter mobile number")));
        } else {
          setState(() => isLoading = true);
          sendOTP();
        }
      },
    );
  }

  // -------------------------
  // API CALL
  // -------------------------
  void sendOTP() async {
    String mobNumber = mobileController.text;
    ApiResponse res = await provider.sendOtp(mobNumber);
    final body = json.decode(res.response);

    setState(() => isLoading = false);

    if (body['success'] == true) {
      Navigator.pushNamed(context, AppRoutes.otp,
          arguments: mobNumber);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(body["message"])),
      );
    }
  }
}
