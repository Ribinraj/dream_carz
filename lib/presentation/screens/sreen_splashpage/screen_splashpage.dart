import 'dart:math';
import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/presentation/screens/screen_loginpage.dart/screen_loginpage.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;

  late Animation<double> _rotationAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize rotation controller BEFORE using it
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Add status listener AFTER controller initialization
    _rotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rotationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _rotationController.forward();
      }
    });

    // Now create the rotation animation that uses the controller
    _rotationAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.easeInOut),
    );

    // Fade controller for text appearance
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Scale controller for logo entrance
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    // Start animations sequence
    _startAnimations();
  }

  void _startAnimations() async {
    // Start logo scale animation
    _scaleController.forward();

    // Wait a bit then start rotation (use forward because listener handles reverse)
    await Future.delayed(const Duration(milliseconds: 500));
    _rotationController.forward();

    // Start text fade in
    await Future.delayed(const Duration(milliseconds: 800));
    _fadeController.forward();

    // Navigate to next screen after total duration
    await Future.delayed(const Duration(milliseconds: 4000));
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    CustomNavigation.pushWithTransition(context, LoginScreen());
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
            SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // White icons
        statusBarBrightness: Brightness.dark, // iOS
      ),
    );
    return Scaffold(
      backgroundColor: Appcolors.kprimarycolor,
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: Listenable.merge([
                _scaleAnimation,
                _rotationAnimation,
              ]),
              builder: (context, child) {
                return Transform.scale(
                  scale: _scaleAnimation.value, 
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Container(
                      width: ResponsiveUtils.wp(35),
                      height: ResponsiveUtils.wp(35),
                      decoration: BoxDecoration(shape: BoxShape.circle),
                      child: SvgPicture.asset(
                        Appconstants.splashlogo,
                        colorFilter: const ColorFilter.mode(
                          Appcolors.kwhitecolor,
                          BlendMode.srcIn,
                        ),
                        width: ResponsiveUtils.wp(35),
                        height: ResponsiveUtils.wp(35),
                        fit: BoxFit.contain,
                        placeholderBuilder: (context) => Container(
                          width: ResponsiveUtils.wp(35),
                          height: ResponsiveUtils.wp(35),
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
                );
              },
            ),

            SizedBox(height: ResponsiveUtils.hp(3)),

            AnimatedBuilder(
              animation: _fadeAnimation,
              builder: (context, child) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        'DREAMCARZ',
                        style: GoogleFonts.ebGaramond(
                          fontSize: ResponsiveUtils.sp(8),
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
                          fontSize: ResponsiveUtils.sp(4.5),
                          fontWeight: FontWeight.w500,
                          color: Appcolors.kwhitecolor,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
