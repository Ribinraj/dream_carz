// screen_payment_page.dart
import 'dart:developer';

import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/data/booked_carmodel.dart';
import 'package:dream_carz/domain/controllers/phonepey_controller.dart'; // PhonePeService

import 'package:dream_carz/presentation/blocs/payment_status_bloc/payment_status_bloc.dart';
import 'package:dream_carz/presentation/screens/screen_paymentpages/screen_paymentfailiurepage.dart';
import 'package:dream_carz/presentation/screens/screen_paymentpages/screen_paymentsuccesspage.dart';
import 'package:dream_carz/widgets/custom_snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ScreenPaymentPage extends StatefulWidget {
  final BookedCarmodel bookingData;

  const ScreenPaymentPage({super.key, required this.bookingData});

  @override
  State<ScreenPaymentPage> createState() => _ScreenPaymentPageState();
}

class _ScreenPaymentPageState extends State<ScreenPaymentPage> {
  // formatting helpers
  String _formatDate(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('dd MMM yyyy').format(dateTime);
    } catch (e) {
      return dateTimeString;
    }
  }

  String _formatTime(String dateTimeString) {
    try {
      DateTime dateTime = DateTime.parse(dateTimeString);
      return DateFormat('hh:mm a').format(dateTime);
    } catch (e) {
      return '';
    }
  }

  String _formatAmount(String? amount) {
    if (amount == null || amount.isEmpty) return '₹ 0.00';
    try {
      double value = double.parse(amount);
      return '₹ ${value.toStringAsFixed(2)}';
    } catch (e) {
      return '₹ $amount';
    }
  }

  // state
  bool _isProcessing = false;
  bool _isSdkReady = false;
  String _paymentStatus = 'Ready for payment';

  // PhonePe service and flow id
  final PhonePeService _phonePeService = PhonePeService.instance;
  final Uuid _uuid = const Uuid();
  late final String _flowId;

  @override
  void initState() {
    super.initState();
    // make alphanumeric flowId (UUID without hyphens)
    _flowId = _uuid.v4().replaceAll('-', '');
    _initializePhonePeSdk();
  }

  Future<void> _initializePhonePeSdk() async {
    if (!mounted) return;
    setState(() {
      _paymentStatus = 'Initializing payment SDK...';
    });

    try {
      final bool ok = await _phonePeService.initSdk(
        flowId: _flowId,
        enableLogs: true,
      );

      if (!mounted) return;

      if (ok) {
        setState(() {
          _isSdkReady = true;
          _paymentStatus = 'Ready for payment';
        });
      } else {
        setState(() {
          _isSdkReady = false;
          _paymentStatus = 'SDK initialization failed';
        });
        CustomSnackbar.show(
          context,
          message:
              'Payment initialization failed. Please try again or contact support.',
          type: SnackbarType.error,
        );
      }
    } catch (e, st) {
      log('SDK init error: $e\n$st');
      if (!mounted) return;
      setState(() {
        _isSdkReady = false;
        _paymentStatus = 'SDK initialization error';
      });
      CustomSnackbar.show(
        context,
        message:
            'Payment initialization error. Please try again or contact support.',
        type: SnackbarType.error,
      );
    }
  }
