import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingsScreen extends StatelessWidget {
   RatingsScreen({Key? key}) : super(key: key);
  final int _duration = 7;
  final CountDownController _controller = CountDownController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding:  EdgeInsets.only(left: 10.0,right: 10),
            child: Column(

              children: [

                SizedBox(height: 50),
                Text("Total Rating",style:TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
                SizedBox(height: 20),
                Center(
                  child:  RatingBar.builder(
                    initialRating: 4.5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                ),
                SizedBox(height: 10,),
                coutDownWideget(),
                SizedBox(height: 10,),
               Expanded (
                  child: ListView.builder(itemBuilder:(context,index){
                   return Column(
                     children: [
                       SizedBox(height: 10,),
                       ListTile(
                          leading: Image.asset("assets/profile.jpg"),
                          title: Text("Name"),
                          subtitle: Text("The ride is goode and on time ride "),
                          trailing: RatingBar.builder(
                            initialRating: 4.5,
                            minRating: 1,
                            itemSize: 10,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          )

                        ),
                       SizedBox(height: 10,),
                       Container(height: 1, color: Colors.grey),
                     ],
                   );

                  },itemCount: 10, shrinkWrap: true,),
                )






              ],

            ),
          ),
        ),
      ),
    );
  }



  coutDownWideget(){
    return Center(
      child: CircularCountDownTimer(
        // Countdown duration in Seconds.
        duration: _duration,

        // Countdown initial elapsed Duration in Seconds.
        initialDuration: 2,

        // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
        controller: _controller,

        // Width of the Countdown Widget.
        width: 200,

        // Height of the Countdown Widget.
        height: 200,

        // Ring Color for Countdown Widget.
        ringColor: Colors.white,

        // Ring Gradient for Countdown Widget.
        ringGradient: null,

        // Filling Color for Countdown Widget.
        fillColor: Colors.amber[100]!,

        // Filling Gradient for Countdown Widget.
        fillGradient: null,

        // Background Color for Countdown Widget.
        backgroundColor: Colors.amber[500],

        // Background Gradient for Countdown Widget.
        backgroundGradient: null,

        strokeWidth: 10.0,

        // Begin and end contours with a flat edge and no extension.
        strokeCap: StrokeCap.round,

        // Text Style for Countdown Text.
        textStyle: const TextStyle(
          fontSize: 40.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),

        // Format for the Countdown Text.
        textFormat: CountdownTextFormat.S,

        // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
        isReverse: false,

        // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
        isReverseAnimation: false,

        // Handles visibility of the Countdown Text.
        isTimerTextShown: true,

        // Handles the timer start.
        autoStart: false,

        // This Callback will execute when the Countdown Starts.
        onStart: () {
          // Here, do whatever you want
          debugPrint('Countdown Started');
        },

        // This Callback will execute when the Countdown Ends.
        onComplete: () {
          // Here, do whatever you want
          //debugPrint('Countdown Ended');
          // Navigator.of(context).pop();
        },

        // This Callback will execute when the Countdown Changes.
        onChange: (String timeStamp) {
          // Here, do whatever you want
          debugPrint('Countdown Changed $timeStamp');
        },

        /*
              * Function to format the text.
              * Allows you to format the current duration to any String.
              * It also provides the default function in case you want to format specific moments
                as in reverse when reaching '0' show 'GO', and for the rest of the instances follow
                the default behavior.
            */
        timeFormatterFunction: (defaultFormatterFunction, duration) {
          if (duration.inSeconds == 0) {
            // only format for '0'
            return "4.5";
          } else {
            // other durations by it's default format
            return Function.apply(defaultFormatterFunction, [duration]);
          }
        },
      ),
    );
  }
}
