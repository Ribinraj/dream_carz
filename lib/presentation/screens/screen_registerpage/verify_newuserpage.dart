import 'dart:async';
import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/data/verify_otpmodel.dart';
import 'package:dream_carz/domain/controllers/pushnotification_controller.dart';
import 'package:dream_carz/presentation/blocs/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:dream_carz/presentation/blocs/verify_otp_bloc/verify_otp_bloc.dart';
import 'package:dream_carz/presentation/screens/screen_bookingdetailspage/screen_bookingdetailpage.dart';
import 'package:dream_carz/presentation/screens/screen_homepage/screen_homepage.dart';
import 'package:dream_carz/widgets/custom_backcirclebutton.dart';
import 'package:dream_carz/widgets/custom_loadingbutton.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:dream_carz/widgets/custom_snackbar.dart';
import 'package:dream_carz/widgets/customtextfield.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';



class VerifyNewUserPage extends StatefulWidget {
  final String customerId;
  final String loginfrom;
  final DateTime? pickupDate;
  final TimeOfDay? pickupTime;
  final DateTime? dropDate;
  final TimeOfDay? dropTime;
  final int? modelId;
  final String? cityId;
  final String? kmId;

  final String mobileNumber;

  const VerifyNewUserPage({
    super.key,
    required this.customerId,
    required this.mobileNumber,
    required this.loginfrom,
    this.pickupDate,
    this.pickupTime,
    this.dropDate,
    this.dropTime,
    this.modelId,
    this.cityId,
    this.kmId,
  });

  @override
  State<VerifyNewUserPage> createState() => _VerifyNewUserPageState();
}

