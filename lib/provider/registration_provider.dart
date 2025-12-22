import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/saveDriverCabDetails.dart';
import 'package:biddy_driver/provider/provider.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/model/cabDetails.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:intl/intl.dart';

import '../constant/api_constant.dart';
import '../model/base_model/driver_model.dart';

class RegistrationProvider extends BaseProvider {
  RegistrationProvider(super.appState);

  Future<ApiResponse> RegisterUser(
      String fname,
      String lname,
      String email,
      String birthdate,
      String gender,
      String mobileNumber,
      String licenceNumber,
      String licenceExpDate,
      String licenceState,
      String onlineTime,
      String offlineTime,
      String SSNumner,
      String status,
      String photo,
      String backgroundCheckStatus)async{
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    print("Date : "+date);
    appState="Busy";
    notifyListeners();
     Map<String, dynamic> data = {
       "backgroundCheckDate": date,
       "backgroundCheckStatus": backgroundCheckStatus,
       "createdDate": date,
       "deviceId": "string",
       "dob": birthdate,
       "driverLicensenExpirationDate": licenceExpDate,
       "driverLicensenState": licenceState,
       "driverLicensenumber": licenceExpDate,
       "emailId": email,
       "first_name": fname,
       "id": 0,
       "isActive": "true",
       "isBook": false,
       "last_name": lname,
       "offlineTime": offlineTime.toString(),
       "onlineTime": onlineTime.toString(),
       "os": "Android",
       "otp": "123456",
       "password": "123456",
       "phoneNumber": mobileNumber,
       "photo": photo,
       "preferedRoute": true,
       "registerState": "mha",
       "socialSecurityNumber": SSNumner,
       "status": status,
       "updatedDate": date,
       "zone": "string"
     };
      print(data);
   ApiResponse apiResponse= await AppConstant.apiHelper.ApiPutDataWithBody(APIConstants.EDIT_PROFILR,data);
  //  ApiResponse apiResponse =await AppConstant.apiHelper.putDataArgument(APIConstants.SIGNUP,data);
    print(APIConstants.EDIT_PROFILR);
    print("User update Response : ${apiResponse.response} ${apiResponse.status}");
    if(apiResponse.status==200||apiResponse.status==201){
      appState="Ideal";
      notifyListeners();
      print('the sccussess:${apiResponse.response}');
      //class name=jsonEncode(apiResponse.response);
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


  Future<ApiResponse> uploadDocumnet(int driverId,String doc)async{
      String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    appState="Busy";
    notifyListeners();

    Map<String,dynamic> data = {
      "createdAt": date,
      "document": doc,
      "driverId": driverId,
      "updatedAt": date,
      "verified": "false"
    };

    ApiResponse apiResponse =await AppConstant.apiHelper.postDataArgument(APIConstants.UPLOAD_DOC,data);
    print("upload document Response : ${apiResponse.response}");

    if(apiResponse.status==200||apiResponse.status==201){
      appState="Ideal";
      notifyListeners();
      print('the sccussess:${apiResponse.response}');
      //class name=jsonEncode(apiResponse.response);
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

  Future<ApiResponse> setOnlineOffline(String isOnline)async{
    DriverModel  userData= await LocalSharePreferences().getLoginData();
    int? uId= userData.data!.id;
    appState="Busy";
    notifyListeners();
    Map<String, dynamic> data = {
      "id": uId,
      "isActive": isOnline
    };
    print(data);
    ApiResponse apiResponse =await AppConstant.apiHelper.postDataArgument(APIConstants.ISONLINE,data);
    print("Online/Offline Response : ${apiResponse.response} ${apiResponse.status}");
    if(apiResponse.status==200||apiResponse.status==201){
      print('the sccussess:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }else{
      print('the Failed:${apiResponse.response}');
      appState="Ideal";
      notifyListeners();
      return apiResponse;
    }
  }

}