import 'dart:convert';

import 'package:biddy_driver/model/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../model/login_model.dart';
class ApiHelper{

  
  Future<ApiResponse> ApiGetData(String URL) async{
    var request = await http.get(Uri.parse(URL));
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }

  Future<ApiResponse>  ApiPostData(String URL) async{
    var request = await http.post(Uri.parse(URL));
    print('the code is ${request.body}');
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }
  Future<ApiResponse>  ApiPutData(String URL) async{
    var request = await http.put(Uri.parse(URL));
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }

  Future<ApiResponse>  ApiPutDataWithBody(String URL,Map<String,dynamic>data) async{
    var body = json.encode(data);
    var request = await http.put(Uri.parse(URL),headers: {"Content-Type": "application/json"}, body: body);
    print("put response"+request.body);
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }

  Future<ApiResponse> ApiDeleteData(String URL) async{
    var request = await http.delete(Uri.parse(URL));
    ApiResponse apiResponseHelper = returnResponse(request);
    return apiResponseHelper;
  }


  Future<ApiResponse> postDataArgument(String url,Map<String,dynamic>data) async{
    var body = json.encode(data);
    print(body);
    final response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("Response ::: "+response.body);
    ApiResponse apiResponseHelper = returnResponse(response);
    return apiResponseHelper;
  }

  Future<ApiResponse> putDataArgument(String url,Map<String,dynamic>data) async{
    var body = json.encode(data);
    print("Put Request:: "+body);
    final response = await http.put(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    print("update api status code:"+response.statusCode.toString());
    print("update response:"+response.body.toString());
    ApiResponse apiResponseHelper = returnResponse(response);
    return apiResponseHelper;
  }

  ApiResponse returnResponse<T>(Response request){
    if(request.statusCode==200||request.statusCode==400||request.statusCode==201){
      var response1 = request.body;
      print("**************************************${response1}");
      ApiResponse apiResponseHelper = ApiResponse(request.statusCode, request.body);
      print("**************************************${response1}");
      return apiResponseHelper;
    }else{
      ApiResponse apiResponseHelper = ApiResponse(request.statusCode, request.body);
      return apiResponseHelper;
    }
  }
}