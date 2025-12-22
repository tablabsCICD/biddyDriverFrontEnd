import 'package:biddy_driver/constant/text_constant.dart';
import 'package:biddy_driver/widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WalletHome extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
   return WalletState();
  }

}

class WalletState extends State<WalletHome>{
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text(TextConstant.wallet),),
      body: SafeArea(

        child: Column(

          children: [
            SizedBox(
              height: 50,
            ),
            Center(child: Text("\$ 10000",style: TextStyle(fontSize: 30,color: Colors.grey,fontWeight: FontWeight.w800),)),
            SizedBox(
              height: 30,
            ),
            AppButtonCircular(buttonTitle: TextConstant.add_money, onClick: (){

            }, enbale: true),
            SizedBox(height: 20,),

            Expanded(

              //decoration: BoxDecoration(color: Colors.grey[100],borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
              child:Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),

                  child: ListView.builder(

                      itemCount: 10,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            transcation(index),
                            SizedBox(

                              height: 15,
                            )
                          ],
                        );

                      },),
                ),
              )),


          ],


        ),
      ),
    );

  }

  transcation(int index){
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
          bottom: Radius.circular(20),

        ),
      ),


      child: ListTile(
        title: Text("This is tittle"),
        subtitle: Text("Subtitle"),
        leading: Icon(index %2==0?Icons.arrow_downward:Icons.arrow_upward,size: 30,color: index %2==0?Colors.green:Colors.red,),
        trailing: Text("\$ 50"),

      )


    );

  }




}