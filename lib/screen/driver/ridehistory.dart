import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PastRideDriverScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PastRideState();
  }

}

class PastRideState extends State<PastRideDriverScreen>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              header(),
              SizedBox(height: 10,),
              Divider(),
              listViewBuilder(),

            ],
          ),
        ),
      ),


    );
  }

  header() {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: Text("Ride History",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
    );
  }

  listViewBuilder(){
    var iconColor = Colors.blue;
    return Expanded(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(

              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: iconColor.withOpacity(0.1),
                    ),
                    child: Icon(Icons.account_circle_outlined,size: 40, color: iconColor),
                  ),

                  SizedBox(width: 10,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 7,),
                      Text("Thu, Feb 23,02:30 PM", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600)),
                      SizedBox(height: 10,),
                      Text("\$ 20", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,)),
                      SizedBox(height: 10,),
                      Text("Mini Cab to", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 12)),
                      Text("Silver Sports bandminton court,Wakad ,Pune", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 12)),
                      SizedBox(height: 15,),
                    ],
                  )
                ],
              ),
            );

          }),
    );
  }

}