import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/domain/apprepo.dart';
import 'package:dream_carz/domain/loginrepo.dart';
import 'package:dream_carz/presentation/blocs/fetch_cars/fetch_cars_bloc.dart';
import 'package:dream_carz/presentation/blocs/fetch_categories_bloc/fetch_categories_bloc.dart';
import 'package:dream_carz/presentation/blocs/fetch_cities_bloc/fetch_cities_bloc.dart';
import 'package:dream_carz/presentation/blocs/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:dream_carz/presentation/blocs/send_otp_bloc/send_otp_bloc.dart';
import 'package:dream_carz/presentation/blocs/verify_otp_bloc/verify_otp_bloc.dart';

import 'package:dream_carz/presentation/screens/sreen_splashpage/screen_splashpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ResponsiveUtils().init(context);
    final loginrepo = Loginrepo();
    final apprepo = Apprepo();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SendOtpBloc(repository: loginrepo)),
        BlocProvider(create: (context) => VerifyOtpBloc(repository: loginrepo)),
        BlocProvider(create: (context) => ResendOtpBloc(repository: loginrepo)),
        BlocProvider(
          create: (context) => FetchCitiesBloc(repository: apprepo),
        ),
           BlocProvider(
          create: (context) => FetchCarsBloc(repository: apprepo),
        ),
                BlocProvider(
          create: (context) => FetchCategoriesBloc(repository: apprepo),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.dark,
            ),
          ),
          fontFamily: 'Helvetica',
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: Appcolors.kbackgroundcolor,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