Future<void> _startpayment() async {
  if (_isProcessing) return;

  if (!_isSdkReady) {
    CustomSnackbar.show(
      context,
      message: 'Payment SDK not yet initialized. Please wait.',
      type: SnackbarType.error,
    );
    return;
  }

  setState(() {
    _isProcessing = true;
    _paymentStatus = 'Initiating payment...';
  });


  final paymentBloc = context.read<PaymentStatusBloc>();

  try {
    double amount = double.tryParse(widget.bookingData.grandTotal ?? '0') ?? 0.0;
    final String orderId = widget.bookingData.transactionId ?? _uuid.v4().replaceAll('-', '');

    final TransactionResult result = await _phonePeService.startTransaction(
      amount: amount,
      orderId: orderId,
      flowId: _flowId,
    );

    // Option A: Always call backend order update via BLoC (simple)
    paymentBloc.add(Paymentstatuseventcalling(orderId:widget.bookingData.bookingId));

    // Option B: If you still want to show different snackbars locally, you can:
    switch (result.status) {
      case PaymentStatus.confirmed:
        if (mounted) setState(() => _paymentStatus = 'Payment successful');
        // you may optionally show a snackbar here, but final navigation is handled by BlocListener
        break;
      case PaymentStatus.cancelled:
        if (mounted) setState(() => _paymentStatus = 'Payment cancelled');
        break;
      case PaymentStatus.failed:
      case PaymentStatus.error:
        if (mounted) setState(() => _paymentStatus = 'Payment failed');
        break;
    }
  } catch (e, st) {
    log('Payment exception: $e\n$st');
    _handleError(e);
    // Optionally inform backend about an error by calling bloc with orderId
    final String orderId = widget.bookingData.transactionId ?? _uuid.v4().replaceAll('-', '');
    paymentBloc.add(Paymentstatuseventcalling(orderId: orderId));
  } finally {
    if (mounted) {
      setState(() {
        _isProcessing = false;
      });
    }
  }
}

  // Future<void> _startpayment() async {
  //   if (_isProcessing) return;

  //   if (!_isSdkReady) {
  //     CustomSnackbar.show(
  //       context,
  //       message: 'Payment SDK not yet initialized. Please wait.',
  //       type: SnackbarType.error,
  //     );
  //     return;
  //   }

  //   setState(() {
  //     _isProcessing = true;
  //     _paymentStatus = 'Initiating payment...';
  //   });
  //   final appRepo = Apprepo();
  //   try {
  //     // parse amount from bookingData (fallback to 0)
  //     double amount =
  //         double.tryParse(widget.bookingData.grandTotal ?? '0') ?? 0.0;

  //     // orderId - ensure non-null string
  //     final String orderId =
  //         widget.bookingData.transactionId ?? _uuid.v4().replaceAll('-', '');

  //     // Use the service's typed startTransaction
  //     final TransactionResult result = await _phonePeService.startTransaction(
  //       amount: amount,
  //       orderId: orderId,
  //       flowId: _flowId,
  //     );
  //     try {
  //       final ApiResponse response = await appRepo.bookingstatus(
  //         orderId: orderId,
  //       );
  //       log('Backend booking status updated: ${response.message}');
  //     } catch (e) {
  //       log('Booking status update failed: $e');
  //     }
  //     // Inspect result and navigate
  //     switch (result.status) {
  //       case PaymentStatus.confirmed:
  //         if (mounted) setState(() => _paymentStatus = 'Payment successful');
  //         _navigateToSuccessPage(
  //           transactionId: result.transactionId ?? orderId,
  //           amount: result.amount ?? amount,
  //           rawResponse: result.rawResponse,
  //         );
  //         break;

  //       case PaymentStatus.cancelled:
  //         if (mounted) setState(() => _paymentStatus = 'Payment cancelled');
  //         _navigateToFailurePage(
  //           reason: result.errorMessage ?? 'Payment cancelled by user',
  //           rawResponse: result.rawResponse,
  //         );
  //         break;

  //       case PaymentStatus.failed:
  //         if (mounted) setState(() => _paymentStatus = 'Payment failed');
  //         _navigateToFailurePage(
  //           reason: result.errorMessage ?? 'Payment failed',
  //           rawResponse: result.rawResponse,
  //         );
  //         break;

  //       case PaymentStatus.error:
  //         if (mounted) setState(() => _paymentStatus = 'Payment error');
  //         _navigateToFailurePage(
  //           reason: result.errorMessage ?? 'Unknown payment error',
  //           rawResponse: result.rawResponse,
  //         );
  //         break;
  //     }
  //   } catch (e, st) {
  //     log('Payment exception: $e\n$st');
  //     _handleError(e);
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         _isProcessing = false;
  //       });
  //     }
  //   }
  // }

  void _handleError(Object error) {
    CustomSnackbar.show(
      context,
      message: 'Payment processing error. Please try again.',
      type: SnackbarType.error,
    );
    try {
      _phonePeService.handleError(error);
    } catch (_) {}
  }

  void _navigateToSuccessPage({
    required String transactionId,
    required double amount,
    Map<String, dynamic>? rawResponse,
  }) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PaymentSuccessPage(
          bookingId:widget.bookingData.bookingId ,
          transactionId: transactionId,
          amount: amount,
          rawResponse: rawResponse,
        ),
      ),
    );
  }

  void _navigateToFailurePage({
    required String reason,
    Map<String, dynamic>? rawResponse,
  }) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) =>
            PaymentFailurePage(reason: reason, rawResponse: rawResponse),
      ),
    );
  }

  // UI (kept your original layout)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            size: ResponsiveUtils.wp(8),
            color: Colors.black,
          ),
        ),
        title: TextStyles.subheadline(
          text: 'Payment',
          color: const Color(0xFF1A365D),
        ),
        centerTitle: false,
      ),
      body: BlocListener<PaymentStatusBloc, PaymentStatusState>(
        listener: (context, state) {
               if (state is PaymentStatusLoadingState) {
            // show a loading dialog / overlay
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          } else {
            // if any non-loading state, remove dialog if open
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop(); // close loading dialog
            }
          }

          if (state is PaymentStatusSuccessState) {
            // navigate to success page
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => PaymentSuccessPage(amount:double.parse(widget.bookingData.grandTotal!),transactionId:widget.bookingData.transactionId!,bookingId:widget.bookingData.bookingId ,),
            ));
          } else if (state is PaymentStatusErrorState) {
            // show error and navigate to failure page or show message
            CustomSnackbar.show(
              context,
              message: state.message,
              type: SnackbarType.error,
            );
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => PaymentFailurePage(reason: state.message),
            ));
          }
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                child: Column(
                  children: [
                    // Booking Summary Card
                    _buildBookingSummaryCard(),

                    ResponsiveSizedBox.height20,

                    // Delivery/Pickup Details Card
                    widget.bookingData.fulfillment.toLowerCase() == 'delivery'
                        ? _buildDeliveryDetailsCard()
                        : _buildPickupDetailsCard(),

                    ResponsiveSizedBox.height20,

                    // Payment Amount Card
                    _buildPaymentAmountCard(),

                    ResponsiveSizedBox.height20,
                    // status text
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(4),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextStyles.caption(
                              text: _paymentStatus,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Pay Now Button
            _buildPayNowButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingSummaryCard() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.event_note,
                color: Colors.red,
                size: ResponsiveUtils.sp(6),
              ),
              ResponsiveSizedBox.width10,
              TextStyles.subheadline(
                text: 'Booking Details',
                color: Colors.black,
              ),
            ],
          ),
          ResponsiveSizedBox.height15,

          // Booking Number
          _buildInfoRow(
            icon: Icons.confirmation_number_outlined,
            label: 'Booking #',
            value: widget.bookingData.bookingNumber,
          ),
          ResponsiveSizedBox.height15,

          // Vehicle Model - You might need to get this from another API
          _buildInfoRow(
            icon: Icons.directions_car,
            label: 'Vehicle',
            value: 'Model ID: ${widget.bookingData.modelId}',
          ),
          ResponsiveSizedBox.height15,

          // Duration
          _buildInfoRow(
            icon: Icons.access_time,
            label: 'Duration',
            value: widget.bookingData.duration ?? 'N/A',
          ),
          ResponsiveSizedBox.height15,

          // Free Kilometers
          _buildInfoRow(
            icon: Icons.speed,
            label: 'Free Kilometers',
            value: '${widget.bookingData.freeKm ?? '0'} KM',
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryDetailsCard() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.local_shipping_outlined,
                color: Colors.red,
                size: ResponsiveUtils.sp(6),
              ),
              ResponsiveSizedBox.width10,
              TextStyles.subheadline(
                text: 'Delivery Details',
                color: Colors.black,
              ),
            ],
          ),
          ResponsiveSizedBox.height15,

          // From Date
          _buildDateRow(
            icon: Icons.calendar_today,
            label: 'From',
            date: _formatDate(widget.bookingData.bookingFrom),
            time: _formatTime(widget.bookingData.bookingFrom),
            isStart: true,
          ),
          ResponsiveSizedBox.height15,

          // To Date
          _buildDateRow(
            icon: Icons.event,
            label: 'To',
            date: _formatDate(widget.bookingData.bookingTo),
            time: _formatTime(widget.bookingData.bookingTo),
            isStart: false,
          ),
          ResponsiveSizedBox.height15,

          Divider(color: Colors.grey[300], thickness: 1),
          ResponsiveSizedBox.height15,

          // Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.home_outlined,
                color: Colors.grey[600],
                size: ResponsiveUtils.sp(5),
              ),
              ResponsiveSizedBox.width10,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyles.body(
                      text: 'Delivery Address',
                      color: Colors.grey[600],
                    ),
                    ResponsiveSizedBox.height5,
                    TextStyles.body(
                      text: widget.bookingData.deliveryAddress ?? 'N/A',
                      weight: FontWeight.w600,
                    ),
                    if (widget.bookingData.deliveryArea != null &&
                        widget.bookingData.deliveryArea!.isNotEmpty)
                      TextStyles.body(
                        text: widget.bookingData.deliveryArea!,
                        weight: FontWeight.w600,
                      ),
                    ResponsiveSizedBox.height10,
                    Row(
                      children: [
                        if (widget.bookingData.deliveryContactName != null) ...[
                          Icon(
                            Icons.person_outline,
                            size: ResponsiveUtils.sp(4),
                            color: Colors.grey[600],
                          ),
                          ResponsiveSizedBox.width5,
                          Flexible(
                            child: TextStyles.caption(
                              text: widget.bookingData.deliveryContactName!,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                        if (widget.bookingData.deliveryContactMobile !=
                            null) ...[
                          ResponsiveSizedBox.width10,
                          Icon(
                            Icons.phone_outlined,
                            size: ResponsiveUtils.sp(4),
                            color: Colors.grey[600],
                          ),
                          ResponsiveSizedBox.width5,
                          Flexible(
                            child: TextStyles.caption(
                              text: widget.bookingData.deliveryContactMobile!,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPickupDetailsCard() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.store_outlined,
                color: Colors.red,
                size: ResponsiveUtils.sp(6),
              ),
              ResponsiveSizedBox.width10,
              TextStyles.subheadline(
                text: 'Pickup Details',
                color: Colors.black,
              ),
            ],
          ),
          ResponsiveSizedBox.height15,

          // Pickup Type Badge
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(3),
              vertical: ResponsiveUtils.hp(0.8),
            ),
            decoration: BoxDecoration(
              color: Colors.blue.withAlpha(40),
              borderRadius: BorderRadiusStyles.kradius10(),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on,
                  size: ResponsiveUtils.sp(4),
                  color: Colors.blue,
                ),
                ResponsiveSizedBox.width5,
                TextStyles.caption(
                  text: 'Self Pickup from Branch',
                  color: Colors.blue,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
          ResponsiveSizedBox.height15,

          // From Date
          _buildDateRow(
            icon: Icons.calendar_today,
            label: 'Pickup Date',
            date: _formatDate(widget.bookingData.bookingFrom),
            time: _formatTime(widget.bookingData.bookingFrom),
            isStart: true,
          ),
          ResponsiveSizedBox.height15,

          // To Date
          _buildDateRow(
            icon: Icons.event,
            label: 'Return Date',
            date: _formatDate(widget.bookingData.bookingTo),
            time: _formatTime(widget.bookingData.bookingTo),
            isStart: false,
          ),
          ResponsiveSizedBox.height15,

          // Branch Info
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadiusStyles.kradius10(),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: ResponsiveUtils.sp(5),
                  color: Colors.blue,
                ),
                ResponsiveSizedBox.width10,
                Expanded(
                  child: TextStyles.caption(
                    text:
                        'Please visit our branch to collect your vehicle at the scheduled time',
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentAmountCard() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 143, 97, 199),
            Color.fromARGB(255, 138, 74, 145),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadiusStyles.kradius15(),
      ),
      child: Column(
        children: [
          TextStyles.body(
            text: 'Total Amount',
            color: Colors.white.withAlpha(220),
          ),
          ResponsiveSizedBox.height10,
          TextStyles.headline(
            text: _formatAmount(widget.bookingData.grandTotal),
            color: Colors.white,
            weight: FontWeight.bold,
          ),
          ResponsiveSizedBox.height15,
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadiusStyles.kradius10(),
              border: Border.all(
                color: Colors.white.withOpacity(0.25),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                _buildAmountRow(
                  'Base Fare',
                  _formatAmount(widget.bookingData.baseFare),
                  isWhite: true,
                ),
                if (widget.bookingData.discount != null &&
                    widget.bookingData.discount != '0.00') ...[
                  ResponsiveSizedBox.height10,
                  _buildAmountRow(
                    'Discount',
                    '- ${_formatAmount(widget.bookingData.discount)}',
                    isWhite: true,
                  ),
                ],
                if (widget.bookingData.deliveryCharges != null &&
                    widget.bookingData.deliveryCharges != '0.00') ...[
                  ResponsiveSizedBox.height10,
                  _buildAmountRow(
                    'Delivery Charges',
                    _formatAmount(widget.bookingData.deliveryCharges),
                    isWhite: true,
                  ),
                ],
                ResponsiveSizedBox.height10,
                _buildAmountRow(
                  'GST',
                  _formatAmount(widget.bookingData.gst),
                  isWhite: true,
                ),
                ResponsiveSizedBox.height10,
                _buildAmountRow(
                  'Security Deposit',
                  _formatAmount(widget.bookingData.securityDeposit),
                  isWhite: true,
                ),
              ],
            ),
          ),
          ResponsiveSizedBox.height10,
          TextStyles.caption(
            text: '*incl. of all taxes',
            color: Colors.white.withAlpha(200),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: ResponsiveUtils.sp(5)),
        ResponsiveSizedBox.width10,
        Expanded(
          child: TextStyles.body(text: label, color: Colors.grey[600]),
        ),
        Flexible(
          child: TextStyles.body(text: value, weight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildDateRow({
    required IconData icon,
    required String label,
    required String date,
    required String time,
    required bool isStart,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
          decoration: BoxDecoration(
            color: isStart
                ? Colors.green.withAlpha(40)
                : Colors.red.withAlpha(40),
            borderRadius: BorderRadiusStyles.kradius10(),
          ),
          child: Icon(
            icon,
            color: isStart ? Colors.green : Colors.red,
            size: ResponsiveUtils.sp(5),
          ),
        ),
        ResponsiveSizedBox.width10,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyles.caption(text: label, color: Colors.grey[600]),
              ResponsiveSizedBox.height5,
              TextStyles.body(text: date, weight: FontWeight.w600),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(3),
            vertical: ResponsiveUtils.hp(0.6),
          ),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadiusStyles.kradius10(),
          ),
          child: TextStyles.caption(text: time, weight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildAmountRow(String label, String amount, {bool isWhite = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextStyles.caption(
          text: label,
          color: isWhite ? Colors.white : Colors.grey[600],
        ),
        TextStyles.caption(
          text: amount,
          color: isWhite ? Colors.white : Colors.black,
          weight: FontWeight.w600,
        ),
      ],
    );
  }

  Widget _buildPayNowButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(ResponsiveUtils.wp(6)),
      child: ElevatedButton(
        onPressed: (!_isSdkReady || _isProcessing) ? null : _startpayment,
        style: ElevatedButton.styleFrom(
          backgroundColor: (!_isSdkReady || _isProcessing)
              ? Colors.grey
              : Colors.purple,
          padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(1.8)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyles.kradius10(),
          ),
          elevation: 0,
        ),
        child: _isProcessing
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SpinKitCircle(size: 20, color: Appcolors.kwhitecolor),
                  ResponsiveSizedBox.width10,
                  TextStyles.body(
                    text: 'Processing',
                    color: Appcolors.kwhitecolor,
                  ),
                ],
              )
            : TextStyles.body(
                text:
                    'Pay Now  ${_formatAmount(widget.bookingData.grandTotal)}',
                color: Colors.white,
                weight: FontWeight.bold,
              ),
      ),
    );
  }
}

