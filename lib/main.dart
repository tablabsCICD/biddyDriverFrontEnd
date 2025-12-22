import 'package:biddy_driver/route/app_routes.dart';
import 'package:biddy_driver/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CheckUserLogin();

  }

   CheckUserLogin() {
    return MaterialApp(
      title: 'Biddy Driver',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      initialRoute: AppRoutes.entryScreen,
      onGenerateRoute: RouteGenerator.generateRoute,
    );

  }
}
