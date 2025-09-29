// import 'dart:convert';
// import 'dart:developer';

// import 'package:dream_carz/domain/repositories/loginrepo.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:shared_preferences/shared_preferences.dart';

// class PushNotifications {
//   // Singleton instance
//   static final PushNotifications _instance = PushNotifications._internal();
//    static PushNotifications get instance => _instance;
//   factory PushNotifications() => _instance;
//   PushNotifications._internal();

//   // Firebase Messaging and Local Notifications instances
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   // Notification channel details
//   static const AndroidNotificationChannel _androidNotificationChannel =
//       AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title
//     description: 'This channel is used for important notifications.',
//     importance: Importance.high,
//   );

//   // Initialize push notifications
//   Future<void> init() async {
//     try {
//       // Request notification permissions
//       NotificationSettings settings = await _requestPermissions();

//       // Configure notification settings based on permission status
//       if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//         // Get device token
//         await _getDeviceToken();

//         // Initialize local notifications
//         await _initLocalNotifications();

//         // Listen to various notification states
//         _setupNotificationListeners();
//       }
//     } catch (e) {
//       debugPrint('Error initializing push notifications: $e');
//     }
//   }

//   // Request notification permissions
//   Future<NotificationSettings> _requestPermissions() async {
//     return await _firebaseMessaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//       provisional: false,
//       criticalAlert: true,
//       announcement: false,
//       carPlay: false,
//     );
//   }

//   // Get and handle device token
// Future<String?> _getDeviceToken() async {
//   try {
//     // Get current token
//     final token = await _firebaseMessaging.getToken();
//     debugPrint('Device Token: $token');

//     // Store token locally regardless of login status
//     if (token != null) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('FCM_TOKEN', token);
//     }

//     // Listen for token refreshes
//     _firebaseMessaging.onTokenRefresh.listen((newToken) {
//       debugPrint('Token Refreshed: $newToken');
//       _storeTokenLocally(newToken);
//       // If user is logged in, update token on server
//       _updateTokenIfLoggedIn(newToken);
//     });

//     return token;
//   } catch (e) {
//     debugPrint('Error getting device token: $e');
//     return null;
//   }
// }
// Future<void> _storeTokenLocally(String token) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   await prefs.setString('FCM_TOKEN', token);
// }

// Future<void> _updateTokenIfLoggedIn(String token) async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool isLoggedIn = prefs.containsKey('USER_TOKEN') &&
//                     prefs.getString('USER_TOKEN')?.isNotEmpty == true;

//   if (isLoggedIn) {
//     // Use your LoginRepo to update the token
//     final loginRepo = Loginrepo();
//     await loginRepo.updatetoken(token: token);
//   }
// }

// // Add a public method to send token after login
// Future<void> sendTokenToServer() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String? token = prefs.getString('FCM_TOKEN');
// log('sendservertoken:$token');
//   if (token != null) {
//     final loginRepo = Loginrepo();
//   await loginRepo.updatetoken(token: token);
//   }
// }

// Future<void> deleteDeviceToken() async {
//   try {
//     // iOS-specific: Check for APNs token availability before attempting to delete
//     if (defaultTargetPlatform == TargetPlatform.iOS) {
//       final apnsToken = await _firebaseMessaging.getAPNSToken();
//       if (apnsToken == null) {
//         debugPrint('APNs token not yet available; skipping deleteToken.');
//       } else {
//         await _firebaseMessaging.deleteToken();
//         debugPrint('iOS: FCM token deleted successfully.');
//       }
//     } else {
//       // Android doesn't need APNs token check
//       await _firebaseMessaging.deleteToken();
//       debugPrint('Android: FCM token deleted successfully.');
//     }

//     // Cancel all pending local notifications
//     await _flutterLocalNotificationsPlugin.cancelAll();

//     // Android: Remove notification channel
//     final androidImplementation = _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>();
//     if (androidImplementation != null) {
//       await androidImplementation.deleteNotificationChannel(
//         _androidNotificationChannel.id,
//       );
//     }

//   } catch (e) {
//     debugPrint('Error deleting device token: $e');
//     // Don't rethrow — avoid crashing logout flow due to this non-critical error
//   }
// }

//   // Initialize local notifications
//   Future<void> _initLocalNotifications() async {
//     // Android initialization
//     final AndroidInitializationSettings androidInitializationSettings =
//         AndroidInitializationSettings('@mipmap/ic_launcher');

//     // iOS initialization
//     final DarwinInitializationSettings darwinInitializationSettings =
//         DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//     );

//     // Initialize settings
//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: androidInitializationSettings,
//       iOS: darwinInitializationSettings,
//     );

//     // Create notification channel for Android
//     await _flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(_androidNotificationChannel);

//     // Initialize the plugin
//     await _flutterLocalNotificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: _onNotificationTap,
//     );
//   }

//   // Setup notification listeners
//   void _setupNotificationListeners() {
//     // Handle foreground messages
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       debugPrint('Received foreground message');
//       _handleForegroundMessage(message);
//     });

//     // Handle background/terminated state message taps
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       debugPrint('Message opened app');
//       _handleTerminatedStateNotification(message);
//     });
//   }

