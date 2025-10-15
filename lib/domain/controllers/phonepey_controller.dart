import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';


class PhonePeService {
  final String environment = "PRODUCTION";
  final String merchantId = "M2335NMFM3DOC";
  final String saltKey = "db01daba-7375-4098-9989-a97fe67acdd6";
  final String saltIndex = "1";
  final String clientId = "SU2508211650245481786479";

  Future<void> initSdk({required String flowid}) async {
    try {
      bool isInitialized = await PhonePePaymentSdk.init(
        environment,
        merchantId,
        flowid,
        true,
      );
      if (isInitialized) {
        log("PhonePe SDK Initialized: $isInitialized");
      } else {
        log("PhonePe SDK Initialized: $isInitialized");
      }
    } catch (e) {
      log("Init SDK Error: $e");
    }
  }

  Future<Map<String, dynamic>?> startTransaction(
      {required double amount,
      required String orderId,
      required String flowId,
      required BuildContext context}) async {
    try {
      final request = await _initApiCall(amount, orderId);
      log(request.toString());
      if (request != null) {
        final response = await PhonePePaymentSdk.startTransaction(
          request,
          'com.crisant.dreamcarz',
        );

        if (response != null) {
          log("Payment Response: ${response.toString()}");
          String status = response['status'].tostring();
          String error = response['error'].toString();

          String paymentStatus;
          if (status == 'SUCCESS') {
            paymentStatus = 'CONFIRMED';
          } else if (status == 'CANCELLED') {
            paymentStatus = 'FAILED';
          } else {
            paymentStatus = 'CANCELLED';
          }

          // Update payment status in backend
          // context.read<UpdatePaymentBloc>().add(UpdatePaymentInitialEvent(
          //     orderId: flowId, status: paymentStatus));

          // Return response for navigation handling
          return {
            'status': paymentStatus,
            'response': response,
            'amount': amount.toString(),
            'transactionId': orderId
          };
        } else {
          log("❌ Payment Failed: Null response");
          return {'status': 'FAILED', 'error': 'Null response'};
        }
      } else {
        log("Request is null");
        return {'status': 'FAILED', 'error': 'Invalid request'};
      }
    } catch (e) {
      log("❌ Transaction Exception: $e");
      return {'status': 'FAILED', 'error': e.toString()};
    }
  }

  // Handle errors
  void handleError(Object error) {
    log('Payment error: $error');
    // You can add more error handling logic here
  }

  Dio dio = Dio();

  Future<String?> _getAccessToken() async {
    try {
      final response = await dio.post(
        "https://api.phonepe.com/apis/identity-manager/v1/oauth/token",
        data: {
          'client_id': clientId,
          'client_version': saltIndex,
          'client_secret': saltKey,
          'grant_type': "client_credentials"
        },
        options: Options(
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final token = data['access_token'];
        log("Access Token: $token");
        return token;
      } else {
        log("Error: ${response.statusCode} - ${response.data}");
        return null;
      }
    } catch (e) {
      log("Error fetching token: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> _createOrderId(String accessToken,
      {required String uniqueOrderId, required double amount}) async {
    try {
      final response = await dio.post(
        "https://api.phonepe.com/apis/pg/checkout/v2/sdk/order",
        data: {
          "merchantOrderId": uniqueOrderId,
          "amount": amount * 100,
          "paymentFlow": {"type": "PG_CHECKOUT"}
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'O-Bearer $accessToken'
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        log("Created Order Body: ${data.toString()}");
        final orderId = data['orderId'];
        final token = data['token'];

        return {'orderId': orderId, 'token': token};
      } else {
        log("Error: ${response.statusCode} - ${response.data}");
        return null;
      }
    } catch (e) {
      log('error creating order ID: $e');
      return null;
    }
  }

  Future<String?> payLoad(String token, String orderId) async {
    try {
      Map<String, dynamic> payload = {
        "orderId": orderId,
        "merchantId": merchantId,
        "token": token,
        "paymentMode": {"type": "PAY_PAGE"},
      };
      String request = jsonEncode(payload);
      log("-------------------- Payload: $request");
      return request;
    } catch (e) {
      log("Error creating payload: $e");
      return null;
    }
  }

  Future<String?> _initApiCall(double amount, String orderId) async {
    log('amounttttttt$amount');
    log('orderiddddddd$orderId');
    final accessToken = await _getAccessToken();
    if (accessToken != null) {
      final orderIdAndToken = await _createOrderId(accessToken,
          amount: amount, uniqueOrderId: orderId);

      if (orderIdAndToken != null) {
        String orderId = orderIdAndToken['orderId'];
        String token = orderIdAndToken['token'];
        log("Order ID: $orderId");
        log("Token: $token");

        String? request = await payLoad(token, orderId);
        if (request != null) {
          return request;
        } else {
          log("Error creating payload");
          return null;
        }
      } else {
        log("Error creating order ID and token");
        return null;
      }
    } else {
      log("Error fetching access token");
      return null;
    }
  }
}