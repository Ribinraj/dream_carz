import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/presentation/screens/screen_profilepage/screen_profilpage.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';

//
class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // ✅ This makes it a proper Drawer
      backgroundColor: Appcolors.kwhitecolor, // ✅ Set background color
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Appcolors.kwhitecolor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  //width: ResponsiveUtils.wp(20),
                  height: ResponsiveUtils.hp(16),
                  child: Image.asset(Appconstants.applogo, fit: BoxFit.contain),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.person_outline_outlined,
              color: Appcolors.kprimarycolor,
            ),
            title: TextStyles.body(text: 'Profile', weight: FontWeight.w600),
            onTap: () {
              CustomNavigation.pushWithTransition(context, ScreenProfilpage());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.privacy_tip_outlined,
              color: Appcolors.kprimarycolor,
            ),
            title: TextStyles.body(
              text: 'Privacy Policies',
              weight: FontWeight.w600,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.phone_android,
              color: Appcolors.kprimarycolor,
            ),
            title: TextStyles.body(text: 'Contact us', weight: FontWeight.w600),
            onTap: () {},
          ),
          //  const Divider(),
          Column(
            children: [
              // ListTile(
              //   leading: const Icon(Icons.logout),
              //   title: TextStyles.body(text: 'Logout', weight: FontWeight.w600),
              //   onTap: () {},
              // ),
              SizedBox(height: ResponsiveUtils.hp(40)),
              TextStyles.caption(text: 'Designed & Developed by'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextStyles.caption(
                    text: 'Crisant Technologies',
                    weight: FontWeight.w600,
                  ),
                  TextStyles.caption(text: ', Mysuru'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
