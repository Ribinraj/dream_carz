import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:dream_carz/presentation/screens/privacy_policy_terms/refund_cancellationpage.dart';
import 'package:dream_carz/presentation/screens/privacy_policy_terms/screen_privacypolicypage.dart';
import 'package:dream_carz/presentation/screens/privacy_policy_terms/terms_and_condition.dart';
import 'package:dream_carz/presentation/screens/screen_contactuspage/sreen_contactuspage.dart';

import 'package:dream_carz/presentation/screens/screen_loginpage.dart/screen_loginpage.dart';
import 'package:dream_carz/presentation/screens/screen_profilepage/screen_profilpage.dart';

import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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
        LoginScreen(loginfrom: "homepage"),
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
                state.message == "Expired token") {
              // Token expired, navigate to login
              CustomNavigation.pushWithTransition(
                context,
                LoginScreen(loginfrom: "homepage"),
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
            decoration: const BoxDecoration(color: Appcolors.kblackcolor),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: ResponsiveUtils.hp(15),
                  child: Image.asset(Appconstants.applogo, fit: BoxFit.contain),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ),

          // Menu items
          _buildMenuTile(
            icon: Icons.person,
            title: 'Profile',
            onTap: () {
              _handleProfileNavigation();
            },
          ),
          const Divider(height: 1),

          _buildMenuTile(
            icon: Icons.shopping_bag_outlined,
            title: 'Privacy Policy',
            onTap: () {
              CustomNavigation.pushWithTransition(context, PrivacyPolicyPage());
              //_launchURL('https://dreamcarz.live/privacy');
            },
          ),

          const Divider(height: 1),
          _buildMenuTile(
            icon: Icons.question_answer_outlined,
            title: 'Terms & Conditions',
            onTap: () {
              {
                CustomNavigation.pushWithTransition(context, TermsAndConditionsPage());
                // _launchURL('https://dreamcarz.live/terms');
              }
            },
          ),
                    const Divider(height: 1),

          _buildMenuTile(
            icon: Icons.shopping_bag_outlined,
            title: 'Refund & Cancellation',
            onTap: () {
              CustomNavigation.pushWithTransition(context,RefundCancellationPage());
              //_launchURL('https://dreamcarz.live/privacy');
            },
          ),
          const Divider(height: 1),

          // // App section title
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       'App',
          //       style: TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.w500,
          //         color: Colors.grey.shade700,
          //       ),
          //     ),
          //   ),
          // ),

          // _buildMenuTile(
          //   icon: Icons.question_answer_outlined,
          //   title: 'FAQs',
          //   onTap: () {},
          // ),
          // const Divider(height: 1),
          _buildMenuTile(
            icon: Icons.mail_outline,
            title: 'Contact Us',
            onTap: () {
              CustomNavigation.pushWithTransition(context, ContactUsPage());
            },
          ),

          const Divider(),
          Column(
            children: [
              SizedBox(height: ResponsiveUtils.hp(5)),
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

  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar('Could not launch $url');
      }
    } catch (e) {
      _showErrorSnackBar('Error launching URL: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Widget _buildMenuTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconcolor = Appcolors.kprimarycolor,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(icon, size: 20, color: iconcolor),
            const SizedBox(width: 16),
            TextStyles.body(text: title),
            const Spacer(),
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