class _VerifyNewUserPageState extends State<VerifyNewUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isButtonEnabled = false;
  int _resendTimer = 30;
  Timer? _timer;
  String _currentOtp = '';

  @override
  void initState() {
    super.initState();
    _startResendTimer();
  }

  @override
  void dispose() {
    // Cancel timer first
    _timer?.cancel();
    _timer = null;

    // Safe disposal of controllers
    try {
      _otpController.dispose();
      _nameController.dispose();
      _emailController.dispose();
    } catch (_) {}
    super.dispose();
  }

  void _startResendTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_resendTimer > 0) {
          _resendTimer--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _resetResendTimer() {
    if (!mounted) return;
    setState(() {
      _resendTimer = 30;
    });
    _startResendTimer();
  }

  void _resendOtp() {
    if (!mounted) return;

    // Clear OTP field safely
    if (_otpController.hasListeners) {
      _otpController.clear();
    }

    setState(() {
      _currentOtp = '';
      _isButtonEnabled = false;
    });

    // Reset and restart the timer
    _resetResendTimer();

    // Call resend OTP API
    context.read<ResendOtpBloc>().add(
      ResendOtpClickEvent(customerId: widget.customerId),
    );
  }

  // Simple validators
  String? _validateName(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'Username is required';
    if (value.length < 3) return 'Username must be at least 3 characters';
    final nameRegex = RegExp(r"^[A-Za-z][A-Za-z\s'.-]{1,}$");
    if (!nameRegex.hasMatch(value)) {
      return 'Enter a valid name';
    }
    return null;
  }

  String? _validateEmail(String? v) {
    final value = v?.trim() ?? '';
    if (value.isEmpty) return 'Email is required';
    final emailRegex = RegExp(
        r"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$");
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  void _recomputeButtonEnabled() {
    final formValid = _formKey.currentState?.validate() ?? false;
    final otpValid = _currentOtp.length == 6;
    setState(() {
      _isButtonEnabled = formValid && otpValid;
    });
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      CustomSnackbar.show(context,
          message: 'Please fix the errors above', type: SnackbarType.error);
      _recomputeButtonEnabled();
      return;
    }
    if (_currentOtp.length != 6) {
      CustomSnackbar.show(context,
          message: 'Please enter a valid 6-digit OTP',
          type: SnackbarType.error);
      _recomputeButtonEnabled();
      return;
    }

  
    context.read<VerifyOtpBloc>().add(
          VerifyOtpButtonclickEvent(
       userdetails: VerifyOtpmodel(customerId:widget.customerId, otp:_currentOtp,fullName:_nameController.text.trim(),emailAddress: _emailController.text.trim() )
          ),
        );


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ====== HEADER ======
            Container(
              padding: const EdgeInsets.all(15),
              color: Appcolors.kprimarycolor,
              height: ResponsiveUtils.hp(38),
              width: ResponsiveUtils.screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ResponsiveSizedBox.height40,
                  Row(
                    children: [
                      BackCircleButton(
                        onPressed: () => CustomNavigation.pop(context),
                      ),
                      const Spacer(),
                    ],
                  ),
                  Center(
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.all(5),
                      child: Center(
                        child: SvgPicture.asset(
                          Appconstants.splashlogo,
                          colorFilter: const ColorFilter.mode(
                            Appcolors.kwhitecolor,
                            BlendMode.srcIn,
                          ),
                          width: ResponsiveUtils.wp(30),
                          height: ResponsiveUtils.wp(30),
                          fit: BoxFit.contain,
                          placeholderBuilder: (context) => Container(
                            width: ResponsiveUtils.wp(30),
                            height: ResponsiveUtils.wp(30),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Appcolors.kprimarycolor,
                            ),
                            child: Icon(
                              Icons.drive_eta_rounded,
                              size: ResponsiveUtils.sp(18),
                              color: Appcolors.kwhitecolor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'DREAMCARZ',
                    style: GoogleFonts.ebGaramond(
                      fontSize: ResponsiveUtils.sp(7),
                      fontWeight: FontWeight.bold,
                      color: Appcolors.kwhitecolor,
                      letterSpacing: 1,
                      shadows: [
                        Shadow(
                          color: Appcolors.kprimarycolor.withAlpha(102),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ResponsiveUtils.hp(.5)),
                  Text(
                    'Feel Your Drive',
                    style: GoogleFonts.dancingScript(
                      fontSize: ResponsiveUtils.sp(4),
                      fontWeight: FontWeight.w500,
                      color: Appcolors.kwhitecolor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            // ====== BODY ======
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                onChanged: _recomputeButtonEnabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyles.headline(text: 'Complete Verification'),
                    ResponsiveSizedBox.height10,
                    TextStyles.body(
                      text:
                          'We sent a verification code to ${widget.mobileNumber}',
                      weight: FontWeight.w500,
                    ),
                    ResponsiveSizedBox.height20,

                    // Username
                    CustomTextField(
                      hintText: 'Enter your name',
                      labelText: 'Username',
                      prefixIcon: Icons.person,
                      controller: _nameController,
                      validator: _validateName,
                      keyboardType: TextInputType.name,
                    ),

                    // Email
                    CustomTextField(
                      hintText: 'Enter your email address',
                      labelText: 'Email Address',
                      prefixIcon: Icons.email_rounded,
                      controller: _emailController,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    ResponsiveSizedBox.height10,

                    // OTP
                    PinCodeTextField(
                      appContext: context,
                      length: 6,
                      controller: _otpController,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        inactiveBorderWidth: .5,
                        activeBorderWidth: .7,
                        selectedBorderWidth: .9,
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(8),
                        fieldHeight: 50,
                        fieldWidth: 48,
                        activeFillColor: Colors.white,
                        inactiveFillColor: Colors.grey.shade100,
                        selectedFillColor: Colors.white,
                        activeColor: Appcolors.kprimarycolor,
                        inactiveColor: Appcolors.ksecondarycolor,
                        selectedColor: Appcolors.kgreencolor,
                      ),
                      cursorColor: Colors.black,
                      cursorWidth: 1,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onCompleted: (value) {
                        if (!mounted) return;
                        setState(() {
                          _currentOtp = value;
                        });
                        _recomputeButtonEnabled();
                      },
                      onChanged: (value) {
                        if (!mounted) return;
                        setState(() {
                          _currentOtp = value;
                        });
                        _recomputeButtonEnabled();
                      },
                    ),

                    const SizedBox(height: 40),

                    // Submit
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
                        listener: (context, state) {
                          if (state is VerifyOtpSuccessState) {
                            // Navigate same as your original page
                            if (widget.loginfrom == "homepage") {
                              CustomNavigation.pushReplaceWithTransition(
                                context,
                                const ScreenHomepage(),
                              );
                            } else {
                              CustomNavigation.pushReplaceWithTransition(
                                context,
                                ScreenBookingdetailpage(
                                  pickupDate: widget.pickupDate,
                                  pickupTime: widget.pickupTime,
                                  dropDate: widget.dropDate,
                                  dropTime: widget.dropTime,
                                  modelId: widget.modelId,
                                  cityId: widget.cityId,
                                  kmId: widget.kmId,
                                ),
                              );
                            }
                            PushNotifications().sendTokenToServer();
                          } else if (state is VerifyOtpErrorState) {
                            CustomSnackbar.show(context,
                                message: state.message,
                                type: SnackbarType.error);
                          }
                        },
                        builder: (context, state) {
                          if (state is VerifyOtpLoadingState) {
                            return CustomSqureLoadingButton(
                              loading: const SpinKitCircle(
                                size: 20,
                                color: Appcolors.kwhitecolor,
                              ),
                              color: Appcolors.kredcolor,
                            );
                          }
                          return ElevatedButton(
                            onPressed:
                                _isButtonEnabled ? _submit : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Appcolors.kredcolor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Verify & Continue',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Resend OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Didn't receive OTP? ",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        BlocConsumer<ResendOtpBloc, ResendOtpState>(
                          listener: (context, state) {
                            if (state is ResendOtpSuccessState) {
                              CustomSnackbar.show(
                                context,
                                message: 'OTP sent successfully',
                                type: SnackbarType.success,
                              );
                            } else if (state is ResendOtpErrorState) {
                              CustomSnackbar.show(
                                context,
                                message: state.message,
                                type: SnackbarType.error,
                              );
                            }
                          },
                          builder: (context, state) {
                            return TextButton(
                              onPressed:
                                  _resendTimer == 0 ? _resendOtp : null,
                              child: TextStyles.body(
                                text: _resendTimer > 0
                                    ? 'Resend in $_resendTimer seconds'
                                    : 'Resend',
                                weight: FontWeight.w600,
                                color: _resendTimer > 0
                                    ? Colors.grey.shade500
                                    : Appcolors.kredcolor,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
