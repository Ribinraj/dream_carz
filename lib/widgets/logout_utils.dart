// logout_utils.dart
import 'package:dream_carz/domain/controllers/pushnotification_controller.dart';
import 'package:dream_carz/presentation/screens/screen_homepage/screen_homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  /// Simple and reliable logout method
  static Future<void> handleLogout(BuildContext context) async {
    // Get the navigator before any async operations
    final navigator = Navigator.of(context);
    
    try {
      // Clear shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clears all data
      
      // Delete FCM token (with error handling)
      try {
        await PushNotifications().deleteDeviceToken();
      } catch (e) {
        debugPrint('FCM token deletion failed: $e');
        // Continue logout even if FCM fails
      }
      
    } catch (e) {
      debugPrint('Error during logout: $e');
    }
    
    // Navigate to homepage - always executes
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => ScreenHomepage()),
      (route) => false,
    );
  }
}