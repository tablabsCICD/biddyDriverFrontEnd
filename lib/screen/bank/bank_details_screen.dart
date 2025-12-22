
import 'dart:convert';

import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/model/api_response.dart';
import 'package:biddy_driver/model/bank_reponse.dart';
import 'package:biddy_driver/model/base_model/bank_model.dart';
import 'package:biddy_driver/provider/bank_details_provider.dart';
import 'package:biddy_driver/provider/earning_provider.dart';
import 'package:biddy_driver/route/app_routes.dart';
import 'package:biddy_driver/util/colors.dart';
import 'package:biddy_driver/widgets/app_bar.dart';
import 'package:biddy_driver/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BankDetailsScreen extends StatefulWidget {
  const BankDetailsScreen({super.key});

  @override
  State<BankDetailsScreen> createState() => _BankDetailsScreenState();
}

class _BankDetailsScreenState extends State<BankDetailsScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (BuildContext context) => BankDetailsProvider(context),
      builder: (context, child) => _buildPage(context),
    );
  }



  _buildPage(context){
    return Scaffold(
      backgroundColor: ThemeColor.white,
      key: _scaffoldKey, appBar: ApplicationAppBar().appBarWithAddButton(context, "Bank Details","ADD",(){
      Navigator.pushNamed(
          context, AppRoutes.add_bank_details);
    }),
      body: Consumer<BankDetailsProvider>(
        builder: (context, model, child) {
          return ListView.builder(
            shrinkWrap: true,
              itemCount: model.bankDetailsByDriverId.length,
              itemBuilder: (context,index){
                  return detailCard(index,model.bankDetailsByDriverId[index],model);
              }
          );},
      ),
    );
  }


  detailCard(int index, BankDetails bankDetails, BankDetailsProvider provider){
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
                        "Bank Details",
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
                            title: Text('Remove Bank Info',style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: GoogleFonts.poppins().fontFamily,
                              fontWeight: FontWeight.w600,
                            ),),
                            content: Text('Are you sure you want to remove this bank details?',style: TextStyle(
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
                                  ApiResponse apiResponse = await provider.deleteBankDetails(bankDetails);
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
                      bankDetails.bankName.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      bankDetails.accountNmuber.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      bankDetails.swiftCOde.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      bankDetails.accountHolderName.toString(),
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