// import 'package:dream_carz/core/colors.dart';
// import 'package:dream_carz/core/constants.dart';
// import 'package:dream_carz/core/responsiveutils.dart';
// import 'package:dream_carz/data/booked_carmodel.dart';
// import 'package:dream_carz/domain/controllers/phonepey_controller.dart';
// import 'package:dream_carz/widgets/custom_snackbar.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'package:intl/intl.dart';

// import 'package:flutter/material.dart';
// import 'package:uuid/uuid.dart';


// class ScreenPaymentPage extends StatefulWidget {
//   final BookedCarmodel bookingData;
  
//   const ScreenPaymentPage({
//     super.key,
//     required this.bookingData,
//   });

//   @override
//   State<ScreenPaymentPage> createState() => _ScreenPaymentPageState();
// }

// class _ScreenPaymentPageState extends State<ScreenPaymentPage> {


//   String _formatDate(String dateTimeString) {
//     try {
//       DateTime dateTime = DateTime.parse(dateTimeString);
//       return DateFormat('dd MMM yyyy').format(dateTime);
//     } catch (e) {
//       return dateTimeString;
//     }
//   }

//   String _formatTime(String dateTimeString) {
//     try {
//       DateTime dateTime = DateTime.parse(dateTimeString);
//       return DateFormat('hh:mm a').format(dateTime);
//     } catch (e) {
//       return '';
//     }
//   }

