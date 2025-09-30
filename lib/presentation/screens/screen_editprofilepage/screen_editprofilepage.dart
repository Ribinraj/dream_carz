import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/data/edit_profile_model.dart';
import 'package:dream_carz/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';

import 'package:dream_carz/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:dream_carz/presentation/screens/screen_profilepage/screen_profilpage.dart';
import 'package:dream_carz/widgets/custom_loadingbutton.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:dream_carz/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

class ScreenEditprofilepage extends StatefulWidget {
  final String username;
  final String emailAdress;
  const ScreenEditprofilepage({
    super.key,
    required this.username,
    required this.emailAdress,
  });

  @override
  State<ScreenEditprofilepage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ScreenEditprofilepage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize with existing user data
    _usernameController.text = widget.username;
    _emailController.text = widget.emailAdress;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kwhitecolor,
      appBar: AppBar(
        backgroundColor: Appcolors.kwhitecolor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Appcolors.kblackcolor),
        ),
        title: TextStyles.headline(
          text: 'Edit Profile',
          color: Appcolors.kblackcolor,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(5),
            vertical: ResponsiveUtils.hp(2),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Profile Picture Section
                // _buildProfilePictureSection(),
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

                // Form Fields
                _buildFormField(
                  controller: _usernameController,
                  label: 'Username',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter username';
                    }
                    if (value.length < 3) {
                      return 'Username must be at least 3 characters';
                    }
                    return null;
                  },
                ),

                ResponsiveSizedBox.height20,

                _buildFormField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email';
                    }
                    if (!RegExp(
                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                    ).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                ResponsiveSizedBox.height20,

                ResponsiveSizedBox.height50,

                BlocConsumer<EditProfileBloc, EditProfileState>(
                  listener: (context, state) {
                    if (state is EditProfileSuccessState) {
                      CustomSnackbar.show(
                        context,
                        message: state.message,
                        type: SnackbarType.success,
                      );
                      context.read<FetchProfileBloc>().add(
                        FetchProfileInitialEvent(),
                      );
                      CustomNavigation.pop(context);
                    } else if (state is EditProfileErrorState) {
                      CustomSnackbar.show(
                        context,
                        message: state.message,
                        type: SnackbarType.error,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is EditProfileLoadingState) {
                      return CustomSqureLoadingButton(
                        loading: SpinKitCircle(
                          size: 20,
                          color: Appcolors.kwhitecolor,
                        ),
                        color: Appcolors.kredcolor,
                      );
                    }
                    return Container(
                      width: double.infinity,
                      height: ResponsiveUtils.hp(6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Appcolors.kprimarycolor,
                            Appcolors.ksecondarycolor,
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadiusStyles.kradius15(),
                        boxShadow: [
                          BoxShadow(
                            color: Appcolors.kprimarycolor.withOpacity(0.3),
                            spreadRadius: 0,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<EditProfileBloc>().add(
                                EditProfileButtonClickEvent(
                                  profile: EditProfileModel(
                                    fullName: _usernameController.text,
                                    emailAddress: _emailController.text,
                                  ),
                                ),
                              );
                            }
                          },
                          borderRadius: BorderRadiusStyles.kradius10(),
                          child: Center(
                            child: TextStyles.body(
                              text: 'Save Changes',
                              color: Appcolors.kwhitecolor,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                ResponsiveSizedBox.height30,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool? isPasswordVisible,
    VoidCallback? onTogglePassword,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadiusStyles.kradius15(),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && !(isPasswordVisible ?? false),
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(
          fontSize: ResponsiveUtils.sp(3.5),
          color: Appcolors.kblackcolor,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Colors.grey[600],
            fontSize: ResponsiveUtils.sp(3.2),
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
            child: Icon(
              icon,
              color: Appcolors.kprimarycolor,
              size: ResponsiveUtils.wp(5),
            ),
          ),
          suffixIcon: isPassword
              ? IconButton(
                  onPressed: onTogglePassword,
                  icon: Icon(
                    isPasswordVisible ?? false
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey[600],
                  ),
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(4),
            vertical: ResponsiveUtils.hp(2),
          ),
        ),
      ),
    );
  }
}
