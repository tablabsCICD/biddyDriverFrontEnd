import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';

class EarningsScreen extends StatelessWidget {
   EarningsScreen({Key? key}) : super(key: key);
  static const routeName = '/earnings-screen';

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
                Text("Total Earning",style:TextStyle(fontSize: 18,fontWeight: FontWeight.w900)),
                SizedBox(height: 20),
               Center(
                 child:  coutDownWideget(),
               ),
                Spacer(),

                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: Icon(
                    Icons.money,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'Details of eraning ',
                    style: TextStyle(fontSize: 14,color: Colors.blue),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(AppRoutes.allCarDriver);
                  },
                ),
                Divider(color: Colors.blue),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: Icon(
                    Icons.paid_sharp,
                   color: Colors.blue,
                  ),
                  title: Text(
                    'Transfer Ammount to Bank ',
                    style: TextStyle(fontSize: 14,color: Colors.blue),
                  ),
                  onTap: () {
                   // Navigator.of(context).pushNamed(AppRoutes.allCarDriver);
                  },
                ),
                Divider(color: Colors.blue),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: Icon(
                    Icons.add_circle,
                      color: Colors.blue
                  ),
                  title: Text(
                    'Add Bank Details',
                    style: TextStyle(fontSize: 14,color: Colors.blue),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(PaymentMethodsScreen.routeName);
                  },
                ),
                Divider(color: Colors.blue),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: Icon(
                    Icons.history,
                      color: Colors.blue
                  ),
                  title: Text(
                    'Transaction History',
                    style: TextStyle(fontSize: 14,color: Colors.blue),
                  ),
                  onTap: () {
                    // Navigator.of(context).pushNamed(HistoryScreen.routeName);
                  },
                ),
                Divider(color: Colors.blue),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: Icon(
                    Icons.info,
                      color: Colors.blue
                  ),
                  title: Text(
                    'Customer Care',
                    style: TextStyle(fontSize: 14,color: Colors.blue),
                  ),
                  onTap: () {
                    //Navigator.of(context).pushNamed(AboutScreen.routeName);
                  },
                ),



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
        initialDuration: 0,

        // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
        controller: _controller,

        // Width of the Countdown Widget.
        width: 200,

        // Height of the Countdown Widget.
        height: 200,

        // Ring Color for Countdown Widget.
        ringColor: Colors.blue[500]!,

        // Ring Gradient for Countdown Widget.
        ringGradient: null,

        // Filling Color for Countdown Widget.
        fillColor: Colors.blue[100]!,

        // Filling Gradient for Countdown Widget.
        fillGradient: null,

        // Background Color for Countdown Widget.
        backgroundColor: Colors.blue[500],

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
            return "\$300";
          } else {
            // other durations by it's default format
            return Function.apply(defaultFormatterFunction, [duration]);
          }
        },
      ),
    );
  }
}