//   String _formatAmount(String? amount) {
//     if (amount == null || amount.isEmpty) return '₹ 0.00';
//     try {
//       double value = double.parse(amount);
//       return '₹ ${value.toStringAsFixed(2)}';
//     } catch (e) {
//       return '₹ $amount';
//     }
//   }
//   bool _isProcessing=false;
//   String _paymentStatus='Ready for payment';
//   final PhonePeService _phonePeService= PhonePeService();
//   final Uuid _uuid=Uuid();
//   late String _flowId;
// @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _flowId=_uuid.v4();
//     _phonePeService.initSdk(flowid:_flowId);
//   }
//   Future<void>_startpayment()async{
// if (_isProcessing) return;
// setState(() {
//   _isProcessing=true;
//   _paymentStatus='Initiating payment....';
// });
// try {
//   final result=await _phonePeService.startTransaction(amount: 1, orderId:widget.bookingData.transactionId!, flowId:_flowId, context: context);


// } catch (error) { _handleError(error);
// }finally{
//   setState(() {
//     _isProcessing=false;
//   });
// }

//   }
//   void _handleError(Object error){
//   CustomSnackbar.show(context, message: 'Payment processing error. Please try again.', type:SnackbarType.error);
//   _phonePeService.handleError(error);
// }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Appcolors.kbackgroundcolor,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(
//             Icons.chevron_left,
//             size: ResponsiveUtils.wp(8),
//             color: Colors.black,
//           ),
//         ),
//         title: TextStyles.subheadline(
//           text: 'Payment',
//           color: const Color(0xFF1A365D),
//         ),
//         centerTitle: false,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//               child: Column(
//                 children: [
//                   // Booking Summary Card
//                   _buildBookingSummaryCard(),

