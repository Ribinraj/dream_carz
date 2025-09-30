import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dream_carz/core/urls.dart';
import 'package:dream_carz/data/edit_profile_model.dart';
import 'package:dream_carz/data/profile_model.dart';
import 'package:dream_carz/widgets/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApiResponse<T> {
  final T? data;
  final String message;
  final bool error;
  final int status;

  ApiResponse(
      {this.data,
      required this.message,
      required this.error,
      required this.status});
}

class Loginrepo {
  final Dio dio;

  Loginrepo({Dio? dio})
      : dio = dio ??
            Dio(BaseOptions(
                baseUrl: Endpoints.baseUrl,
                headers: {'Content-Type': 'application/json'}));

  ///----------------------send otp-----------------------------////

  Future<ApiResponse<String>> sendOtp(
      {required String mobileNumber}) async {
    try {
      Response response = await dio
          .post(Endpoints.sendOtp, data: { "mobileNumber": mobileNumber});
      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
        final customerId = responseData["data"][  "customerId"].toString();
     
        return ApiResponse(
            data:customerId,
            message: responseData["message"] ?? 'Success',
            error: false,
            status: responseData["status"]);
      } else {
        return ApiResponse(
            data: null,
            message: responseData["message"],
            error: true,
            status: responseData["status"]);
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
          message: 'Network or server error occured', error: true, status: 500);
    }
  }

//   //////////------------verifyotp-----------/////////////////
  Future<ApiResponse> verifyotp({required String customerId, required String otp}) async {
   // log('pushtoken when login ${user.pushToken}');
    try {
      Response response = await dio.post(Endpoints.verifyotp, data:{
    "customerId": customerId,
    "otp": otp
});
      final responseData = response.data;
      log('responsestatus${responseData}');
      log('responsestatus${responseData['status']}');

      if (!responseData["error"] && responseData["status"] == 200) {
       SharedPreferences preferences = await SharedPreferences.getInstance();
       preferences.setString('USER_TOKEN', responseData["data"]["token"]);
        return ApiResponse(
          data: null,
          message: responseData['messages'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['messages'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);

      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

// //////////---------------resendotp--------------------////////
  Future<ApiResponse<String>> resendotp({required String customerId}) async {
    try {
      Response response =
          await dio.post(Endpoints.resendotp, data: {"customerId":customerId});

      final responseData = response.data;
      if (!responseData["error"] && responseData["status"] == 200) {
        return ApiResponse(
          data: responseData["data"]["userId"],
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    }
  }

// //////////-------------------fetchprofile---------------//////////////////
  Future<ApiResponse<ProfileModel>> fetchprofile() async {
    try {
      final token = await getUserToken();
      log(token);
      Response response = await dio.get(
        Endpoints.fetchprofile,
        options: Options(headers: {'Authorization': token}),
      );
      log("Response received: ${response.statusCode}");
      final responseData = response.data;
      log("Response data: $responseData");
      //    if (responseData['message'] == "Expired token") {
      //   SharedPreferences preferences = await SharedPreferences.getInstance();
      //   await preferences.remove('USER_TOKEN');
      //   // await preferences.clear();
      // }
      if ( responseData["status"] == 200) {
        final user = ProfileModel.fromJson(responseData["data"]);

        //SharedPreferences preferences = await SharedPreferences.getInstance();

        // preferences.setString(
        //     'USER_PUSHTOKEN', responseData["data"]["pushToken"]);

        return ApiResponse(
          data: user,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    } catch (e) {
      // Add a general catch block for other exceptions
      log("Unexpected error: $e");
      return ApiResponse(
        data: null,
        message: 'Unexpected error: $e',
        error: true,
        status: 500,
      );
    }
  }

//   /////////////---------------updateprofile----------/////////////
  Future<ApiResponse> updateprofile(
      {required EditProfileModel profile}) async {
    try {
      final token = await getUserToken();

      Response response = await dio.post(Endpoints.editprofile,
          options: Options(headers: {'Authorization': token}), data: profile);

      final responseData = response.data;

      if (!responseData["error"] && responseData["status"] == 200) {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Success',
          error: false,
          status: responseData["status"],
        );
      } else {
        return ApiResponse(
          data: null,
          message: responseData['message'] ?? 'Something went wrong',
          error: true,
          status: responseData["status"],
        );
      }
    } on DioException catch (e) {
      debugPrint(e.message);
      log(e.toString());
      return ApiResponse(
        data: null,
        message: 'Network or server error occurred',
        error: true,
        status: 500,
      );
    } catch (e) {
      // Add a general catch block for other exceptions
      log("Unexpected error: $e");
      return ApiResponse(
        data: null,
        message: 'Unexpected error: $e',
        error: true,
        status: 500,
      );
    }
  }

//   ///////////////update token/////////////////
Future<void> updatetoken({required String token}) async {
  try {
  //  final userToken = await getUserToken();
    
    Response response = await dio.post(
      Endpoints.settoken, 
      //options: Options(headers: {'Authorization': userToken}),
      data: {  "pushToken": token}
    );
    
    final responseData = response.data;
    if (!responseData["error"] && responseData["status"] == 200) {
      log("FCM token updated successfully");
    } else {
      log("Failed to update FCM token: ${responseData["message"]}");
    }
  } catch (e) {
    log("Error updating FCM token: $e");
  }
}

  void dispose() {
    dio.close();
  }
}
