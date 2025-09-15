import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Appcolors.kgreyColor.withAlpha(200),
      leading: IconButton(
        icon: const Icon(
          Icons.format_align_left_rounded,
          color: Appcolors.kprimarycolor,
        ),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: Container(
        padding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.wp(2),
          horizontal: ResponsiveUtils.wp(3),
        ),
        decoration: BoxDecoration(
          color: Appcolors.kprimarycolor,
          borderRadius: BorderRadiusStyles.custom(sizeFactor: 5),
        ),
        child: Text(
          'Dream Carz',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5, // adjust spacing as needed
            fontSize: ResponsiveUtils.wp(
              4,
            ), // optional, set to your preferred size
            color: Colors.white, // optional, set color if needed
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // navigatePush(context, NotificationPage());
          },
          icon: const Icon(Icons.notifications, color: Appcolors.kprimarycolor),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(color: Appcolors.kprimarycolor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: ResponsiveUtils.wp(20),
                height: ResponsiveUtils.hp(10),
                // child: Image.asset(
                //   Appconstants.logo,
                //   fit: BoxFit.contain,
                // ),
              ),
              TextStyles.body(
                text: 'Bright Bike Rentals',
                weight: FontWeight.w600,
              ),
              TextStyles.caption(text: 'https://brightbikerentals.com/'),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.people_outlined),
          title: TextStyles.body(text: 'About us', weight: FontWeight.w600),
          onTap: () {},
        ),
        ListTile(
          leading: Image.asset(
            'assets/icons/tax.png',
            width: ResponsiveUtils.wp(6.5),
            height: ResponsiveUtils.hp(2.5),
          ),
          title: TextStyles.body(text: 'Our Tariff', weight: FontWeight.w600),
          onTap: () {
            //  navigatePush(context, ScreenFleetPage());
          },
        ),
        ListTile(
          leading: const Icon(Icons.add_ic_call_outlined),
          title: TextStyles.body(text: 'Contact us', weight: FontWeight.w600),
          onTap: () {
            // navigatePush(context, ScreenContactusPage());
          },
        ),
        ListTile(
          leading: const Icon(Icons.policy_outlined),
          title: TextStyles.body(
            text: 'Privacy Policy',
            weight: FontWeight.w600,
          ),
          onTap: () {
            // navigatePush(
            //     context,
            //     ScreenPrivacyPolicyPage(
            //       policy: state.policy[1],
            //     ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.policy_outlined),
          title: TextStyles.body(
            text: 'Cancellation Policy',
            weight: FontWeight.w600,
          ),
          onTap: () {
            // navigatePush(
            //     context,
            //     ScreenCancellationPolicyPage(
            //       policy: state.policy[0],
            //     ));
          },
        ),
        ListTile(
          leading: const Icon(Icons.policy_outlined),
          title: TextStyles.body(
            text: 'Refund Policy',
            weight: FontWeight.w600,
          ),
          onTap: () {
            // navigatePush(
            //     context,
            //     ScreenRefundPolicyPage(
            //       policy: state.policy[2],
            //     ));
          },
        ),
        ListTile(
          leading: Image.asset(
            'assets/icons/terms-and-conditions.png',
            width: ResponsiveUtils.wp(6),
            height: ResponsiveUtils.hp(2.5),
          ),
          title: TextStyles.body(
            text: 'Terms & Conditions',
            weight: FontWeight.w600,
          ),
          onTap: () {
            // Navigator.pop(context);
            // navigatePush(
            //     context,
            //     ScreenTermsandConditionPage(
            //       policy: state.policy[3],
            //     ));
          },
        ),
        const Divider(),
        Column(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: TextStyles.body(text: 'Logout', weight: FontWeight.w600),
              onTap: () async {
                // // Define and call the clearAllData function directly
                // SharedPreferences preferences =
                //     await SharedPreferences.getInstance();
                // await preferences
                //     .clear(); // Clears everything in SharedPreferences

                // // Navigate to the Sign-In screen and remove all previous routes
                // Navigator.of(context).pushAndRemoveUntil(
                //   MaterialPageRoute(
                //       builder: (context) =>
                //           const AdvancedSplashScreen()),
                //   (route) => false,
                // );
              },
            ),
            SizedBox(height: ResponsiveUtils.hp(7)),
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
    );
  }
}
