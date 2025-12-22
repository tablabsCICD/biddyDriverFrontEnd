import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PastRideDetailsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PastRideDetailsState();
  }
  
}

class PastRideDetailsState extends State<PastRideDetailsScreen>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(

     body: SafeArea(child: Container(
       color: Colors.white,
       width: MediaQuery.of(context).size.width,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.start,

         children: [
           Container(
             height: 130,
             child: Stack(
               children: [
                 Image.asset("assets/map.jpg",height: 130,  width: MediaQuery.of(context).size.width,fit: BoxFit.fitWidth,),
                 Align(alignment:Alignment.bottomLeft ,child: Padding(
                   padding: EdgeInsets.only(right: 20,left: 20,bottom: 20),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.end,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Thu, Feb 23,02:30 PM", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 18)),
                       SizedBox(height: 5,),
                       Text("Ride id:1234567890", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 14)),

                     ],
                   ),
                 )),
               ],
             ),
           ),

           toFrom(),
           SizedBox(height: 10,),
           billTitle('Bill Details'),
           billCards("Ride Fare","20"),
           billCards("Total Access Fee",'22'),
           SizedBox(height: 10,),
           divider(),
           billCards("Coupon  Saving"," 10"),
           billCards("Rounded Off",'12'),
           SizedBox(height: 10,),
           divider(),

           totalBillCards('Total Bill','70'),
           SizedBox(height: 10,),
           divider(),
           totalBillCards('Total Payable','70'),
           SizedBox(height: 20,),
           billTitle('Payment'),
           billCards("Cash",'70'),
           SizedBox(height: 10,),
           divider(),
           billHelp("Get Help",''),
           SizedBox(height: 10,),
           divider(),
           billHelp("Get invoice copy",'')




           
           
         ],
       ),
     )),
   );
    
  }

  toFrom() {
    return Padding(
      padding:  EdgeInsets.only(left:20,top: 10 ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.green,
                ),
              ),
              Text(" Bhumkar Chowk,Bhumkar Bridge ,Wakad,Pune", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16)),

            ],
          ),

          SizedBox(height: 2,),
          Padding(
            padding:  EdgeInsets.only(left:2 ),
            child: Container(
              width: 1,
              height: 40,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 2,),
          Row(
            children: [
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.red,
                ),
              ),
              Text(" Balaji Nagar,Pune Maharashtra India",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16)),

            ],
          ),
          SizedBox(height: 10,),
          Divider()
        ],
      ),
    );

  }


  billCards(String title,String cost){
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20,top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${title}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16)),
          Text("\$ ${cost}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16)),

        ],
      ),
    );
  }

  billHelp(String title,String cost){
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20,top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${title}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16)),
          //Text("\$ ${cost}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 16)),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }

  totalBillCards(String title,String cost){
    return Padding(
      padding: EdgeInsets.only(left: 20,right: 20,top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${title}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16)),
          Text("\$ ${cost}",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16)),

        ],
      ),
    );
  }

  billTitle(String title){
    return Padding(
      padding:EdgeInsets.only(left: 20,right: 20),
      child: Text(title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 18)),
    );

  }

  divider(){
    return Padding(
      padding:  EdgeInsets.only(left: 20),
      child: Divider(
        thickness: 1,
      ),
    );
  }
  
}