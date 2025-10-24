

import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/presentation/screens/screen_homepage/screen_homepage.dart';

import 'package:dream_carz/presentation/screens/screen_mydocuments/screen_mydocuments.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatefulWidget {
  final String bookingId;
  final double amount;
  final String transactionId;


  const PaymentSuccessPage({
    super.key,
    required this.amount,
    required this.transactionId,
    required this.bookingId,
 
  });

  @override
  PaymentSuccessPageState createState() => PaymentSuccessPageState();
}

class PaymentSuccessPageState extends State<PaymentSuccessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get formattedAmount => '₹ ${widget.amount.toStringAsFixed(2)}';

  Future<bool> _onWillPop() async {
    return await _showWarningDialog() ?? false;
  }

  Future<bool?> _showWarningDialog() async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700, size: 28),
              const SizedBox(width: 8),
              const Text('Document Required'),
            ],
          ),
          content: const Text(
            'Without uploading your document, your order will not be confirmed. Are you sure you want to leave?',
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Stay & Upload',
                style: TextStyle(
                  color: Colors.green.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(
                'Leave Anyway',
                style: TextStyle(color: Colors.red.shade600),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.green.shade50, Colors.teal.shade50],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: Image.asset(
                        'assets/images/transaction-approved-smartphone.png',
                        height: ResponsiveUtils.hp(25),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Payment Successful!',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'Thank you for your booking. Your order has been processed successfully.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                    ),

                    const SizedBox(height: 28),

                    _buildProgressIndicator(),

                    const SizedBox(height: 28),

                    _buildTransactionDetails(),

                    const SizedBox(height: 24),

                    _buildButtons(context),

          
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 900),
      builder: (context, value, _) {
        return Column(
          children: [
            LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green.shade500),
              minHeight: 3,
            ),
            const SizedBox(height: 8),
            Text(
              value < 1.0 ? 'Finalizing order...' : 'Done',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTransactionDetails() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow('Amount Paid', formattedAmount),
          const SizedBox(height: 12),
          _buildDetailRow('Transaction ID', widget.transactionId),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        // ElevatedButton(
        //   onPressed: () {
        //     // Navigate to bookings page with replace transition
        //     CustomNavigation.pushReplaceWithTransition(
        //       context,
        //       ScreenMybookingpage(),
        //     );
        //   },
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.green.shade600.withOpacity(.9),
        //     foregroundColor: Colors.white,
        //     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(8),
        //     ),
        //     minimumSize: Size(ResponsiveUtils.wp(60), 48),
        //   ),
        //   child: const Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text('View Order Details'),
        //       SizedBox(width: 8),
        //       Icon(Icons.arrow_forward),
        //     ],
        //   ),
        // ),

        const SizedBox(height: 20),

        // Important notice for document upload
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.orange.shade700, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Upload document to confirm your order',
                  style: TextStyle(
                    color: Colors.orange.shade900,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        OutlinedButton(
          onPressed: () {
            CustomNavigation.pushReplaceWithTransition(
              context,
              MyDocumentsPage(bookingId: widget.bookingId),
            );
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(color: Appcolors.kblackcolor.withOpacity(0.6)),
            minimumSize: Size(ResponsiveUtils.wp(60), 44),
          ),
          child: Text(
            'Upload Document',
            style: TextStyle(
              color: Appcolors.kblackcolor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),

        const SizedBox(height: 12),

        // Optional: share receipt button (placeholder)
        TextButton.icon(
          onPressed: () async {
            final shouldLeave = await _showWarningDialog();
            if (shouldLeave == true) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => ScreenHomepage()),
                (route) => false,
              );
            }
          },
          icon: const Icon(Icons.home_outlined, size: 18),
          label: const Text('Back to Home'),
        ),
      ],
    );
  }


  // Widget _buildRawResponseBox() {
  //   final pretty = const JsonEncoder.withIndent(
  //     '  ',
  //   ).convert(widget.rawResponse);
  //   return Container(
  //     margin: const EdgeInsets.only(top: 12),
  //     padding: const EdgeInsets.all(12),
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       color: Colors.grey.shade50,
  //       borderRadius: BorderRadius.circular(8),
  //       border: Border.all(color: Colors.grey.shade300),
  //     ),
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Text(
  //         pretty,
  //         style: const TextStyle(
  //           fontFamily: 'monospace',
  //           fontSize: 12,
  //           color: Colors.black87,
  //         ),
  //       ),
  //     ),
  //   );
  }
