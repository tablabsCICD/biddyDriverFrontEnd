

import 'package:biddy_driver/constant/text_constant.dart';
import 'package:biddy_driver/model/base_model/driver_model.dart';
import 'package:biddy_driver/provider/editprofile_provider.dart';
import 'package:biddy_driver/route/app_routes.dart';
import 'package:biddy_driver/screen/menu/profile_menu_wiget.dart';
import 'package:biddy_driver/util/sharepreferences.dart';
import 'package:biddy_driver/util/textview.dart';
import 'package:biddy_driver/widgets/app_bar.dart';
import 'package:biddy_driver/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen>{


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (BuildContext context) => EditProfileProvider(context),
      builder: (context, child) => _buildPage(context),
    );
  }

  _buildPage(context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ApplicationAppBar().commonAppBar(context, "My Profile"),
      body: SafeArea(
        child: Consumer<EditProfileProvider>(
            builder: (context, provider, child) {
              return  Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: provider.userData!.data == null
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          elevation: 3,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                            child: Row(
                           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey[100],
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage('assets/profile.jpg')))),
                                SizedBox(width: 16,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextView(
                                        title: provider.userData!.data!.firstName??'Your Name' +
                                            " " +
                                            "${provider.userData!.data!.lastName??" "}",
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    TextView(
                                        title: provider.userData!.data!.emailId??'your email id',
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 12),
                                    Row(
                                      children: [
                                        Icon(Icons.call_outlined,size: 15,),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        TextView(
                                            title: provider.userData!.data!.phoneNumber??'',
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12),
                                      ],
                                    )
                                  ],
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.edit_profile,
                                          arguments: provider.userData!);
                                    },
                                    child:SvgPicture.asset("assets/edit.svg")
                                ),


                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextView(
                            title: "QUICK LINKS",
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                        const SizedBox(height: 30),
                        ProfileMenuWidget(
                            title: TextConstant.setting,
                            icon: Icons.settings,
                            onPress: () {
                              // Navigator.pushNamed(context, routeName)
                            }),
                        const SizedBox(height: 20),
                        ProfileMenuWidget(
                            title: TextConstant.add_vehicle,
                            icon: Icons.add,
                            onPress: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.direverCar);
                            }),
                        const SizedBox(height: 20),
                        ProfileMenuWidget(
                            title: TextConstant.bank_detail,
                            icon: Icons.account_balance,
                            onPress: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.bank_details);
                            }),
                        const SizedBox(height: 20),
                        ProfileMenuWidget(
                            title: TextConstant.preferred_route,
                            icon: Icons.route,
                            onPress: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.preffered_routes);
                            }),
                        const SizedBox(height: 20),
                        ProfileMenuWidget(
                            title: TextConstant.wallet,
                            icon: Icons.wallet,
                            onPress: () {
                              Navigator.pushNamed(context, AppRoutes.earning);
                            }),
                        const SizedBox(height: 20),
                        ProfileMenuWidget(
                            title: TextConstant.past_ride,
                            icon: Icons.history,
                            onPress: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.history);
                            }),
                        const SizedBox(height: 20),
                        ProfileMenuWidget(
                            title: TextConstant.termsandcondition,
                            icon: Icons.info,
                            onPress: () {}),

                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: AppButton(
                          buttonTitle: TextConstant.logout,
                          onClick: (){
                            showAlertDialog(context);
                          }, enbale: true),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),)
    );
  }


  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(TextConstant.ok),
      onPressed: () async{
        await LocalSharePreferences().logOut();
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.entryScreen, (route) => false) ;
      },
    );

    Widget cancelButton = TextButton(
      child: Text(TextConstant.cancel),
      onPressed: () {
        Navigator.pop(context);

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(TextConstant.logout),
      content: Text(TextConstant.logoutmsg),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


}