//                   ResponsiveSizedBox.height20,

//                   // Delivery/Pickup Details Card
//                   widget.bookingData.fulfillment.toLowerCase() == 'delivery'
//                       ? _buildDeliveryDetailsCard()
//                       : _buildPickupDetailsCard(),

//                   ResponsiveSizedBox.height20,

//                   // Payment Amount Card
//                   _buildPaymentAmountCard(),
//                 ],
//               ),
//             ),
//           ),

//           // Pay Now Button
//           _buildPayNowButton(),
//         ],
//       ),
//     );
//   }

//   Widget _buildBookingSummaryCard() {
//     return Container(
//       padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadiusStyles.kradius15(),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withAlpha(20),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.event_note,
//                 color: Colors.red,
//                 size: ResponsiveUtils.sp(6),
//               ),
//               ResponsiveSizedBox.width10,
//               TextStyles.subheadline(
//                 text: 'Booking Details',
//                 color: Colors.black,
//               ),
//             ],
//           ),
//           ResponsiveSizedBox.height15,

//           // Booking Number
//           _buildInfoRow(
//             icon: Icons.confirmation_number_outlined,
//             label: 'Booking #',
//             value: widget.bookingData.bookingNumber,
//           ),
//           ResponsiveSizedBox.height15,

//           // Vehicle Model - You might need to get this from another API
//           _buildInfoRow(
//             icon: Icons.directions_car,
//             label: 'Vehicle',
//             value: 'Model ID: ${widget.bookingData.modelId}',
//           ),
//           ResponsiveSizedBox.height15,

