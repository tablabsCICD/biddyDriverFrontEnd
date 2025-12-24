

import 'package:biddy_driver/entry_screen.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/model/base_model/ride_model.dart';
import 'package:biddy_driver/screen/add_routes.dart';
import 'package:biddy_driver/screen/bank/add_bank_details.dart';
import 'package:biddy_driver/screen/bank/bank_details_screen.dart';
import 'package:biddy_driver/screen/driver/biddyridewait.dart';
import 'package:biddy_driver/screen/driver/view_vehicle.dart';
import 'package:biddy_driver/screen/driver_document/registration_copy.dart';
import 'package:biddy_driver/screen/earning/driver_earning.dart';
import 'package:biddy_driver/screen/earning/work_history.dart';
import 'package:biddy_driver/screen/history/history_screen.dart';
import 'package:biddy_driver/screen/wallet/wallet_screen.dart';
import 'package:biddy_driver/model/cabDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../model/ride_status_change_response.dart';
import '../screen/auth/otp_screen.dart';
import '../screen/auth/login.dart';
import '../screen/auth/registration.dart';
import '../screen/driver/all_cars_screen.dart';
import '../screen/driver/car_info_screen.dart';
import '../screen/driver/driver_cab_registration.dart';
import '../screen/driver/end_ride.dart';
import '../screen/driver/home_screen.dart';
import '../screen/driver/navigation_bar.dart';
import '../screen/home/booked_ride_screen.dart';

import '../screen/menu/edit_profile.dart';
import '../screen/menu/profile_sceen.dart';
import '../widgets/driver/splashed_flex.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.entryScreen:
        return buildRoute(EntryScreen(), settings: settings);
      case AppRoutes.home:
        return buildRoute(HomeScreenDriver(), settings: settings);
      case AppRoutes.login:
        return buildRoute(LoginScreen(), settings: settings);
      case AppRoutes.register:
        final arguments = settings.arguments as String;
        return buildRoute( RegistrationScreen(mobileNumber:arguments), settings: settings);
      case AppRoutes.driverCabRegistration:
      //  final arguments = settings.arguments as CabDetails;
        return buildRoute( DriverCabRegistration(), settings: settings);
      case AppRoutes.crearebiz:
       case AppRoutes.otp:
      final arguments = settings.arguments as String;
        return buildRoute( OtpScreen(mobileNumber:arguments), settings: settings);
      case AppRoutes.edit_profile:
        return buildRoute( UpdateProfileScreen(), settings: settings);

      case AppRoutes.direverCar:
        return buildRoute( VehicleDetail(), settings: settings);

      case AppRoutes.allCarDriver:
        return buildRoute( AllCarsScreen(), settings: settings);

      case AppRoutes.menu:
        return buildRoute(ProfileScreen(), settings: settings)  ;



        case AppRoutes.bookedride:
        final arguments = settings.arguments as RideData;
        return buildRoute(BookedRideScreen(booking: arguments,), settings: settings)  ;

      case AppRoutes.history:
        return buildRoute(HistoryScreen(), settings: settings)  ;

        case AppRoutes.endride:
        final arguments = settings.arguments as RideData;
        return buildRoute(EndRideScreen(rideBooking: arguments,), settings: settings)  ;


        case AppRoutes.wallet:
        return buildRoute(WalletHome(), settings: settings)  ;

      case AppRoutes.uploadRegistrationCopy:
        final arguments = settings.arguments as CabDetails;
        return buildRoute(RegistrationCopy(saveDriverDetails: arguments,), settings: settings)  ;

      case AppRoutes.uploadInsuranceCopy:
        final arguments = settings.arguments as CabDetails;
        return buildRoute(WalletHome(), settings: settings)  ;

      case AppRoutes.uploadStateInspectionCopy:
        final arguments = settings.arguments as CabDetails;
        return buildRoute(WalletHome(), settings: settings)  ;

      case AppRoutes.uploadTncCopy:
        final arguments = settings.arguments as CabDetails;
        return buildRoute(WalletHome(), settings: settings)  ;

      case AppRoutes.earning:
        return buildRoute( DriverEarning(), settings: settings);

      case AppRoutes.add_bank_details:
       // final arguments = settings.arguments as int;
        return buildRoute( AddBankDetailsScreen(), settings: settings);

      case AppRoutes.bank_details:
      // final arguments = settings.arguments as int;
        return buildRoute( BankDetailsScreen(), settings: settings);

      case AppRoutes.preffered_routes:
       // final arguments = settings.arguments as int;
        return buildRoute( AddPreferredRoute(), settings: settings);

      case AppRoutes.work_history:
        return buildRoute( WorkHIstory(), settings: settings);

        default:
        return _errorRoute();


    }
  }

  static MaterialPageRoute buildRoute(Widget child,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
        settings: settings, builder: (BuildContext context) => child);
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'ERROR!!',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 450.0,
                  width: 450.0,
                  //child: Lottie.asset('assets/lottie/error.json'),
                ),
                 Text(
                  'Seems the route you\'ve navigated to doesn\'t exist!!',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}