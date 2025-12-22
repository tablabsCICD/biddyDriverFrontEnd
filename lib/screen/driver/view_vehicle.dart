import 'dart:convert';
import 'dart:typed_data';
import 'package:biddy_driver/constant/api_constant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/model/base_model/vehicle_model.dart';
import 'package:biddy_driver/provider/vehicle_provider.dart';
import 'package:biddy_driver/util/colors.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:biddy_driver/widgets/app_bar.dart';
import 'package:biddy_driver/widgets/toast.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:biddy_driver/provider/registration_provider.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:biddy_driver/widgets/profile_custom_textfeild.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../route/app_routes.dart';
import '../../model/cabDetails.dart';
import '../../widgets/button.dart';
import '../../widgets/text_input_Field.dart';

class VehicleDetail extends StatefulWidget {

  VehicleDetail({Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VehicleDetailState();
  }
}

class VehicleDetailState extends State<VehicleDetail> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => VehicleProvider(context),
      builder: (context, child) => _buildPage(context),
    );
  }

   _buildPage(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ApplicationAppBar().appBarWithAddButton(context, "Vehicle Details","Add Vehicle",(){
        Navigator.pushNamed(
            context, AppRoutes.driverCabRegistration);
      }),
      body: Consumer<VehicleProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: provider.vehicleList.length,
              itemBuilder: (context,index){
                return detailCard(index,provider.vehicleList[index],provider);
              }
          );},
      ),
    );
  }

  detailCard(int index, Vehicle vehicle, VehicleProvider provider) {
    return SizedBox(
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 7,
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: ThemeColor.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_balance,size: 20,),
                      SizedBox(width: 15,),
                      Text(
                        "Vehicle Details",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Remove Vehicle',style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w600,
                            ),),
                            content: Text('Are you sure you want to remove this vehicle?',style: TextStyle(
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
                                  ApiResponse apiResponse = await provider.deleteVehicle(vehicle);
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
                    },
                    child: SvgPicture.asset("assets/delete.svg")
                  ),

                ],
              ),


              SizedBox(height: 10,),

              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children: [
                    Text(
                      vehicle.make.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      vehicle.model.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      vehicle.vinNumber.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      vehicle.vehicleLicensePlateNumber.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}
