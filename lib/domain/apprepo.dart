import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dream_carz/core/urls.dart';
import 'package:dream_carz/data/cars_model.dart';
import 'package:dream_carz/data/categories_model.dart';
import 'package:dream_carz/data/city_model.dart';
import 'package:dream_carz/data/search_model.dart';

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
  void dispose() {
    dio.close();
  }
}