//   // Handle foreground messages
//   void _handleForegroundMessage(RemoteMessage message) {
//     if (message.notification != null) {
//       _showLocalNotification(
//         title: message.notification?.title ?? 'Notification',
//         body: message.notification?.body ?? '',
//         payload: jsonEncode(message.data),
//       );
//     }
//   }

//   // Show local notification
//   Future<void> _showLocalNotification({
//     required String title,
//     required String body,
//     required String payload,
//   }) async {
//     // Android notification details
//     AndroidNotificationDetails androidNotificationDetails =
//         AndroidNotificationDetails(
//       _androidNotificationChannel.id,
//       _androidNotificationChannel.name,
//       channelDescription: _androidNotificationChannel.description,
//       importance: Importance.high,
//       priority: Priority.high,
//     );

//     // Notification details
//     NotificationDetails notificationDetails = NotificationDetails(
//       android: androidNotificationDetails,
//     );

//     // Show the notification
//     await _flutterLocalNotificationsPlugin.show(
//       DateTime.now().millisecondsSinceEpoch.remainder(100000),
//       title,
//       body,
//       notificationDetails,
//       payload: payload,
//     );
//   }

//   // Handle iOS foreground notifications
//   void _onDidReceiveLocalNotification(
//     int id,
//     String? title,
//     String? body,
//     String? payload,
//   ) {
//     debugPrint('Received iOS local notification');
//     // Handle iOS specific foreground notifications
//   }

//   // Handle notification tap
//   void _onNotificationTap(NotificationResponse notificationResponse) {
//     debugPrint('Notification tapped');
//     // TODO: Implement navigation logic
//     // Example:
//     // final payload = notificationResponse.payload;
//     // Navigator.pushNamed(context, '/notification-detail', arguments: payload);
//   }

//   // Background message handler (static method)
//   static Future<void> backgroundMessageHandler(RemoteMessage message) async {
//     debugPrint('Handling background message');
//     // Handle background messages if needed
//   }

//   void _handleTerminatedStateNotification(RemoteMessage message) {
//     // Extract relevant information from the message
//     final notification = message.notification;
//     // ignore: unused_local_variable
//     final data = message.data;

//     if (notification != null) {
//       debugPrint('Notification Title: ${notification.title}');
//       debugPrint('Notification Body: ${notification.body}');
//     }
//   }
// }
// // ////////////////////
// // // In your logout method
// //await PushNotifications().deleteDeviceToken();
///////////////////////////////////////////////////////new inmplimentation//////////////////////
// push_notifications.dart

import 'dart:convert';
import 'dart:developer';


import 'package:dream_carz/domain/repositories/loginrepo.dart'; // adjust if your repo class is elsewhere
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Top-level background notification tap handler for flutter_local_notifications.
/// Must be a top-level or static function and annotated as entry point if used for background.
/// This will be called for "background notification responses" (action taps when app not in foreground).
@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // This runs in the background isolate for notification action taps.
  // Keep it minimal (logging / lightweight work).
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    print('notification action tapped with input: ${notificationResponse.input}');
  }
}

/// PushNotifications helper (singleton).
/// Usage:
/// 1) In main() register Firebase background handler:
///    FirebaseMessaging.onBackgroundMessage(PushNotifications.backgroundMessageHandler);
/// 2) Optionally register the local notifications background response handler:
///    (flutter_local_notifications will call notificationTapBackground if provided to initialize()).
/// 3) Then initialize:
///    await PushNotifications.instance.init();
class PushNotifications {
  // Singleton
  static final PushNotifications _instance = PushNotifications._internal();
  static PushNotifications get instance => _instance;
  factory PushNotifications() => _instance;
  PushNotifications._internal();

