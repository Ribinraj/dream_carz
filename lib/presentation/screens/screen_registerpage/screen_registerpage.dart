import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    if (value.trim().length < 2) {
      return 'Full name must be at least 2 characters';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    }
    // Basic email validation
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    // Remove any spaces or special characters for validation
    final cleanNumber = value.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanNumber.length != 10) {
      return 'Please enter a valid 10-digit mobile number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      // Add your registration logic here
      print('Full Name: ${_fullNameController.text}');
      print('Email: ${_emailController.text}');
      print('Mobile: ${_mobileController.text}');
      print('Password: ${_passwordController.text}');

      // Navigate to next screen or show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration Successful!'),
          backgroundColor: Appcolors.kprimarycolor,
        ),
      );
    }
  }

  void _handleLogin() {
    // Navigate back to login screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kwhitecolor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(8)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: ResponsiveUtils.hp(1.5)),

                  // Logo Section
                  Container(
                    margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(3)),
                    child: Column(
                      children: [
                        // Logo Image
                        SizedBox(
                          height: ResponsiveUtils.hp(17),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              ResponsiveUtils.borderRadius(4),
                            ),
                            child: Image.asset(
                              Appconstants.applogo,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Appcolors.kprimarycolor,
                                    borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.borderRadius(4),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.directions_car,
                                    size: ResponsiveUtils.sp(15),
                                    color: Appcolors.kwhitecolor,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        // SizedBox(height: ResponsiveUtils.hp(.5)),
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.sp(4.5),
                            fontWeight: FontWeight.w600,
                            color: Appcolors.kblackcolor,
                          ),
                        ),

                        SizedBox(height: ResponsiveUtils.hp(0.3)),

                        Text(
                          'Join us today!',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.sp(3.2),
                            fontWeight: FontWeight.w400,
                            color: Appcolors.kblackcolor.withAlpha(153),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Form Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                    decoration: BoxDecoration(
                      color: Appcolors.kwhitecolor,
                      borderRadius: BorderRadius.circular(
                        ResponsiveUtils.borderRadius(5),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(33),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Full Name Field
                        CustomTextField(
                          hintText: 'Enter your full name',
                          labelText: 'Full Name',
                          prefixIcon: Icons.person_outline,
                          controller: _fullNameController,
                          validator: _validateFullName,
                          keyboardType: TextInputType.name,
                        ),

                        SizedBox(height: ResponsiveUtils.hp(1.5)),

                        // Email Field
                        CustomTextField(
                          hintText: 'Enter your email address',
                          labelText: 'Email Address',
                          prefixIcon: Icons.email_outlined,
                          controller: _emailController,
                          validator: _validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        SizedBox(height: ResponsiveUtils.hp(1.5)),

                        // Mobile Number Field
                        CustomTextField(
                          hintText: 'Enter your mobile number',
                          labelText: 'Mobile Number',
                          prefixIcon: Icons.phone_outlined,
                          controller: _mobileController,
                          validator: _validateMobile,
                          keyboardType: TextInputType.phone,
                        ),

                        SizedBox(height: ResponsiveUtils.hp(1.5)),

                        // Password Field
                        CustomTextField(
                          hintText: 'Enter your password',
                          labelText: 'Password',
                          prefixIcon: Icons.lock_outline,
                          controller: _passwordController,
                          validator: _validatePassword,
                          isPassword: true,
                          keyboardType: TextInputType.text,
                        ),

                        SizedBox(height: ResponsiveUtils.hp(1.5)),

                        // Confirm Password Field
                        CustomTextField(
                          hintText: 'Confirm your password',
                          labelText: 'Confirm Password',
                          prefixIcon: Icons.lock_outline,
                          controller: _confirmPasswordController,
                          validator: _validateConfirmPassword,
                          isPassword: true,
                          keyboardType: TextInputType.text,
                        ),

                        SizedBox(height: ResponsiveUtils.hp(3.5)),

                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          height: ResponsiveUtils.hp(6.5),
                          child: ElevatedButton(
                            onPressed: _handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolors.kprimarycolor,
                              foregroundColor: Appcolors.kwhitecolor,
                              elevation: 5,
                              shadowColor: Appcolors.kprimarycolor.withAlpha(
                                77,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  ResponsiveUtils.borderRadius(3),
                                ),
                              ),
                            ),
                            child: Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.sp(3.5),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: ResponsiveUtils.hp(2)),

                  // Login Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(3.5),
                          color: Appcolors.kblackcolor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: _handleLogin,
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontSize: ResponsiveUtils.sp(3.5),
                            color: Appcolors.kprimarycolor,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationColor: Appcolors.kprimarycolor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: ResponsiveUtils.hp(3)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
