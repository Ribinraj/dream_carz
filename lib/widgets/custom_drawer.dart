// import 'package:dream_carz/core/appconstants.dart';
// import 'package:dream_carz/core/colors.dart';
// import 'package:dream_carz/core/constants.dart';
// import 'package:dream_carz/core/responsiveutils.dart';
// import 'package:dream_carz/presentation/screens/screen_profilepage/screen_profilpage.dart';
// import 'package:dream_carz/widgets/custom_navigation.dart';
// import 'package:flutter/material.dart';

// //
// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({super.key});

//   @override
//   State<CustomDrawer> createState() => _CustomDrawerState();
// }

// class _CustomDrawerState extends State<CustomDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       // ✅ This makes it a proper Drawer
//       backgroundColor: Appcolors.kwhitecolor, // ✅ Set background color
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           DrawerHeader(
//             decoration: const BoxDecoration(color: Appcolors.kwhitecolor),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   //width: ResponsiveUtils.wp(20),
//                   height: ResponsiveUtils.hp(16),
//                   child: Image.asset(Appconstants.applogo, fit: BoxFit.contain),
//                 ),
//               ],
//             ),
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.person_outline_outlined,
//               color: Appcolors.kprimarycolor,
//             ),
//             title: TextStyles.body(text: 'Profile', weight: FontWeight.w600),
//             onTap: () {
//               CustomNavigation.pushWithTransition(context, ScreenProfilpage());
//             },
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.privacy_tip_outlined,
//               color: Appcolors.kprimarycolor,
//             ),
//             title: TextStyles.body(
//               text: 'Privacy Policies',
//               weight: FontWeight.w600,
//             ),
//             onTap: () {},
//           ),
//           ListTile(
//             leading: const Icon(
//               Icons.phone_android,
//               color: Appcolors.kprimarycolor,
//             ),
//             title: TextStyles.body(text: 'Contact us', weight: FontWeight.w600),
//             onTap: () {},
//           ),
//           //  const Divider(),
//           Column(
//             children: [
//               // ListTile(
//               //   leading: const Icon(Icons.logout),
//               //   title: TextStyles.body(text: 'Logout', weight: FontWeight.w600),
//               //   onTap: () {},
//               // ),
//               SizedBox(height: ResponsiveUtils.hp(40)),
//               TextStyles.caption(text: 'Designed & Developed by'),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   TextStyles.caption(
//                     text: 'Crisant Technologies',
//                     weight: FontWeight.w600,
//                   ),
//                   TextStyles.caption(text: ', Mysuru'),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';

import 'package:dream_carz/presentation/screens/screen_loginpage.dart/screen_loginpage.dart';
import 'package:dream_carz/presentation/screens/screen_profilepage/screen_profilpage.dart';

import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  // Check if token exists
  Future<bool> _checkTokenExists() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('USER_TOKEN') ?? '';
    return token.isNotEmpty;
  }

// Handle profile navigation with token check
Future<void> _handleProfileNavigation() async {
  // Check if token exists FIRST (before closing drawer)
  bool hasToken = await _checkTokenExists();

  if (!hasToken) {
    // No token, close drawer and navigate to login
    Navigator.of(context).pop(); // Close drawer
    CustomNavigation.pushWithTransition(
      context,
      LoginScreen(),
    );
    return;
  }

  // Token exists, fetch profile
  context.read<FetchProfileBloc>().add(FetchProfileInitialEvent());

  // Listen to bloc state
  context
      .read<FetchProfileBloc>()
      .stream
      .firstWhere((state) {
        return state is FetchProfileSuccessState ||
            state is FetchProfileErrorState;
      })
      .then((state) {
        // Check if widget is still mounted
        if (!mounted) return;

        // Close drawer
        Navigator.of(context).pop();

        if (state is FetchProfileErrorState) {
          // Check if token expired
          if (state.message.toLowerCase().contains('expired') ||
              state.message == 'expiredtoken') {
            // Token expired, navigate to login
            CustomNavigation.pushWithTransition(
              context,
              LoginScreen(),
            );
            return;
          }
        }
        
        // All other cases (success or non-expired error), go to profile
        CustomNavigation.pushWithTransition(context, ScreenProfilpage());
      })
      .timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          if (mounted) {
            // Close drawer
            Navigator.of(context).pop();
            
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Request timeout. Please try again.'),
              ),
            );
          }
        },
      );
}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Appcolors.kwhitecolor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(color: Appcolors.kwhitecolor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
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
            onTap: _handleProfileNavigation, // Use the new handler
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
          Column(
            children: [
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
