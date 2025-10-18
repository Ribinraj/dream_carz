// import 'package:dream_carz/core/colors.dart';
// import 'package:dream_carz/core/constants.dart';
// import 'package:dream_carz/core/responsiveutils.dart';
// import 'package:flutter/material.dart';


// class PaymentFailurePage extends StatefulWidget {
//   final String amount;
//   final String transactionId;
//   const PaymentFailurePage({super.key, required this.amount, required this.transactionId});

//   @override
//   PaymentFailurePageState createState() => PaymentFailurePageState();
// }

// class PaymentFailurePageState extends State<PaymentFailurePage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _shakeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );

//     // _shakeAnimation = Tween<double>(begin: -10, end: 10).animate(
//     //   CurvedAnimation(
//     //     parent: _controller,
//     //     curve: Curves.elasticIn,
//     //   ),
//     // )..addStatusListener((status) {
//     //     if (status == AnimationStatus.completed) {
//     //       _controller.reverse();
//     //     }
//     //   });

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [
//               Colors.red.shade50,
//               Colors.white,
//             ],
//           ),
//         ),
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   //_buildErrorIcon(),
//                   Image.asset('assets/images/payment_failiure.png',
//                       height: ResponsiveUtils.hp(30)),
//                   ResponsiveSizedBox.height30,
//                   Text(
//                     'Payment Failed',
//                     style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                           color: Colors.red.shade700,
//                           fontWeight: FontWeight.bold,
//                         ),
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'We couldn\'t process your payment',
//                     style: TextStyle(
//                       fontSize: 18,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                   const SizedBox(height: 32),
//                   _buildErrorCard(),
//                   const SizedBox(height: 32),
//                   const SizedBox(height: 32),
//                   _buildButtons(context),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorIcon() {
//     return AnimatedBuilder(
//       animation: _shakeAnimation,
//       builder: (context, child) {
//         return Transform.translate(
//           offset: Offset(_shakeAnimation.value, 0),
//           child: Container(
//             width: 100,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.red.shade100,
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.close,
//               size: 50,
//               color: Colors.red.shade700,
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildErrorCard() {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.red.shade200),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.red.shade100,
//             blurRadius: 10,
//             offset: const Offset(0, 5),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           // _buildErrorDetailRow('Error Code', 'text any error code'),
//           // const Divider(height: 24),
//           _buildErrorDetailRow('Transaction ID', widget.transactionId),
//           const Divider(height: 24),
//           _buildErrorDetailRow('Amount', widget.amount),
//         ],
//       ),
//     );
//   }

//   Widget _buildErrorDetailRow(String label, String value) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 14,
//             color: Colors.grey.shade600,
//           ),
//         ),
//         Text(
//           value,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildButtons(BuildContext context) {
//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Appcolors.kprimarycolor,
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//             shape: const RoundedRectangleBorder(
//                 // borderRadius: BorderRadius.circular(8),
//                 ),
//           ),
//           child: const Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Try Again'),
//               SizedBox(width: 8),
//               Icon(Icons.refresh),
//             ],
//           ),
//         ),
//         const SizedBox(height: 20),
//         OutlinedButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           style: OutlinedButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//             shape: const RoundedRectangleBorder(
//                 // borderRadius: BorderRadius.circular(8),
//                 ),
//           ),
//           child: const Text(
//             'Back to Payment',
//             style: TextStyle(
//                 color:Appcolors.kblackcolor, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
// }
// payment_failure_page.dart
// payment_failure_page.dart
import 'dart:convert';

import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/material.dart';

class PaymentFailurePage extends StatefulWidget {
  final String reason;
  final String? transactionId;
  final double? amount;
  final Map<String, dynamic>? rawResponse;

  /// [reason] - user-facing failure message (required)
  /// [transactionId] - optional transaction/order id
  /// [amount] - optional amount (in INR)
  /// [rawResponse] - optional raw response for debugging (shown collapsed)
  const PaymentFailurePage({
    super.key,
    required this.reason,
    this.transactionId,
    this.amount,
    this.rawResponse,
  });

  @override
  PaymentFailurePageState createState() => PaymentFailurePageState();
}

class PaymentFailurePageState extends State<PaymentFailurePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;
  bool _showRaw = false;

  @override
  void initState() {
    super.initState();

    // AnimationController produces values in [0,1] so it's safe to feed into TweenSequence.
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // TweenSequence animated directly by controller (no overshooting curve)
    _shakeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -12.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -12.0, end: 12.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 12.0, end: -6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: 0.0), weight: 1),
    ]).animate(_controller);

    // Play shake once on enter, then stop.
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Call this to signal retry to the caller:
  /// Navigator.push(...).then((value) { if (value == true) retry(); });
  void _onTryAgain() {
    Navigator.of(context).pop(true);
  }

  void _onBackToPayment() {
    Navigator.of(context).pop(false);
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
                  // Animated failure image / icon
                  AnimatedBuilder(
                    animation: _shakeAnimation,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_shakeAnimation.value, 0),
                        child: child,
                      );
                    },
                    child: Image.asset(
                      'assets/images/payment_failiure.png',
                      height: ResponsiveUtils.hp(30),
                      fit: BoxFit.contain,
                    ),
                  ),

                  ResponsiveSizedBox.height30,

                  Text(
                    'Payment Failed',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      widget.reason,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 28),

                  _buildErrorCard(),

                  const SizedBox(height: 28),

                  _buildButtons(context),

                  if (widget.rawResponse != null) ...[
                    const SizedBox(height: 20),
                    _buildRawToggle(),
                    if (_showRaw) _buildRawResponseBox(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorCard() {
    final transactionText = widget.transactionId ?? '—';
    final amountText = widget.amount != null
        ? '₹ ${widget.amount!.toStringAsFixed(2)}'
        : '—';

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
          _buildErrorDetailRow('Transaction ID', transactionText),
          const Divider(height: 24),
          _buildErrorDetailRow('Amount', amountText),
          const SizedBox(height: 8),
          _buildErrorDetailRow('Status', 'Failed'),
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
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: _onTryAgain,
          icon: const Icon(Icons.refresh, size: 18),
          label: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Text('Try Again', style: TextStyle(fontSize: 16)),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Appcolors.kprimarycolor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: Size(ResponsiveUtils.wp(60), 48),
          ),
        ),
        const SizedBox(height: 14),
        OutlinedButton(
          onPressed: _onBackToPayment,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            side: BorderSide(color: Appcolors.kblackcolor.withOpacity(0.6)),
            minimumSize: Size(ResponsiveUtils.wp(60), 44),
          ),
          child: Text(
            'Back to Payment',
            style: TextStyle(
              color: Appcolors.kblackcolor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRawToggle() {
    return GestureDetector(
      onTap: () => setState(() => _showRaw = !_showRaw),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _showRaw ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: Colors.grey.shade700,
          ),
          const SizedBox(width: 6),
          Text(
            _showRaw ? 'Hide details' : 'Show details',
            style: TextStyle(color: Colors.grey.shade700),
          ),
        ],
      ),
    );
  }

  Widget _buildRawResponseBox() {
    final pretty = const JsonEncoder.withIndent('  ').convert(widget.rawResponse);
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          pretty,
          style: const TextStyle(fontFamily: 'monospace', fontSize: 12, color: Colors.black87),
        ),
      ),
    );
  }
}
