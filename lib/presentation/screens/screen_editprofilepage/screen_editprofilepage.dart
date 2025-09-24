import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ScreenEditprofilepage extends StatefulWidget {
  const ScreenEditprofilepage({super.key});

  @override
  State<ScreenEditprofilepage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<ScreenEditprofilepage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Initialize with existing user data
    _usernameController.text = "JohnDoe";
    _emailController.text = "john.doe@email.com";
    _phoneController.text = "+1 234 567 8900";
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

                _buildFormField(
                  controller: _phoneController,
                  label: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),

                ResponsiveSizedBox.height20,

                _buildFormField(
                  controller: _passwordController,
                  label: 'New Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  isPasswordVisible: _isPasswordVisible,
                  onTogglePassword: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  validator: (value) {
                    if (value != null && value.isNotEmpty && value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                ResponsiveSizedBox.height20,

                _buildFormField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  icon: Icons.lock_outline,
                  isPassword: true,
                  isPasswordVisible: _isConfirmPasswordVisible,
                  onTogglePassword: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                  validator: (value) {
                    if (_passwordController.text.isNotEmpty) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                    }
                    return null;
                  },
                ),

                ResponsiveSizedBox.height50,

                // Save Button
                _buildSaveButton(),

                ResponsiveSizedBox.height30,
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildProfilePictureSection() {
  //   return Column(
  //     children: [
  //       Stack(
  //         children: [
  //           CircleAvatar(
  //             radius: ResponsiveUtils.wp(12),
  //             backgroundColor: Appcolors.kprimarycolor.withOpacity(0.1),
  //             backgroundImage: const NetworkImage(
  //               'https://via.placeholder.com/150/CCCCCC/FFFFFF?text=Profile',
  //             ),
  //           ),
  //           Positioned(
  //             bottom: 0,
  //             right: 0,
  //             child: GestureDetector(
  //               onTap: () {
  //                 // Handle profile picture change
  //                 _showImagePickerDialog();
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
  //                 decoration: BoxDecoration(
  //                   color: Appcolors.kprimarycolor,
  //                   borderRadius: BorderRadiusStyles.kradius30(),
  //                   border: Border.all(color: Appcolors.kwhitecolor, width: 2),
  //                 ),
  //                 child: Icon(
  //                   Icons.camera_alt,
  //                   color: Appcolors.kwhitecolor,
  //                   size: ResponsiveUtils.wp(4),
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //       ResponsiveSizedBox.height15,
  //       TextStyles.subheadline(
  //         text: 'Change Profile Picture',
  //         color: Appcolors.kprimarycolor,
  //       ),
  //     ],
  //   );
  // }

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

  Widget _buildSaveButton() {
    return Container(
      width: double.infinity,
      height: ResponsiveUtils.hp(6),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Appcolors.kprimarycolor, Appcolors.ksecondarycolor],
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
          onTap: _saveProfile,
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
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextStyles.body(
            text: 'Profile updated successfully!',
            color: Appcolors.kwhitecolor,
          ),
          backgroundColor: Appcolors.kprimarycolor,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyles.kradius5(),
          ),
        ),
      );

      // Navigate back or perform save operation
      Navigator.pop(context);
    }
  }

  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyles.kradius20(),
          ),
          title: TextStyles.subheadline(
            text: 'Select Profile Picture',
            color: Appcolors.kblackcolor,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: Appcolors.kprimarycolor,
                ),
                title: TextStyles.body(text: 'Camera'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle camera selection
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Appcolors.kprimarycolor,
                ),
                title: TextStyles.body(text: 'Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  // Handle gallery selection
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