  // Firebase Messaging and local notifications plugin instances
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  // Android channel (idempotent to create)
  static const AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  /// Initialize push notifications.
  /// Call this after Firebase.initializeApp() and after registering the Firebase background handler.
  Future<void> init() async {
    try {
      // Request platform permissions
      final settings = await _requestPermissions();

      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        // iOS: ensure foreground presentation (so notifications are shown while app in foreground)
        await _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

        // Get and store token
        await _getDeviceToken();

        // Init local notifications plugin (channels + initialize)
        await _initLocalNotifications();

        // Setup listeners for messages and taps
        _setupNotificationListeners();
      } else {
        debugPrint('Notification permission not granted: ${settings.authorizationStatus}');
      }
    } catch (e, st) {
      debugPrint('PushNotifications.init error: $e\n$st');
    }
  }

  Future<NotificationSettings> _requestPermissions() async {
    return await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      criticalAlert: true, // requires iOS entitlement if used
      announcement: false,
      carPlay: false,
    );
  }

  // Get and persist device FCM token, and listen to refreshes.
  Future<String?> _getDeviceToken() async {
    try {
      final token = await _firebaseMessaging.getToken();
      debugPrint('FCM Device Token: $token');

      if (token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('FCM_TOKEN', token);
      }

      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        debugPrint('FCM Token refreshed: $newToken');
        _storeTokenLocally(newToken);
        _updateTokenIfLoggedIn(newToken);
      });

      return token;
    } catch (e) {
      debugPrint('Error fetching FCM token: $e');
      return null;
    }
  }

  Future<void> _storeTokenLocally(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('FCM_TOKEN', token);
  }

  Future<void> _updateTokenIfLoggedIn(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.containsKey('USER_TOKEN') &&
        prefs.getString('USER_TOKEN')?.isNotEmpty == true;

    if (isLoggedIn) {
      final loginRepo = Loginrepo();
      try {
        await loginRepo.updatetoken(token: token);
      } catch (e) {
        debugPrint('Failed to update token on server: $e');
      }
    }
  }

  /// Call after user logs in to send the stored token to server
  Future<void> sendTokenToServer() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('FCM_TOKEN');
    log('sendservertoken: $token');
    if (token != null) {
      final loginRepo = Loginrepo();
      try {
        await loginRepo.updatetoken(token: token);
      } catch (e) {
        debugPrint('Failed to send token to server: $e');
      }
    }
  }

  /// Delete device token (logout flow). Cancels local notifications and deletes Android channel.
  Future<void> deleteDeviceToken() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        final apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken == null) {
          debugPrint('APNs token not available; skipping deleteToken.');
        } else {
          await _firebaseMessaging.deleteToken();
          debugPrint('iOS: FCM token deleted.');
        }
      } else {
        await _firebaseMessaging.deleteToken();
        debugPrint('Android: FCM token deleted.');
      }

      // Cancel local notifications and delete Android channel if present
      await _flutterLocalNotificationsPlugin.cancelAll();
      final androidImpl = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
      if (androidImpl != null) {
        await androidImpl.deleteNotificationChannel(_androidNotificationChannel.id);
      }
    } catch (e) {
      debugPrint('Error deleting device token: $e');
    }
  }

  // Initialize flutter_local_notifications and create Android channel.
  Future<void> _initLocalNotifications() async {
    // Android settings
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // Darwin (iOS/macOS) settings — do NOT include onDidReceiveLocalNotification (deprecated/old)
    final DarwinInitializationSettings darwinInitializationSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      // Add notificationCategories if you need actions or text input
      // notificationCategories: <DarwinNotificationCategory>[ ... ],
    );

    // IMPORTANT: using iOS: and macOS: named params (matches current example APIs)
    final InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
      macOS: darwinInitializationSettings,
    );

    // Create the Android channel (idempotent)
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannel);

    // Initialize plugin (modern callbacks)
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  // Setup message listeners for FCM (foreground messages, taps, initial message)
  void _setupNotificationListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground FCM message received');
      _handleForegroundMessage(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('User tapped notification (app opened from background)');
      _handleTerminatedStateNotification(message);
    });

    // If app was launched from terminated state via notification
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        debugPrint('App launched from terminated state by notification');
        _handleTerminatedStateNotification(message);
      }
    });
  }

  // Show a local notification for foreground messages
  void _handleForegroundMessage(RemoteMessage message) {
    final notif = message.notification;
    if (notif != null) {
      _showLocalNotification(
        title: notif.title ?? 'Notification',
        body: notif.body ?? '',
        payload: jsonEncode(message.data),
      );
    }
  }

  Future<void> _showLocalNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      _androidNotificationChannel.id,
      _androidNotificationChannel.name,
      channelDescription: _androidNotificationChannel.description,
      importance: Importance.high,
      priority: Priority.high,
    );

    final notificationDetails = NotificationDetails(
      android: androidDetails,
      // Add darwin: DarwinNotificationDetails(...) if you want iOS-specific details
    );

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch.remainder(100000), // id
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // Modern notification tap handler (when app is in foreground or background)
  void _onNotificationTap(NotificationResponse response) {
    debugPrint('Notification tapped (response.payload=${response.payload})');
    // TODO: implement navigation. Use a GlobalKey<NavigatorState> if you need to navigate here.
    // Example:
    // final payload = response.payload;
    // navigatorKey.currentState?.pushNamed('/detail', arguments: payload);
  }

  /// Firebase background message handler. Must be top-level or static. Register with:
  /// FirebaseMessaging.onBackgroundMessage(PushNotifications.backgroundMessageHandler);
  static Future<void> backgroundMessageHandler(RemoteMessage message) async {
    // If you need firebase in background, ensure Firebase.initializeApp() was called in main() as needed.
    debugPrint('Handling background FCM message in PushNotifications.backgroundMessageHandler');
    try {
      // Minimal background processing e.g., log data or update a lightweight storage
      debugPrint('Background message data: ${message.data}');
    } catch (e) {
      debugPrint('Error in backgroundMessageHandler: $e');
    }
  }

  // Handle notification that opened the app from background/terminated
  void _handleTerminatedStateNotification(RemoteMessage message) {
    final notif = message.notification;
    final data = message.data;
    if (notif != null) {
      debugPrint('Notification opened app - title: ${notif.title}, body: ${notif.body}');
    }
    debugPrint('Notification opened app - data: $data');
    // TODO: route to a screen via navigatorKey if needed
  }
}
