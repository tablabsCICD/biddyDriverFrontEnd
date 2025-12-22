
import 'package:biddy_driver/constant/app_constant.dart';
import 'package:biddy_driver/provider/earning_provider.dart';
import 'package:biddy_driver/util/colors.dart';
import 'package:biddy_driver/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class DriverEarning extends StatefulWidget {
  const DriverEarning({super.key});

  @override
  State<DriverEarning> createState() => _DriverEarningState();
}

class _DriverEarningState extends State<DriverEarning> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (BuildContext context) => EarningProvider("Ideal"),
      builder: (context, child) => _buildPage(context),
    );
  }

  _buildPage(context){
    return Scaffold(
      backgroundColor: ThemeColor.white,
      key: _scaffoldKey, appBar: ApplicationAppBar().commonAppBar(context, "Earning"),

      body: Consumer<EarningProvider>(
        builder: (context, model, child) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 7,
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      color: ThemeColor.theme_blue,

                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16,),
                        Center(
                          child: Text(
                            "Earning From ${model.selectedFromDate} To ${model.selectedToDate}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),
                        Center(
                          child: Text(
                            "\$ "+"${model.totalAmt}",
                            style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),
                        Divider(),
                        SizedBox(height: 0,),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "(0) Rides",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "(0) hrs",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 180,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 7,
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ThemeColor.white,

                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Wallet Balance",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                Text(
                                  "\$1555.00",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: ThemeColor.theme_blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                              child: Text("Withdrawal"),
                              onPressed: (){

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:Colors.deepPurple.shade100,
                                textStyle: const TextStyle(
                                    color: Colors.deepPurple,
                                    fontSize: 16,
                                    fontStyle: FontStyle.normal),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10))),
                              ),

                            ),
                          ],
                        ),


                        SizedBox(height: 10,),
                        Divider(),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment : MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "View Payment History",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 7,
                margin: EdgeInsets.symmetric(vertical: 10,horizontal: 16),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ThemeColor.white,

                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Withdrawal History",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          ElevatedButton(
                            child: Text("View All"),
                            onPressed: (){

                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:Colors.deepPurple.shade100,
                              textStyle: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 16,
                                  fontStyle: FontStyle.normal),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      ListView.builder(
                        itemCount: 7,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return withdrawalHistory();
                        }
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  withdrawalHistory() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(Icons.circle,color: ThemeColor.theme_blue,size: 20,),
          SizedBox(width: 10,),
          Text(
            "14/06/2021, 14:24 AM",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Spacer(),
          Text(
            "\$224",
            style: TextStyle(
              fontSize: 16,
              color: Colors.green,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }




}
