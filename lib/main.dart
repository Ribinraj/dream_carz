import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/responsiveutils.dart';

import 'package:dream_carz/presentation/screens/sreen_splashpage/screen_splashpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveUtils().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
               theme: ThemeData(
                  appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark, 
          ),
        ),
            fontFamily: 'Helvetica',
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            scaffoldBackgroundColor: Appcolors.kbackgroundcolor,
          ),
      home: SplashScreen(),
    );
  }
}
