import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';


import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';

enum PaymentStatus { confirmed, failed, cancelled, error }

class TransactionResult {
  final PaymentStatus status;
  final Map<String, dynamic>? rawResponse;
  final String? errorMessage;
  final String? transactionId;
  final double? amount;

  TransactionResult({
    required this.status,
    this.rawResponse,
    this.errorMessage,
    this.transactionId,
    this.amount,
  });
}

class PhonePeService {
  PhonePeService._privateConstructor();
  static final PhonePeService instance = PhonePeService._privateConstructor();

  final Dio _dio = Dio();

  // Config - keep these secure (do not hardcode in production)
  final String environment = "PRODUCTION";
  final String merchantId = "M2335NMFM3DOC";
  final String saltKey = "db01daba-7375-4098-9989-a97fe67acdd6";
  final String saltIndex = "1";
  final String clientId = "SU2508211650245481786479";

  /// Initialize PhonePe SDK.
  /// Returns true if initialization succeeded, false otherwise.
  Future<bool> initSdk({required String flowId, bool enableLogs = true}) async {
    try {
      // PhonePePaymentSdk.init signature -> (environment, merchantId, flowId, enableLogs)
      final bool isInitialized = await PhonePePaymentSdk.init(
        environment,
        merchantId,
        flowId,
        enableLogs,
      );
      log('PhonePe SDK initialized: $isInitialized');
      return isInitialized;
    } catch (e, st) {
      log('PhonePe SDK init error: $e\n$st');
      return false;
    }
  }
  /// Starts transaction and returns a typed TransactionResult
  Future<TransactionResult> startTransaction({
    required double amount,
    required String orderId, // merchant unique order id (your side)
    required String flowId,
  }) async {
    try {
      final requestBody = await _prepareTransactionRequest(amount: amount, orderId: orderId);
      if (requestBody == null) {
        return TransactionResult(
          status: PaymentStatus.error,
          errorMessage: 'Failed to build request payload',
        );
      }

      final rawResponse = await PhonePePaymentSdk.startTransaction(
        requestBody,
        'com.crisant.dreamcarz', // Android package / iOS schema
      );

      if (rawResponse == null) {
        return TransactionResult(
          status: PaymentStatus.failed,
          errorMessage: 'Null response from PhonePe SDK',
        );
      }

      // Normalize status handling (use exact keys your SDK returns)
      final String statusStr = (rawResponse['status'] ?? '').toString().toUpperCase();
      final String errorStr = (rawResponse['error'] ?? '').toString();

      log('PhonePe SDK raw response: $rawResponse');

      PaymentStatus status;
      if (statusStr == 'SUCCESS') {
        status = PaymentStatus.confirmed;
      } else if (statusStr == 'CANCELLED' || statusStr == 'INTERRUPTED') {
        status = PaymentStatus.cancelled;
      } else {
        status = PaymentStatus.failed;
      }

      // Try to extract a transaction id from response if available:
      final String? txId = rawResponse['transactionId']?.toString()
          ?? rawResponse['orderId']?.toString()
          ?? orderId;

      return TransactionResult(
        status: status,
        rawResponse: Map<String, dynamic>.from(rawResponse),
        errorMessage: errorStr.isNotEmpty ? errorStr : null,
        transactionId: txId,
        amount: amount,
      );
    } catch (e, st) {
      log('startTransaction exception: $e\n$st');
      return TransactionResult(
        status: PaymentStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  // -------------------------
  // Helper methods for API calls (keeping them private)
  // -------------------------
  Future<String?> _getAccessToken() async {
    try {
      final response = await _dio.post(
        "https://api.phonepe.com/apis/identity-manager/v1/oauth/token",
        data: {
          'client_id': clientId,
          'client_version': saltIndex,
          'client_secret': saltKey,
          'grant_type': "client_credentials"
        },
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {"Accept": "application/json"},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final token = response.data['access_token']?.toString();
        log('Access token: $token');
        return token;
      } else {
        log('Token fetch failed: ${response.statusCode} - ${response.data}');
        return null;
      }
    } catch (e, st) {
      log('Error fetching token: $e\n$st');
      return null;
    }
  }

  Future<Map<String, dynamic>?> _createOrder(String accessToken,
      {required String uniqueOrderId, required double amount}) async {
    try {
      final body = {
        "merchantOrderId": uniqueOrderId,
        "amount": (amount * 100).toInt(), // in paise
        "paymentFlow": {"type": "PG_CHECKOUT"}
      };

      final response = await _dio.post(
        "https://api.phonepe.com/apis/pg/checkout/v2/sdk/order",
        data: jsonEncode(body),
        options: Options(
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'O-Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = Map<String, dynamic>.from(response.data);
        log('Created order response: $data');
        return data;
      } else {
        log('Create order failed: ${response.statusCode} - ${response.data}');
        return null;
      }
    } catch (e, st) {
      log('Error creating order: $e\n$st');
      return null;
    }
  }

  Future<String?> _buildSdkRequest({required String token, required String orderId}) async {
    try {
      final payload = {
        "orderId": orderId,
        "merchantId": merchantId,
        "token": token,
        "paymentMode": {"type": "PAY_PAGE"},
      };
      return jsonEncode(payload);
    } catch (e, st) {
      log('Error building SDK payload: $e\n$st');
      return null;
    }
  }

  Future<String?> _prepareTransactionRequest({required double amount, required String orderId}) async {
    final accessToken = await _getAccessToken();
    if (accessToken == null) return null;

    final orderResponse = await _createOrder(accessToken, uniqueOrderId: orderId, amount: amount);
    if (orderResponse == null) return null;

    final sdkOrderId = orderResponse['orderId']?.toString() ?? orderResponse['merchantOrderId']?.toString() ?? orderId;
    final token = orderResponse['token']?.toString();
    if (token == null) return null;

    final request = await _buildSdkRequest(token: token, orderId: sdkOrderId);
    return request;
  }

  // Generic error handler hook (you can expand)
  void handleError(Object error) {
    log('Payment error: $error');
  }
}

// Note: PhonePePaymentSdk is used in this file and should be imported where available.
// Add `import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';` in your project.


// class PhonePeService {
//   final String environment = "PRODUCTION";
//   final String merchantId = "M2335NMFM3DOC";
//   final String saltKey = "db01daba-7375-4098-9989-a97fe67acdd6";
//   final String saltIndex = "1";
//   final String clientId = "SU2508211650245481786479";

//   Future<void> initSdk({required String flowid}) async {
//     try {
//       bool isInitialized = await PhonePePaymentSdk.init(
//         environment,
//         merchantId,
//         flowid,
//         true,
//       );
//       if (isInitialized) {
//         log("PhonePe SDK Initialized: $isInitialized");
//       } else {
//         log("PhonePe SDK Initialized: $isInitialized");
//       }
//     } catch (e) {
//       log("Init SDK Error: $e");
//     }
//   }

//   Future<Map<String, dynamic>?> startTransaction(
//       {required double amount,
//       required String orderId,
//       required String flowId,
//       required BuildContext context}) async {
//     try {
//       final request = await _initApiCall(amount, orderId);
//       log(request.toString());
//       if (request != null) {
//         final response = await PhonePePaymentSdk.startTransaction(
//           request,
//           'com.crisant.dreamcarz',
//         );

//         if (response != null) {
//           log("Payment Response: ${response.toString()}");
//           String status = response['status'].tostring();
//           String error = response['error'].toString();

//           String paymentStatus;
//           if (status == 'SUCCESS') {
//             paymentStatus = 'CONFIRMED';
//           } else if (status == 'CANCELLED') {
//             paymentStatus = 'FAILED';
//           } else {
//             paymentStatus = 'CANCELLED';
//           }

//           // Update payment status in backend
//           // context.read<UpdatePaymentBloc>().add(UpdatePaymentInitialEvent(
//           //     orderId: flowId, status: paymentStatus));

//           // Return response for navigation handling
//           return {
//             'status': paymentStatus,
//             'response': response,
//             'amount': amount.toString(),
//             'transactionId': orderId
//           };
//         } else {
//           log("❌ Payment Failed: Null response");
//           return {'status': 'FAILED', 'error': 'Null response'};
//         }
//       } else {
//         log("Request is null");
//         return {'status': 'FAILED', 'error': 'Invalid request'};
//       }
//     } catch (e) {
//       log("❌ Transaction Exception: $e");
//       return {'status': 'FAILED', 'error': e.toString()};
//     }
//   }

//   // Handle errors
//   void handleError(Object error) {
//     log('Payment error: $error');
//     // You can add more error handling logic here
//   }

//   Dio dio = Dio();

//   Future<String?> _getAccessToken() async {
//     try {
//       final response = await dio.post(
//         "https://api.phonepe.com/apis/identity-manager/v1/oauth/token",
//         data: {
//           'client_id': clientId,
//           'client_version': saltIndex,
//           'client_secret': saltKey,
//           'grant_type': "client_credentials"
//         },
//         options: Options(
//           headers: {"Content-Type": "application/x-www-form-urlencoded"},
//         ),
//       );

//       if (response.statusCode == 200) {
//         final data = response.data;
//         final token = data['access_token'];
//         log("Access Token: $token");
//         return token;
//       } else {
//         log("Error: ${response.statusCode} - ${response.data}");
//         return null;
//       }
//     } catch (e) {
//       log("Error fetching token: $e");
//       return null;
//     }
//   }

//   Future<Map<String, dynamic>?> _createOrderId(String accessToken,
//       {required String uniqueOrderId, required double amount}) async {
//     try {
//       final response = await dio.post(
//         "https://api.phonepe.com/apis/pg/checkout/v2/sdk/order",
//         data: {
//           "merchantOrderId": uniqueOrderId,
//           "amount": amount * 100,
//           "paymentFlow": {"type": "PG_CHECKOUT"}
//         },
//         options: Options(
//           headers: {
//             "Content-Type": "application/json",
//             'Authorization': 'O-Bearer $accessToken'
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         final data = response.data;
//         log("Created Order Body: ${data.toString()}");
//         final orderId = data['orderId'];
//         final token = data['token'];

//         return {'orderId': orderId, 'token': token};
//       } else {
//         log("Error: ${response.statusCode} - ${response.data}");
//         return null;
//       }
//     } catch (e) {
//       log('error creating order ID: $e');
//       return null;
//     }
//   }

//   Future<String?> payLoad(String token, String orderId) async {
//     try {
//       Map<String, dynamic> payload = {
//         "orderId": orderId,
//         "merchantId": merchantId,
//         "token": token,
//         "paymentMode": {"type": "PAY_PAGE"},
//       };
//       String request = jsonEncode(payload);
//       log("-------------------- Payload: $request");
//       return request;
//     } catch (e) {
//       log("Error creating payload: $e");
//       return null;
//     }
//   }

//   Future<String?> _initApiCall(double amount, String orderId) async {
//     log('amounttttttt$amount');
//     log('orderiddddddd$orderId');
//     final accessToken = await _getAccessToken();
//     if (accessToken != null) {
//       final orderIdAndToken = await _createOrderId(accessToken,
//           amount: amount, uniqueOrderId: orderId);

//       if (orderIdAndToken != null) {
//         String orderId = orderIdAndToken['orderId'];
//         String token = orderIdAndToken['token'];
//         log("Order ID: $orderId");
//         log("Token: $token");

//         String? request = await payLoad(token, orderId);
//         if (request != null) {
//           return request;
//         } else {
//           log("Error creating payload");
//           return null;
//         }
//       } else {
//         log("Error creating order ID and token");
//         return null;
//       }
//     } else {
//       log("Error fetching access token");
//       return null;
//     }
//   }
// }