//           // Duration
//           _buildInfoRow(
//             icon: Icons.access_time,
//             label: 'Duration',
//             value: widget.bookingData.duration ?? 'N/A',
//           ),
//           ResponsiveSizedBox.height15,

//           // Free Kilometers
//           _buildInfoRow(
//             icon: Icons.speed,
//             label: 'Free Kilometers',
//             value: '${widget.bookingData.freeKm ?? '0'} KM',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDeliveryDetailsCard() {
//     return Container(
//       padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadiusStyles.kradius15(),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withAlpha(20),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.local_shipping_outlined,
//                 color: Colors.red,
//                 size: ResponsiveUtils.sp(6),
//               ),
//               ResponsiveSizedBox.width10,
//               TextStyles.subheadline(
//                 text: 'Delivery Details',
//                 color: Colors.black,
//               ),
//             ],
//           ),
//           ResponsiveSizedBox.height15,

//           // From Date
//           _buildDateRow(
//             icon: Icons.calendar_today,
//             label: 'From',
//             date: _formatDate(widget.bookingData.bookingFrom),
//             time: _formatTime(widget.bookingData.bookingFrom),
//             isStart: true,
//           ),
//           ResponsiveSizedBox.height15,

//           // To Date
//           _buildDateRow(
//             icon: Icons.event,
//             label: 'To',
//             date: _formatDate(widget.bookingData.bookingTo),
//             time: _formatTime(widget.bookingData.bookingTo),
//             isStart: false,
//           ),
//           ResponsiveSizedBox.height15,

//           Divider(color: Colors.grey[300], thickness: 1),
//           ResponsiveSizedBox.height15,

