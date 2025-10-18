import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:dream_carz/presentation/screens/screen_editprofilepage/screen_editprofilepage.dart';
import 'package:dream_carz/presentation/screens/screen_mybookingspage/screen_mybookingpage.dart';
import 'package:dream_carz/presentation/screens/screen_mydocuments/screen_mydocuments.dart';
import 'package:dream_carz/presentation/screens/screen_searchresultscreen.dart/widgets/customloading.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:dream_carz/widgets/logout_utils.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ScreenProfilpage extends StatelessWidget {
  const ScreenProfilpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            size: ResponsiveUtils.wp(8),
            color: Colors.black,
          ),
        ),
        title: TextStyles.subheadline(
          text: 'Profile',
          color: const Color(0xFF1A365D),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.wp(4),
          vertical: ResponsiveUtils.hp(2),
        ),
        child: Column(
          children: [
            // Profile Header Section
            BlocBuilder<FetchProfileBloc, FetchProfileState>(
              builder: (context, state) {
                if (state is FetchProfileLoadingState) {
                  return Container(
                    padding: EdgeInsets.all(ResponsiveUtils.wp(10)),
                    child: Center(
                      child: RotatingSteeringWheel(
                        size: ResponsiveUtils.wp(20), // Adjust size as needed
                        steeringWheelAssetPath:
                            Appconstants.splashlogo, // Your SVG path
                      ),
                    ),
                  );
                }
                if (state is FetchProfileSuccessState) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
                    decoration: BoxDecoration(
                      color: Appcolors.kwhitecolor,
                      borderRadius: BorderRadiusStyles.kradius15(),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Profile Picture
                        Center(
                          child: SvgPicture.asset(
                            Appconstants.profileIcon,
                            width: ResponsiveUtils.wp(23),
                            height: ResponsiveUtils.wp(23),
                            // colorFilter: ColorFilter.mode(
                            //   Appcolors.kprimarycolor,
                            //   BlendMode.srcIn,
                            // ),
                          ),
                        ),
                        ResponsiveSizedBox.height30,

                        // User Info
                        _buildInfoRow(
                          icon: Icons.person_outline,
                          label: 'Username',
                          value: state.profile.fullName,
                        ),
                        ResponsiveSizedBox.height15,

                        _buildInfoRow(
                          icon: Icons.email_outlined,
                          label: 'Email',
                          value: state.profile.emailAddress,
                        ),
                        ResponsiveSizedBox.height15,

                        _buildInfoRow(
                          icon: Icons.phone_outlined,
                          label: 'Mobile Number',
                          value: state.profile.mobileNumber,
                        ),
                        ResponsiveSizedBox.height20,

                        // Edit Profile Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              CustomNavigation.pushWithTransition(
                                context,
                                ScreenEditprofilepage(
                                  username: state.profile.fullName,
                                  emailAdress: state.profile.emailAddress,
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              size: ResponsiveUtils.sp(4),
                              color: Appcolors.kwhitecolor,
                            ),
                            label: TextStyles.body(
                              text: 'Edit Profile',
                              color: Appcolors.kwhitecolor,
                              weight: FontWeight.w600,
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolors.kprimarycolor,
                              padding: EdgeInsets.symmetric(
                                vertical: ResponsiveUtils.hp(1.5),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusStyles.kradius10(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (state is FetchProfileErrorState) {
                  return Center(child: Text(state.message));
                } else {
                  return SizedBox.shrink();
                }
              },
            ),

            ResponsiveSizedBox.height30,

            // Menu Options Section
            Container(
              decoration: BoxDecoration(
                color: Appcolors.kwhitecolor,
                borderRadius: BorderRadiusStyles.kradius15(),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildMenuOption(
                    context: context,
                    icon: Icons.bookmark_outline,
                    title: 'My Bookings',
                    subtitle: 'View your booking history',
                    onTap: () {
                      CustomNavigation.pushWithTransition(
                        context,
                        ScreenMybookingpage(),
                      );
                    },
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  // _buildMenuOption(
                  //   context: context,
                  //   icon: Icons.folder_outlined,
                  //   title: 'Documents',
                  //   subtitle: 'Manage your documents',
                  //   onTap: () {
                  //     CustomNavigation.pushWithTransition(
                  //       context,
                  //       MyDocumentsPage(bookingId: "77",),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),

            ResponsiveSizedBox.height30,

            // Logout Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Appcolors.kwhitecolor,
                borderRadius: BorderRadiusStyles.kradius15(),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                onTap: () {
                  _showLogoutDialog(context);
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(6),
                  vertical: ResponsiveUtils.hp(1),
                ),
                leading: Container(
                  padding: EdgeInsets.all(ResponsiveUtils.wp(2.5)),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadiusStyles.kradius10(),
                  ),
                  child: Icon(
                    Icons.logout,
                    color: Colors.red[600],
                    size: ResponsiveUtils.sp(5),
                  ),
                ),
                title: TextStyles.body(
                  text: 'Logout',
                  weight: FontWeight.w600,
                  color: Colors.red[600],
                ),
                subtitle: TextStyles.caption(
                  text: 'Sign out of your account',
                  color: Colors.red[400],
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  color: Colors.red[400],
                  size: ResponsiveUtils.sp(5),
                ),
              ),
            ),

            ResponsiveSizedBox.height20,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
          decoration: BoxDecoration(
            color: Appcolors.kprimarycolor.withOpacity(0.1),
            borderRadius: BorderRadiusStyles.kradius10(),
          ),
          child: Icon(
            icon,
            color: Appcolors.kprimarycolor,
            size: ResponsiveUtils.sp(4),
          ),
        ),
        ResponsiveSizedBox.width10,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyles.caption(text: label, color: Colors.grey[600]),
              ResponsiveSizedBox.height5,
              TextStyles.body(
                text: value,
                weight: FontWeight.w500,
                color: Appcolors.kblackcolor,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.wp(6),
        vertical: ResponsiveUtils.hp(0.5),
      ),
      leading: Container(
        padding: EdgeInsets.all(ResponsiveUtils.wp(2.5)),
        decoration: BoxDecoration(
          color: Appcolors.kprimarycolor.withOpacity(0.1),
          borderRadius: BorderRadiusStyles.kradius10(),
        ),
        child: Icon(
          icon,
          color: Appcolors.kprimarycolor,
          size: ResponsiveUtils.sp(5),
        ),
      ),
      title: TextStyles.body(
        text: title,
        weight: FontWeight.w600,
        color: Appcolors.kblackcolor,
      ),
      subtitle: TextStyles.caption(text: subtitle, color: Colors.grey[600]),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[400],
        size: ResponsiveUtils.sp(5),
      ),
    );
  }

void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusStyles.kradius15(),
        ),
        title: TextStyles.subheadline(
          text: 'Logout',
          color: Appcolors.kblackcolor,
        ),
        content: TextStyles.body(
          text: 'Are you sure you want to logout?',
          color: Colors.grey[700],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: TextStyles.body(
              text: 'Cancel',
              color: Colors.grey[600],
              weight: FontWeight.w600,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext); // Close dialog
              AuthUtils.handleLogout(context); // Use parent context
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[600],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusStyles.kradius10(),
              ),
            ),
            child: TextStyles.body(
              text: 'Logout',
              color: Appcolors.kwhitecolor,
              weight: FontWeight.w600,
            ),
          ),
        ],
      );
    },
  );
}
}
