import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/presentation/blocs/send_otp_bloc/send_otp_bloc.dart';
import 'package:dream_carz/presentation/screens/screen_otp_verificationpage/screen_otp_verificationpage.dart';

import 'package:dream_carz/presentation/screens/screen_registerpage/screen_registerpage.dart';
import 'package:dream_carz/widgets/custom_loadingbutton.dart';

import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:dream_carz/widgets/custom_snackbar.dart';
import 'package:dream_carz/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  String? _validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    if (value.length != 10) {
      return 'Please enter a valid 10-digit mobile number';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number should contain only digits';
    }
    return null;
  }

  void _handleSendOtp() {
    if (_formKey.currentState!.validate()) {
      // Trigger the SendOtpBloc event
      context.read<SendOtpBloc>().add(
        SendOtpButtonClickEvent(mobileNumber: _mobileController.text),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );

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
                        SizedBox(height: ResponsiveUtils.hp(2)),
                        Text(
                          'Welcome Back',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.sp(4),
                            fontWeight: FontWeight.w500,
                            color: Appcolors.kblackcolor,
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.hp(1)),
                        Text(
                          'Enter your mobile number to continue',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.sp(3.2),
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
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
                        // Mobile Number Field
                        CustomTextField(
                          hintText: 'Enter your mobile number',
                          labelText: 'Mobile Number',
                          prefixIcon: Icons.phone_outlined,
                          controller: _mobileController,
                          validator: _validateMobile,
                          keyboardType: TextInputType.phone,
                          // inputFormatters: [
                          //   FilteringTextInputFormatter.digitsOnly,
                          //   LengthLimitingTextInputFormatter(10),
                          // ],
                        ),

                        SizedBox(height: ResponsiveUtils.hp(4)),

                        // Send OTP Button with BlocConsumer
                        BlocConsumer<SendOtpBloc, SendOtpState>(
                          listener: (context, state) {
                            if (state is SendOtpSuccessState) {
                              CustomNavigation.pushReplaceWithTransition(
                                context,
                                OtpVerificationPage(
                                  customerId: state.customerId,
                                  mobileNumber: _mobileController.text,
                                ),
                              );
                            } else if (state is SendOtpErrorState) {
                              CustomSnackbar.show(
                                context,
                                message: state.message,
                                type: SnackbarType.error,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is SendOtpLoadingState) {
                              return CustomSqureLoadingButton(
                                loading:SpinKitCircle(size: 20,color: Appcolors.kwhitecolor,),
                                color: Appcolors.kredcolor,
                              );
                            }
                            return SizedBox(
                              width: double.infinity,
                              height: ResponsiveUtils.hp(6.5),
                              child: ElevatedButton(
                                onPressed: _handleSendOtp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Appcolors.kprimarycolor,
                                  foregroundColor: Appcolors.kwhitecolor,
                                  elevation: 5,
                                  shadowColor: Appcolors.kprimarycolor
                                      .withAlpha(77),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.borderRadius(3),
                                    ),
                                  ),
                                ),
                                child: TextStyles.body(
                                  text: 'SEND OTP',
                                  color: Appcolors.kwhitecolor,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: ResponsiveUtils.hp(4)),

                  // // Register Section
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "New User? ",
                  //       style: TextStyle(
                  //         fontSize: ResponsiveUtils.sp(3.5),
                  //         color: Appcolors.kblackcolor,
                  //         fontWeight: FontWeight.w400,
                  //       ),
                  //     ),
                  //     GestureDetector(
                  //       onTap: () {
                  //         CustomNavigation.pushWithTransition(
                  //           context,
                  //           RegisterScreen(),
                  //         );
                  //       },
                  //       child: Text(
                  //         "Register",
                  //         style: TextStyle(
                  //           fontSize: ResponsiveUtils.sp(3.5),
                  //           color: Appcolors.kprimarycolor,
                  //           fontWeight: FontWeight.w600,
                  //           decoration: TextDecoration.underline,
                  //           decorationColor: Appcolors.kprimarycolor,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),

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