//           // Address
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.home_outlined,
//                 color: Colors.grey[600],
//                 size: ResponsiveUtils.sp(5),
//               ),
//               ResponsiveSizedBox.width10,
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextStyles.body(
//                       text: 'Delivery Address',
//                       color: Colors.grey[600],
//                     ),
//                     ResponsiveSizedBox.height5,
//                     TextStyles.body(
//                       text: widget.bookingData.deliveryAddress ?? 'N/A',
//                       weight: FontWeight.w600,
//                     ),
//                     if (widget.bookingData.deliveryArea != null &&
//                         widget.bookingData.deliveryArea!.isNotEmpty)
//                       TextStyles.body(
//                         text: widget.bookingData.deliveryArea!,
//                         weight: FontWeight.w600,
//                       ),
//                     ResponsiveSizedBox.height10,
//                     Row(
//                       children: [
//                         if (widget.bookingData.deliveryContactName != null) ...[
//                           Icon(
//                             Icons.person_outline,
//                             size: ResponsiveUtils.sp(4),
//                             color: Colors.grey[600],
//                           ),
//                           ResponsiveSizedBox.width5,
//                           Flexible(
//                             child: TextStyles.caption(
//                               text: widget.bookingData.deliveryContactName!,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                         ],
//                         if (widget.bookingData.deliveryContactMobile != null) ...[
//                           ResponsiveSizedBox.width10,
//                           Icon(
//                             Icons.phone_outlined,
//                             size: ResponsiveUtils.sp(4),
//                             color: Colors.grey[600],
//                           ),
//                           ResponsiveSizedBox.width5,
//                           Flexible(
//                             child: TextStyles.caption(
//                               text: widget.bookingData.deliveryContactMobile!,
//                               color: Colors.grey[700],
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPickupDetailsCard() {
//     return Container(
//       padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadiusStyles.kradius15(),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withAlpha(20),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.store_outlined,
//                 color: Colors.red,
//                 size: ResponsiveUtils.sp(6),
//               ),
//               ResponsiveSizedBox.width10,
//               TextStyles.subheadline(
//                 text: 'Pickup Details',
//                 color: Colors.black,
//               ),
//             ],
//           ),
//           ResponsiveSizedBox.height15,

//           // Pickup Type Badge
//           Container(
//             padding: EdgeInsets.symmetric(
//               horizontal: ResponsiveUtils.wp(3),
//               vertical: ResponsiveUtils.hp(0.8),
//             ),
//             decoration: BoxDecoration(
//               color: Colors.blue.withAlpha(40),
//               borderRadius: BorderRadiusStyles.kradius10(),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(
//                   Icons.location_on,
//                   size: ResponsiveUtils.sp(4),
//                   color: Colors.blue,
//                 ),
//                 ResponsiveSizedBox.width5,
//                 TextStyles.caption(
//                   text: 'Self Pickup from Branch',
//                   color: Colors.blue,
//                   weight: FontWeight.w600,
//                 ),
//               ],
//             ),
//           ),
//           ResponsiveSizedBox.height15,

//           // From Date
//           _buildDateRow(
//             icon: Icons.calendar_today,
//             label: 'Pickup Date',
//             date: _formatDate(widget.bookingData.bookingFrom),
//             time: _formatTime(widget.bookingData.bookingFrom),
//             isStart: true,
//           ),
//           ResponsiveSizedBox.height15,

//           // To Date
//           _buildDateRow(
//             icon: Icons.event,
//             label: 'Return Date',
//             date: _formatDate(widget.bookingData.bookingTo),
//             time: _formatTime(widget.bookingData.bookingTo),
//             isStart: false,
//           ),
//           ResponsiveSizedBox.height15,

//           // Branch Info
//           Container(
//             padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
//             decoration: BoxDecoration(
//               color: Colors.grey[50],
//               borderRadius: BorderRadiusStyles.kradius10(),
//               border: Border.all(color: Colors.grey[300]!),
//             ),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.info_outline,
//                   size: ResponsiveUtils.sp(5),
//                   color: Colors.blue,
//                 ),
//                 ResponsiveSizedBox.width10,
//                 Expanded(
//                   child: TextStyles.caption(
//                     text: 'Please visit our branch to collect your vehicle at the scheduled time',
//                     color: Colors.grey[700],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

// Widget _buildPaymentAmountCard() {
//   return Container(
//     padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//     decoration: BoxDecoration(
//       gradient: const LinearGradient(
//         colors: [
//           Color.fromARGB(255, 143, 97, 199), // Vibrant purple
//           Color.fromARGB(255, 138, 74, 145), // Soft lilac-pink blend
//         ],
//         begin: Alignment.topLeft,
//         end: Alignment.bottomRight,
//       ),
//       borderRadius: BorderRadiusStyles.kradius15(),

//     ),
//     child: Column(
//       children: [
//         TextStyles.body(
//           text: 'Total Amount',
//           color: Colors.white.withAlpha(220),
//         ),
//         ResponsiveSizedBox.height10,
//         TextStyles.headline(
//           text: _formatAmount(widget.bookingData.grandTotal),
//           color: Colors.white,
//           weight: FontWeight.bold,
//         ),
//         ResponsiveSizedBox.height15,

//         Container(
//           padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.15),
//             borderRadius: BorderRadiusStyles.kradius10(),
//             border: Border.all(
//               color: Colors.white.withOpacity(0.25),
//               width: 1,
//             ),
//           ),
//           child: Column(
//             children: [
//               _buildAmountRow(
//                 'Base Fare',
//                 _formatAmount(widget.bookingData.baseFare),
//                 isWhite: true,
//               ),
//               if (widget.bookingData.discount != null &&
//                   widget.bookingData.discount != '0.00') ...[
//                 ResponsiveSizedBox.height10,
//                 _buildAmountRow(
//                   'Discount',
//                   '- ${_formatAmount(widget.bookingData.discount)}',
//                   isWhite: true,
//                 ),
//               ],
//               if (widget.bookingData.deliveryCharges != null &&
//                   widget.bookingData.deliveryCharges != '0.00') ...[
//                 ResponsiveSizedBox.height10,
//                 _buildAmountRow(
//                   'Delivery Charges',
//                   _formatAmount(widget.bookingData.deliveryCharges),
//                   isWhite: true,
//                 ),
//               ],
//               ResponsiveSizedBox.height10,
//               _buildAmountRow(
//                 'GST',
//                 _formatAmount(widget.bookingData.gst),
//                 isWhite: true,
//               ),
//               ResponsiveSizedBox.height10,
//               _buildAmountRow(
//                 'Security Deposit',
//                 _formatAmount(widget.bookingData.securityDeposit),
//                 isWhite: true,
//               ),
//             ],
//           ),
//         ),
//         ResponsiveSizedBox.height10,
//         TextStyles.caption(
//           text: '*incl. of all taxes',
//           color: Colors.white.withAlpha(200),
//         ),
//       ],
//     ),
//   );
// }


//   Widget _buildInfoRow({
//     required IconData icon,
//     required String label,
//     required String value,
//   }) {
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: Colors.grey[600],
//           size: ResponsiveUtils.sp(5),
//         ),
//         ResponsiveSizedBox.width10,
//         Expanded(
//           child: TextStyles.body(
//             text: label,
//             color: Colors.grey[600],
//           ),
//         ),
//         Flexible(
//           child: TextStyles.body(
//             text: value,
//             weight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildDateRow({
//     required IconData icon,
//     required String label,
//     required String date,
//     required String time,
//     required bool isStart,
//   }) {
//     return Row(
//       children: [
//         Container(
//           padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
//           decoration: BoxDecoration(
//             color: isStart ? Colors.green.withAlpha(40) : Colors.red.withAlpha(40),
//             borderRadius: BorderRadiusStyles.kradius10(),
//           ),
//           child: Icon(
//             icon,
//             color: isStart ? Colors.green : Colors.red,
//             size: ResponsiveUtils.sp(5),
//           ),
//         ),
//         ResponsiveSizedBox.width10,
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextStyles.caption(
//                 text: label,
//                 color: Colors.grey[600],
//               ),
//               ResponsiveSizedBox.height5,
//               TextStyles.body(
//                 text: date,
//                 weight: FontWeight.w600,
//               ),
//             ],
//           ),
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: ResponsiveUtils.wp(3),
//             vertical: ResponsiveUtils.hp(0.6),
//           ),
//           decoration: BoxDecoration(
//             color: Colors.grey[100],
//             borderRadius: BorderRadiusStyles.kradius10(),
//           ),
//           child: TextStyles.caption(
//             text: time,
//             weight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildAmountRow(String label, String amount, {bool isWhite = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         TextStyles.caption(
//           text: label,
//           color: isWhite ? Colors.white : Colors.grey[600],
//         ),
//         TextStyles.caption(
//           text: amount,
//           color: isWhite ? Colors.white : Colors.black,
//           weight: FontWeight.w600,
//         ),
//       ],
//     );
//   }

//   Widget _buildPayNowButton() {
//     return Container(
//       width: double.infinity,
//       margin: EdgeInsets.all(ResponsiveUtils.wp(6)),
//       child: ElevatedButton(
//         onPressed: _isProcessing?null:_startpayment,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.purple,
//           padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(1.8)),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadiusStyles.kradius10(),
//           ),
//           elevation: 0,
//         ),
//         child:
//         _isProcessing?Row(mainAxisAlignment: MainAxisAlignment.center,
//         children: [SpinKitCircle(size: 20,color: Appcolors.kwhitecolor,),ResponsiveSizedBox.width10,TextStyles.body(text:  'Processing',color: Appcolors.kwhitecolor)],):
//          TextStyles.body(
//            text: 'Pay Now  ${_formatAmount(widget.bookingData.grandTotal)}',
//            color: Colors.white,
//            weight: FontWeight.bold,
//          ),
//       ),
//     );
//   }
// }