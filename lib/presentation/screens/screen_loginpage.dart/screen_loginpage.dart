import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/presentation/screens/screen_homepage/screen_homepage.dart';
import 'package:dream_carz/presentation/screens/screen_registerpage/screen_registerpage.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:dream_carz/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      // Add your login logic here
      print('Username: ${_usernameController.text}');
      print('Password: ${_passwordController.text}');

      // Navigate to next screen or show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
          backgroundColor: Appcolors.kprimarycolor,
        ),
      );
    }
  }

  void _handleForgotPassword() {
    // Add forgot password logic here
    print('Forgot password tapped');

    // You can navigate to forgot password screen or show dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forgot Password'),
        content: const Text(
          'Forgot password functionality will be implemented here.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kwhitecolor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: ResponsiveUtils.screenHeight * 0.95,
            padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(8)),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo Section
                  Container(
                    margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(4)),
                    child: Column(
                      children: [
                        // Logo Image
                        SizedBox(
                          height: ResponsiveUtils.hp(25),

                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              ResponsiveUtils.borderRadius(4),
                            ),
                            child: Image.asset(
                              Appconstants
                                  .applogo, // Replace with your logo path
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

                        SizedBox(height: ResponsiveUtils.hp(2)),

                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.sp(4),
                            fontWeight: FontWeight.w500,
                            color: Appcolors.kblackcolor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Form Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
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
                        // Username Field
                        CustomTextField(
                          hintText: 'Enter your username',
                          labelText: 'Username',
                          prefixIcon: Icons.person_outline,
                          controller: _usernameController,
                          validator: _validateUsername,
                          keyboardType: TextInputType.text,
                        ),

                        SizedBox(height: ResponsiveUtils.hp(2)),

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

                        // SizedBox(height: ResponsiveUtils.hp(.5)),

                        // Forgot Password
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: _handleForgotPassword,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.sp(3.2),
                                color: Appcolors.kprimarycolor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: ResponsiveUtils.hp(3)),

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: ResponsiveUtils.hp(6.5),
                          child: ElevatedButton(
                            // onPressed: _handleLogin,
                            onPressed: () {
                              CustomNavigation.pushWithTransition(
                                context,
                                ScreenHomepage(),
                              );
                            },
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
                            child: TextStyles.body(
                              text: 'LOGIN',
                              color: Appcolors.kwhitecolor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: ResponsiveUtils.hp(4)),

                  // Register Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "New User? ",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(3.5),
                          color: Appcolors.kblackcolor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          CustomNavigation.pushWithTransition(
                            context,
                            RegisterScreen(),
                          );
                        },
                        child: Text(
                          "Register",
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

                  SizedBox(height: ResponsiveUtils.hp(2)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
