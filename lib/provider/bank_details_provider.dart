import 'dart:convert';

import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/bank_reponse.dart';
import 'package:biddy_driver/model/base_model/bank_model.dart';
import 'package:biddy_driver/model/saveDriverCabDetails.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/provider/provider.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/model/cabDetails.dart';
import 'package:biddy_driver/util/get_date.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constant/api_constant.dart';

class BankDetailsProvider extends BaseProvider {

  BankDetailsProvider(BuildContext context):super(""){
    getBankDetails(context);

  }

  Future<ApiResponse> addBankDetailsApi(
      String accHolderName,
      String accNumber,
      String swiftCode,
      String bankName,
      )async{
    DriverModel  userData= await LocalSharePreferences().getLoginData();
    int? uId= userData.data!.id;
    appState="Busy";
    notifyListeners();
    Map<String, dynamic> data = {
      "accountHolderName": accHolderName,
      "accountNmuber": accNumber,
      "bankName": bankName,
      "createdDate": GetDateFormat.getCurrentDate(),
      "driverId": uId,
      "id": 0,
      "isActive": "true",
      "swiftCOde": swiftCode,
      "updatedDate": GetDateFormat.getCurrentDate()
    };
    print(data);
    ApiResponse apiResponse =await AppConstant.apiHelper.postDataArgument(APIConstants.ADD_BANK,data);
    print("Bank Response : ${apiResponse.response} ${apiResponse.status}");
    if(apiResponse.status==200||apiResponse.status==201){
      appState="Ideal";
      notifyListeners();
      print('the sccussess:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }else{
      appState="Ideal";
      notifyListeners();
      print('the Failed:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }
  }

  List<BankDetails> bankDetailsByDriverId = [];
  bool isLoading = false;

 getBankDetails(BuildContext context) async {
   isLoading = true;
   notifyListeners();
   String myUrl = APIConstants.BASE_URL +'api/getAll?page=0&size=10&sortDir=asc';
   print(myUrl);
   ApiResponse apiResponse =await AppConstant.apiHelper.ApiGetData(myUrl);
   print("Bank List Response : ${apiResponse.response} ${apiResponse.status}");
   isLoading = false;
   if(apiResponse.status==200||apiResponse.status==201){
     final res = json.decode(apiResponse.response);
     print('the sccussess:${apiResponse.response}');
    BankDetailsResponse bankDetailsModel = BankDetailsResponse.fromJson(res);
    if(bankDetailsModel.success==true){
      bankDetailsByDriverId.addAll(bankDetailsModel.data!);
    }
     appState="Ideal";
     notifyListeners();
     return apiResponse;
   }else{
     appState="Ideal";
     notifyListeners();
     print('the Failed:${apiResponse.response}');
     appState="Ideal";
     notifyListeners();
     return apiResponse;
   }
 }


  deleteBankDetails(BankDetails bankDetails) async {
    String myUrl = APIConstants.DELETEBANKDETAILS+"${bankDetails.id}";
    print(myUrl);
    appState="Busy";
    notifyListeners();
    ApiResponse apiResponse =await AppConstant.apiHelper.ApiDeleteData(myUrl);
    print("Response : ${apiResponse.response}");

    if(apiResponse.status==200||apiResponse.status==201){
      print('the sccussess:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      bankDetailsByDriverId.remove(bankDetails);
      return apiResponse;
    }else{
      print('the Failed:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }
  }
}