import 'dart:convert';
import 'dart:typed_data';

import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/saveDriverCabDetails.dart';
import 'package:biddy_driver/provider/bank_details_provider.dart';
import 'package:biddy_driver/provider/registration_provider.dart';
import 'package:biddy_driver/model/cabDetails.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:biddy_driver/widgets/app_bar.dart';
import 'package:biddy_driver/widgets/custom_dropdown_list.dart';
import 'package:biddy_driver/widgets/datepicker.dart';
import 'package:biddy_driver/widgets/profile_custom_textfeild.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../route/app_routes.dart';
import '../../widgets/button.dart';
import '../../widgets/text_input_Field.dart';

class AddBankDetailsScreen extends StatefulWidget {
  const AddBankDetailsScreen({
    super.key,

  });

  @override
  State<StatefulWidget> createState() {
    return AddBankDetailsScreenState();
  }
}

class AddBankDetailsScreenState extends State<AddBankDetailsScreen> {
  late BankDetailsProvider bankDetailsProvider;

  TextEditingController accountHolderNameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController bankNameController = TextEditingController();
  TextEditingController swiftCodeController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
 // int driverId;
  AddBankDetailsScreenState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => BankDetailsProvider(context),
      builder: (context, child) => _buildPage(context),
    );

  }



  _buildPage(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: AppButton(
            buttonTitle: "Add Bank Details",
            onClick: () {
             if (_formKey.currentState!.validate()) {
             //  Navigator.pushNamed(context, AppRoutes.bank_details);
                addBankDetails();
              } else {
                SnackBar snackBar = const SnackBar(
                  content: Text("Please fill required data"),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            enbale: true),
      ),
      appBar: ApplicationAppBar().commonAppBar(context, "Add Bank Details"),
      body: Consumer<BankDetailsProvider>(
        builder: (context, provider, child) {
          this.bankDetailsProvider = provider;
          return Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),

                  ProfileCustomTextField(
                    hintText: 'Enter Bank Holder Name',
                    controller: accountHolderNameController,
                    textInputType: TextInputType.text,
                    validatorMsg: "please enter bank holder name",
                    isValidator: true,
                  ),
                  ProfileCustomTextField(
                    hintText: 'Enter Account Number',
                    controller: accountNumberController,
                    textInputType: TextInputType.number,
                    validatorMsg: "please enter account number",
                    isValidator: true,
                  ),

                  ProfileCustomTextField(
                      hintText: 'Enter SwiftCode',
                      controller: swiftCodeController,
                      textInputType: TextInputType.number,
                      validatorMsg: "please enter swift code",
                      isValidator: true,
                  ),
                  ProfileCustomTextField(
                    hintText: 'Enter Bank Name',
                    controller: bankNameController,
                    textInputType: TextInputType.text,
                    validatorMsg: "please enter bank name",
                    isValidator: true,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> addBankDetails() async {
    ApiResponse apiResponse = await bankDetailsProvider.addBankDetailsApi(
      accountHolderNameController.text,
        accountNumberController.text,
        swiftCodeController.text,
        bankNameController.text
    );
    final res = json.decode(apiResponse.response);
    print(res);
    if (apiResponse.status == 200 ||apiResponse.status==201) {
      if (res["success"] == true) {
        print("MAIN SCREEN RESPONSE ${res["message"]}");
        Navigator.pushReplacementNamed(context, AppRoutes.bank_details);
      } else {
        print("MAIN SCREEN ELSE RESPONSE ${res["message"]}");
        SnackBar snackBar = SnackBar(
          content: Text(res["message"]),
          duration: Duration(seconds: 5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      SnackBar snackBar = SnackBar(
        content: Text("${apiResponse.status} ${res["message"]}"),
        duration: Duration(seconds: 2),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
