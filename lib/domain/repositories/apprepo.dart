import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dream_carz/core/urls.dart';
import 'package:dream_carz/data/booked_carmodel.dart';
import 'package:dream_carz/data/booking_overview_model.dart';
import 'package:dream_carz/data/booking_requestmodel.dart';
import 'package:dream_carz/data/cars_model.dart';
import 'package:dream_carz/data/categories_model.dart';
import 'package:dream_carz/data/city_model.dart';
import 'package:dream_carz/data/confirm_bookingmodel.dart';
import 'package:dream_carz/data/coupen_model.dart';
import 'package:dream_carz/data/documentlist_model.dart';
import 'package:dream_carz/data/km_model.dart';
import 'package:dream_carz/data/ordermodel.dart';
import 'package:dream_carz/data/search_model.dart';
import 'package:dream_carz/data/upload_documentmodel.dart';
import 'package:dream_carz/widgets/shared_preferences.dart';

import 'package:flutter/material.dart';

class ApiResponse<T> {
  final T? data;
  final String message;
  final bool error;
  final int status;

  ApiResponse({
    this.data,
    required this.message,
    required this.error,
    required this.status,
  });
}

class Apprepo {
  final Dio dio;

  Apprepo({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: Endpoints.baseUrl,
              headers: {'Content-Type': 'application/json'},
            ),
          );
  ///////////// Fetch cities/////////////
  Future<ApiResponse<List<CityModel>>> fetchcities() async {
    try {
      // final token = await getUserToken();
      Response response = await dio.post(
        Endpoints.fetchcities,
        // data: {"cityId": divisionId},
        //options: Options(headers: {'Authorization': token}),
      );

      final responseData = response.data;

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> citylist = responseData['data'];
        List<CityModel> cities = citylist
            .map((category) => CityModel.fromJson(category))
            .toList();
        return ApiResponse(
          data: cities,
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

  //   //////////------------fetchcars-----------/////////////////
  Future<ApiResponse<List<CarsModel>>>fetchedCars({required SearchModel search}) async {
    // log('pushtoken when login ${user.pushToken}');
    
    try {
      Response response = await dio.post(Endpoints.searchcars, data: search);
      final responseData = response.data;
      log('responsestatus${responseData}');
      log('responsestatus${responseData['status']}');

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> cars = responseData['data'];
        List<CarsModel> fetchedcars = cars
            .map((car) => CarsModel.fromJson(car))
            .toList();
        return ApiResponse(
          data: fetchedcars,
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
  //   //////////------------fetchcategories-----------/////////////////
  Future<ApiResponse<List<CategoriesModel>>>fetchcategories() async {
    // log('pushtoken when login ${user.pushToken}');
    try {
      Response response = await dio.post(Endpoints.categories);
      final responseData = response.data;
      log('responsestatus${responseData}');
      log('responsestatus${responseData['status']}');

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> cars = responseData['data'];
        List<CategoriesModel> fetchcategories = cars
            .map((car) => CategoriesModel.fromJson(car))
            .toList();
        return ApiResponse(
          data: fetchcategories,
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
    //   //////////------------fetchcategories-----------/////////////////
  Future<ApiResponse<List<KmModel>>>fetchkmplans() async {
    // log('pushtoken when login ${user.pushToken}');
    try {
      Response response = await dio.post(Endpoints.kmplans);
      final responseData = response.data;
      // log('responsestatus${responseData}');
      // log('responsestatus${responseData['status']}');

      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> kms = responseData['data'];
        List<KmModel> fetchkms = kms
            .map((km) => KmModel.fromJson(km))
            .toList();
        return ApiResponse(
          data: fetchkms,
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
    //   //////////------------fetchbookingoverview-----------/////////////////
  Future<ApiResponse<BookingOverviewModel>>bookingoverview({required BookingRequestmodel details}) async {
    // log('pushtoken when login ${user.pushToken}');
    try {
        final token = await getUserToken();
      Response response = await dio.post(Endpoints.bookingoverview, data: details, options: Options(headers: {'Authorization': token}));
      final responseData = response.data;
      // log('responsestatus${responseData}');
      // log('responsestatus${responseData['status']}');

      if (!responseData["error"] && responseData["status"] == 200) {
        final  booking = BookingOverviewModel.fromJson(responseData['data']);
 
        return ApiResponse(
          data:booking,
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
  // //////////-------------------applycoupen---------------//////////////////
  Future<ApiResponse<CouponModel>> applycoupen({required String coupencode}) async {
    try {
      final token = await getUserToken();
      log(token);
      Response response = await dio.get(
        Endpoints.coupen,
        options: Options(headers: {'Authorization': token}),data: {
    "couponCode": coupencode
}
      );
      log("Response received: ${response.statusCode}");
      final responseData = response.data;
     // log("Response data: $responseData");
 
      if ( responseData["status"] == 200) {
        final coupen = CouponModel.fromJson(responseData["data"]);



        return ApiResponse(
          data:coupen,
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
    //   //////////------------BookingConfirmation-----------/////////////////
  Future<ApiResponse<BookedCarmodel>>bookingconfirmation({required ConfirmBookingmodel bookingdetails}) async {
    // log('pushtoken when login ${user.pushToken}');
    
    try {
      final token=await getUserToken();
      Response response = await dio.post(Endpoints.bookingconfirmation, data: bookingdetails,options: Options(headers: {'Authorization': token}));
      final responseData = response.data;
   

      if (!responseData["error"] && responseData["status"] == 200) {
        final bookingconfirmationdetails =BookedCarmodel.fromJson(responseData['data']) ;
     
        return ApiResponse(
          data: bookingconfirmationdetails,
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
      //   //////////------------BookingConfirmation-----------/////////////////
  Future<ApiResponse>bookingstatus({required String orderId}) async {
    // log('pushtoken when login ${user.pushToken}');
    
    try {
      final token=await getUserToken();
      Response response = await dio.post(Endpoints.bookingstatus, data: orderId,options: Options(headers: {'Authorization': token}));
      final responseData = response.data;
   
log("Response data: $responseData");
 
      if (!responseData["error"] && responseData["status"] == 200) {

        return ApiResponse(
          data:null,
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
    //   //////////------------fetchdocumentlists-----------/////////////////
  Future<ApiResponse<List<DocumentlistModel>>>fetchdocumenlists({required String bookingId}) async {
    // log('pushtoken when login ${user.pushToken}');
    final token=await getUserToken();
    try {
      Response response = await dio.post(Endpoints.documentslist, data: {
    "bookingId":bookingId
},options: Options(headers: {'Authorization': token}));
      final responseData = response.data;
   
      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> documents = responseData['data'];
        List<DocumentlistModel> fetcheddocuments = documents
            .map((doc) => DocumentlistModel.fromJson(doc))
            .toList();
        return ApiResponse(
          data: fetcheddocuments,
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
      //   //////////------------Upload documents-----------/////////////////
  Future<ApiResponse>uploadDocuments({required UploadDocumentmodel documents}) async {
    // log('pushtoken when login ${user.pushToken}');
    
    try {
      final token=await getUserToken();
      Response response = await dio.post(Endpoints.documentupload, data: documents,options: Options(headers: {'Authorization': token}));
      final responseData = response.data;
   

      if (!responseData["error"] && responseData["status"] == 200) {
       // final bookingconfirmationdetails =BookedCarmodel.fromJson(responseData['data']) ;
     
        return ApiResponse(
          data:null,
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
      //   //////////------------myorders-----------/////////////////
  Future<ApiResponse<List<Ordermodel>>>myorders() async {
    // log('pushtoken when login ${user.pushToken}');
    final token=await getUserToken();
    try {
      Response response = await dio.post(Endpoints.myorders,options: Options(headers: {'Authorization': token}));
      final responseData = response.data;
   
      if (!responseData["error"] && responseData["status"] == 200) {
        final List<dynamic> orders = responseData['data'];
        List<Ordermodel> fetchedorders = orders
            .map((doc) => Ordermodel.fromJson(doc))
            .toList();
        return ApiResponse(
          data: fetchedorders,
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
  void dispose() {
    dio.close();
  }
}
