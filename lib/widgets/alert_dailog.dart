import 'package:flutter/material.dart';

import '../provider/book_ride_provider.dart';
import '../route/app_routes.dart';

class MyAlertDialog extends StatelessWidget {
  TextEditingController _fareController = TextEditingController();
  final int userId;
  final String price;
  final String pickupLat ;
  final String pickupLong ;
  final String dropLat ;
  final String dropLong ;
  final int categoryId ;
  final String maxDistance;
  final String pickupLocation;
  final String dropLocation;
  MyAlertDialog(
      {
    required this.userId,
    required this.price,
    required this.pickupLat,
    required this.pickupLong,
    required this.dropLat,
    required this.dropLong,
    required this.categoryId,
    required this.maxDistance,
    required this.pickupLocation,
    required this.dropLocation
  }){

    _fareController.text= price;
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Book a ride'),
      content:userId==null?Center(
        child: CircularProgressIndicator(),

      ): Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Below is the autocalculated price. you can change it and click on SAVE button to book a ride .'),
          TextField(
            controller: _fareController,
            decoration: InputDecoration(
              labelText: 'price(fare)',
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            // Perform the desired action when "Cancel" button is pressed
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () async{
            BookRideProvider bookRideProvider = BookRideProvider("ideal");
            var bookride= await bookRideProvider.BookCabRide(pickupLat,pickupLong,dropLat,dropLong,maxDistance,_fareController.text, userId,categoryId,pickupLocation,dropLocation);
            if(bookride.status==200){
              print("Booked Ride SUCCESS");
              SnackBar snackBar= SnackBar(content:
              Text("Unable to save your ride! Please try again."),
                duration: Duration(seconds: 3),);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              // Perform the desired action when "OK" button is pressed
              String userInput = _fareController.text;
             // Navigator.pushReplacementNamed(context, AppRoutes.home);

            }else{
              print("API Book Ride FAILED${bookride.response}");
              SnackBar snackBar= SnackBar(content:
              Text("Unable to save your ride! Please try again."),
                duration: Duration(seconds: 3),);
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

          },
        ),
      ],
    );
  }

}
