import 'package:biddy_driver/constant/text_constant.dart';
import 'package:biddy_driver/provider/editprofile_provider.dart';
import 'package:biddy_driver/route/app_routes.dart';
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
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileProvider(context),
      child: Scaffold(
        backgroundColor: const Color(0xffF7F8FA),
        appBar: ApplicationAppBar().commonAppBar(context, "My Profile"),
        body: SafeArea(
          child: Consumer<EditProfileProvider>(
            builder: (_, provider, __) {
              if (provider.userData?.data == null) {
                return const Center(child: CircularProgressIndicator());
              }

              final user = provider.userData!.data!;

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// 🔹 PROFILE HEADER
                          Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.grey.shade200,
                                    backgroundImage:
                                    const AssetImage('assets/profile.jpg'),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        TextView(
                                          title:
                                          "${user.firstName ?? ''} ${user.lastName ?? ''}",
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(height: 4),
                                        TextView(
                                          title: user.emailId ?? '',
                                          fontSize: 13,
                                          color: Colors.grey, fontWeight: FontWeight.w500,
                                        ),
                                        const SizedBox(height: 6),
                                        Row(
                                          children: [
                                            const Icon(Icons.call,
                                                size: 14,
                                                color: Colors.grey),
                                            const SizedBox(width: 6),
                                            TextView(
                                              title:
                                              user.phoneNumber ?? '',
                                              fontSize: 13,
                                              color: Colors.black87, fontWeight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: SvgPicture.asset(
                                      "assets/edit.svg",
                                      height: 20,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        AppRoutes.edit_profile,
                                        arguments: provider.userData!,
                                      );
                                    },
                                  )
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          /// 🔹 QUICK LINKS
                          const Text(
                            "QUICK LINKS",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),

                          _menuTile(
                            icon: Icons.settings,
                            title: TextConstant.setting,
                            onTap: () {},
                          ),
                          _menuTile(
                            icon: Icons.add_circle_outline,
                            title: TextConstant.add_vehicle,
                            onTap: () =>
                                Navigator.pushNamed(context, AppRoutes.direverCar),
                          ),
                          _menuTile(
                            icon: Icons.account_balance,
                            title: TextConstant.bank_detail,
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.bank_details),
                          ),
                          _menuTile(
                            icon: Icons.route,
                            title: TextConstant.preferred_route,
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.preffered_routes),
                          ),
                          _menuTile(
                            icon: Icons.wallet,
                            title: TextConstant.wallet,
                            onTap: () =>
                                Navigator.pushNamed(context, AppRoutes.earning),
                          ),
                          _menuTile(
                            icon: Icons.history,
                            title: TextConstant.past_ride,
                            onTap: () =>
                                Navigator.pushNamed(context, AppRoutes.history),
                          ),
                          _menuTile(
                            icon: Icons.info_outline,
                            title: TextConstant.termsandcondition,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// 🔹 LOGOUT BUTTON
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: AppButton(
                      buttonTitle: TextConstant.logout,
                      enbale: true,
                      onClick: () => _showLogoutDialog(context),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// 🔹 MENU TILE
  Widget _menuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.black87),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  /// 🔹 LOGOUT DIALOG
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(TextConstant.logout),
        content: Text(TextConstant.logoutmsg),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(TextConstant.cancel),
          ),
          ElevatedButton(
            onPressed: () async {
              await LocalSharePreferences().logOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.entryScreen,
                    (_) => false,
              );
            },
            child: Text(TextConstant.ok),
          ),
        ],
      ),
    );
  }
}
