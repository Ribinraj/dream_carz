import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/material.dart';


class PaymentFailurePage extends StatefulWidget {
  final String amount;
  final String transactionId;
  const PaymentFailurePage({super.key, required this.amount, required this.transactionId});

  @override
  PaymentFailurePageState createState() => PaymentFailurePageState();
}

class PaymentFailurePageState extends State<PaymentFailurePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // _shakeAnimation = Tween<double>(begin: -10, end: 10).animate(
    //   CurvedAnimation(
    //     parent: _controller,
    //     curve: Curves.elasticIn,
    //   ),
    // )..addStatusListener((status) {
    //     if (status == AnimationStatus.completed) {
    //       _controller.reverse();
    //     }
    //   });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.red.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //_buildErrorIcon(),
                  Image.asset('assets/images/payment_failiure.png',
                      height: ResponsiveUtils.hp(30)),
                  ResponsiveSizedBox.height30,
                  Text(
                    'Payment Failed',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'We couldn\'t process your payment',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 32),
                  _buildErrorCard(),
                  const SizedBox(height: 32),
                  const SizedBox(height: 32),
                  _buildButtons(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorIcon() {
    return AnimatedBuilder(
      animation: _shakeAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_shakeAnimation.value, 0),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.red.shade100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              size: 50,
              color: Colors.red.shade700,
            ),
          ),
        );
      },
    );
  }

  Widget _buildErrorCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.red.shade100,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // _buildErrorDetailRow('Error Code', 'text any error code'),
          // const Divider(height: 24),
          _buildErrorDetailRow('Transaction ID', widget.transactionId),
          const Divider(height: 24),
          _buildErrorDetailRow('Amount', widget.amount),
        ],
      ),
    );
  }

  Widget _buildErrorDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Appcolors.kprimarycolor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: const RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(8),
                ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Try Again'),
              SizedBox(width: 8),
              Icon(Icons.refresh),
            ],
          ),
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            shape: const RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(8),
                ),
          ),
          child: const Text(
            'Back to Payment',
            style: TextStyle(
                color:Appcolors.kblackcolor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
