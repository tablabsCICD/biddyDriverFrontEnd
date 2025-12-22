import 'package:biddy_driver/route/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'about_screen.dart';
import 'all_cars_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile-screen';
  @override
  Widget build(BuildContext context) {
    //final driverData = Provider.of<DriverProvider>(context, listen: false);
    //final driver = driverData.driver;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  print('View Profile');
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: Theme.of(context).primaryColorDark.withOpacity(0.6),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                leading: Image.asset("assets/profile.jpg"),
                title: Text(
                 "M.S Dhoni",
                  style: TextStyle(fontSize: 18,color: Colors.white),
                ),
                subtitle: Text(
                  "+91 90112023",
                  style: TextStyle(fontSize: 16,color: Colors.white),
                ),
                trailing: Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(
                  Icons.money,
                  color: Color(0xff6D5D54),
                ),
                title: Text(
                  'View Cars',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.allCarDriver);
                },
              ),
              Divider(color: Color(0xff6D5D54)),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(
                  Icons.money,
                  color: Color(0xff6D5D54),
                ),
                title: Text(
                  'Payments Methods',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  // Navigator.of(context).pushNamed(PaymentMethodsScreen.routeName);
                },
              ),
              Divider(color: Color(0xff6D5D54)),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(
                  Icons.history,
                  color: Color(0xff6D5D54),
                ),
                title: Text(
                  'History',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  // Navigator.of(context).pushNamed(HistoryScreen.routeName);
                },
              ),
              Divider(color: Color(0xff6D5D54)),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(
                  Icons.info,
                  color: Color(0xff6D5D54),
                ),
                title: Text(
                  'About',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(AboutScreen.routeName);
                },
              ),
              Divider(color: Color(0xff6D5D54)),
              Expanded(child: Container()),
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: Icon(
                  Icons.logout,
                  color: Color(0xff6D5D54),
                ),
                title: Text(
                  'Logout',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                onTap: () async {
                  // await Provider.of<Auth>(
                  //   context,
                  //   listen: false,
                  // ).logout();
                  // await Provider.of<MapsProvider>(
                  //   context,
                  //   listen: false,
                  // ).goOffline();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
