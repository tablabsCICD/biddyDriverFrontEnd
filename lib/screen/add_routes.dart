import 'dart:convert';
import 'dart:typed_data';

import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/base_model/preffered_route.dart';
import 'package:biddy_driver/model/saveDriverCabDetails.dart';
import 'package:biddy_driver/provider/preffered_route_provider.dart';
import 'package:biddy_driver/provider/registration_provider.dart';
import 'package:biddy_driver/model/cabDetails.dart';
import 'package:biddy_driver/util/colors.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:biddy_driver/widgets/app_bar.dart';
import 'package:biddy_driver/widgets/custom_dropdown_list.dart';
import 'package:biddy_driver/widgets/datepicker.dart';
import 'package:biddy_driver/widgets/profile_custom_textfeild.dart';
import 'package:biddy_driver/widgets/toast.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../route/app_routes.dart';
import '../../widgets/button.dart';
import '../../widgets/text_input_Field.dart';

class AddPreferredRoute extends StatefulWidget {
 // final int driverId;

  const AddPreferredRoute({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return AddPreferredRouteState();
  }
}

class AddPreferredRouteState extends State<AddPreferredRoute> {
  late PrefferedRouteProvider prefferedRouteProvider;

  TextEditingController fromController = TextEditingController();
  TextEditingController toController = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  //int driverId;
  AddPreferredRouteState();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PrefferedRouteProvider(context),
      builder: (context, child) => _buildPage(context),
    );

  }


  _buildPage(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
        child: AppButton(
            buttonTitle: "Continue",
            onClick: () {
              if (_formKey.currentState!.validate()) {

              } else {
                SnackBar snackBar = const SnackBar(
                  content: Text("Please fill required data"),
                  duration: Duration(seconds: 2),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                Navigator.pushNamed(context,AppRoutes.home);
              }
            },
            enbale: true),
      ),
      appBar: ApplicationAppBar().commonAppBar(context, "Preferred Routes"),
      body: Consumer<PrefferedRouteProvider>(
        builder: (context, provider, child) {
          this.prefferedRouteProvider = provider;
          return Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextView(title: "Add Your Preferred Route", fontSize: 16, color: Colors.black, fontWeight: FontWeight.w500),
                    /*SizedBox(
                      height: 10,
                    ),
                    TextView(title: "Add Your Preferred Route for ride", fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400),*/
                    SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                        constraints: BoxConstraints(
                            maxHeight: 195, minHeight: 0.0),
                        child: listviewCity(provider.routeList,provider)),

                    SizedBox(height: 24,),
                    placesAutoCompleteTextField(fromController,true),
                    Container(
                      height: 80,
                      width: 1,
                      decoration: BoxDecoration(
                        border:Border.all(color: Colors.green)
                      ),
                    ),
                    placesAutoCompleteTextField(toController,false),
                    SizedBox(height: 16,),
                    addRoute(provider)
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  listviewCity(List<PrefferedRoute> routeList, PrefferedRouteProvider provider) {
    return ListView.builder(

      itemCount: routeList.length,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        return routeItem(i,routeList[i],provider);
      },
    );
  }

  routeItem( int index, PrefferedRoute routeList, PrefferedRouteProvider provider) {
    return Container(
      width: 335,
      height: 40.65,
      //padding: EdgeInsets.only(left: 20.w,right: 20.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 37.65,
              width: 247,
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.50, color: Color(0x332C363F)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        "${routeList.source}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xCC001E49),
                          fontSize: 12,
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  SvgPicture.asset("assets/return_route.svg"),
                  SizedBox(width: 16),

                  Expanded(
                    child: SizedBox(
                      child: Text(
                       "${routeList.destination}",
                        style: TextStyle(
                          color: Color(0xCC001E49),
                          fontSize: 12,
                          fontFamily: GoogleFonts
                              .poppins()
                              .fontFamily,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20,),
          Container(
            width: 24,
            height: 24,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  child: Stack(children: [
                    InkWell(onTap: () {

                    //  provider.editRoute(context, index);

                    }, child: SvgPicture.asset("assets/edit.svg"))

                  ]),
                ),
              ],
            ),
          ),
          SizedBox(width: 20,),
          Container(
            width: 24,
            height: 24,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  child: Stack(children: [

                    InkWell(onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Remove Route',style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w600,
                            ),),
                            content: Text('Are you sure you want to remove this route?',style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w400,
                            ),),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                                child: Text('No',style: TextStyle(color: ThemeColor.theme_blue, fontSize: 12,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.w600,),),
                              ),
                              TextButton(
                                onPressed: () async {
                                  ApiResponse apiResponse = await provider.deleteRoute(routeList);
                                  final response = json.decode(apiResponse.response);

                                  if(response["success"]==true){
                                    ToastMessage.show(context, response["message"]);
                                  }else{
                                    ToastMessage.show(context, response["message"]);
                                  }
                                  Navigator.of(context).pop();// Close the dialog

                                },
                                child: Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.green, fontSize: 12,
                                    fontFamily: GoogleFonts.poppins().fontFamily,
                                    fontWeight: FontWeight.w600,),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                    }, child: SvgPicture.asset("assets/delete.svg"))

                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(PrefferedRouteProvider prefferedRouteProvider) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  TextView(title: "Add Preffered Route", fontSize: 14,fontWeight: FontWeight.w500, color: Colors.black,),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextView(title: "You want to add Preffered Route", fontSize: 12,fontWeight: FontWeight.w500, color: Colors.black,),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  TextView(title: "Yes", fontSize: 12,fontWeight: FontWeight.w500, color: Colors.green,),
              onPressed: () async {
                ApiResponse apiResponse = await prefferedRouteProvider.addPrefferedRouteApi(context,fromController.text, toController.text);
                print(apiResponse.response);
                var response = jsonDecode(apiResponse.response);
                if(response['success']==true){
                  SnackBar snackBar = SnackBar(
                    content: Text(response["message"]),
                    duration: Duration(seconds: 2),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  fromController.text = "";
                  toController.text = "";
                  setState(() {

                  });
                }
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  TextView(title: "No", fontSize: 12,fontWeight: FontWeight.w500, color: Colors.red,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  addRoute(PrefferedRouteProvider prefferedRouteProvider) {
    return InkWell(
      onTap: () async {
        _showMyDialog(prefferedRouteProvider);
      },
      child: SvgPicture.asset("assets/additional_label.svg"),
    );
  }

  placesAutoCompleteTextField(TextEditingController controller,bool isFromRoot) {
    return Container(
      height: 50,
      margin: EdgeInsets.all(16),
      child: GooglePlacesAutoCompleteTextFormField(
        textEditingController: controller,
        googleAPIKey: APIConstants.GOOGLEAPIKEY,
        decoration: const InputDecoration(
          hintText: 'Enter your address',
          labelText: 'Address',
          labelStyle: TextStyle(color: Colors.black,fontSize: 14),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        // proxyURL: _yourProxyURL,
        maxLines: 1,
        overlayContainer: (child) => Material(
          elevation: 1.0,
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: child,
        ),
        getPlaceDetailWithLatLng: (prediction) {
          print('placeDetails${prediction.lng}');
        },
        itmClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          int firstIndex = controller.text.indexOf(",");
          if(isFromRoot){
            fromController.text = controller.text.substring(0, firstIndex);
          }else{
            toController.text = controller.text.substring(0, firstIndex);
          }
          }
      ),
    );
  }
}
