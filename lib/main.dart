import 'dart:io';

import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/domain/controllers/pushnotification_controller.dart';
import 'package:dream_carz/domain/repositories/apprepo.dart';
import 'package:dream_carz/domain/repositories/loginrepo.dart';
import 'package:dream_carz/presentation/blocs/coupen_bloc/coupen_bloc.dart';
import 'package:dream_carz/presentation/blocs/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:dream_carz/presentation/blocs/fetch_booking_overview_bloc/fetch_bookingoverview_bloc.dart';
import 'package:dream_carz/presentation/blocs/fetch_cars_bloc/fetch_cars_bloc.dart';
import 'package:dream_carz/presentation/blocs/fetch_categories_bloc/fetch_categories_bloc.dart';
import 'package:dream_carz/presentation/blocs/fetch_cities_bloc/fetch_cities_bloc.dart';
import 'package:dream_carz/presentation/blocs/fetch_kmplans_bloc/fetch_kmplans_bloc.dart';
import 'package:dream_carz/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:dream_carz/presentation/blocs/resend_otp_bloc/resend_otp_bloc.dart';
import 'package:dream_carz/presentation/blocs/send_otp_bloc/send_otp_bloc.dart';
import 'package:dream_carz/presentation/blocs/verify_otp_bloc/verify_otp_bloc.dart';

import 'package:dream_carz/presentation/screens/sreen_splashpage/screen_splashpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Optional: initialize firebase here if you need (only if you use Firebase in background)
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PushNotifications.backgroundMessageHandler(message);
}

// Global navigator key so we can navigate from notification handlers
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main()async {
    WidgetsFlutterBinding.ensureInitialized();
      // Initialize Firebase
  await Firebase.initializeApp(
    //options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register FCM background handler BEFORE runApp
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Initialize PushNotifications helper (this will request permissions, create channel, etc.)
  // It's okay to await this so notifications are ready by the time the app runs.
  await PushNotifications.instance.init();

  // Optional: request permissions again for iOS if you want explicit control here
  if (Platform.isIOS) {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );
  }

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
                    BlocProvider(
          create: (context) => FetchKmplansBloc(repository: apprepo),
        ),
                      BlocProvider(
          create: (context) => FetchProfileBloc(repository: loginrepo),
        ),
                      BlocProvider(
          create: (context) => EditProfileBloc(repository: loginrepo),
        ),
                           BlocProvider(
          create: (context) => FetchBookingoverviewBloc(repository:apprepo),
        ),
                          BlocProvider(
          create: (context) => CoupenBloc(repository:apprepo),
        )
        
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
