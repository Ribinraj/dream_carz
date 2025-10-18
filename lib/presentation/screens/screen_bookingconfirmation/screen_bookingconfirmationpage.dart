import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/presentation/screens/screen_homepage/screen_homepage.dart';
import 'package:dream_carz/presentation/screens/screen_mybookingspage/screen_mybookingpage.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';

class OrderConfirmedPage extends StatefulWidget {
  const OrderConfirmedPage({super.key});

  @override
  State<OrderConfirmedPage> createState() => _OrderConfirmedPageState();
}

class _OrderConfirmedPageState extends State<OrderConfirmedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _navigateToHome();
        return false;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade50, Colors.white, Colors.green.shade50],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Success Animation Icon
                      ScaleTransition(
                        scale: _scaleAnimation,
                        child: Container(
                          width: ResponsiveUtils.wp(40),
                          height: ResponsiveUtils.wp(40),
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_circle,
                            size: ResponsiveUtils.wp(30),
                            color: Colors.green.shade600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Main Heading
                      Text(
                        'Order Confirmed!',
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 12),

                      // Subheading
                      Text(
                        'Thank you for uploading your documents',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 32),

                      // Info Card
                      _buildInfoCard(),

                      const SizedBox(height: 24),

                      // Verification Timeline
                      _buildVerificationTimeline(),

                      const SizedBox(height: 32),

                      // Booking Details
                      // _buildBookingDetails(),
                      const SizedBox(height: 32),

                      // Action Buttons
                      _buildActionButtons(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade200,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.verified_user, size: 48, color: Colors.white),
          const SizedBox(height: 12),
          Text(
            'Document Verification in Progress',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Our team will verify your documents and contact you shortly',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.9),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationTimeline() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What happens next?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
          ),
          const SizedBox(height: 16),
          _buildTimelineItem(
            Icons.upload_file,
            'Documents Uploaded',
            'Successfully received',
            true,
            Colors.green,
          ),
          _buildTimelineItem(
            Icons.search,
            'Verification',
            'Under review (24-48 hours)',
            false,
            Colors.orange,
          ),
          _buildTimelineItem(
            Icons.phone_in_talk,
            'Contact',
            'We will reach out to you',
            false,
            Colors.blue,
          ),
          _buildTimelineItem(
            Icons.car_rental,
            'Ready to Go',
            'Your booking is ready',
            false,
            Colors.grey,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
    IconData icon,
    String title,
    String subtitle,
    bool isCompleted,
    Color color, {
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isCompleted ? color : color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isCompleted ? Icons.check : icon,
                color: isCompleted ? Colors.white : color,
                size: 20,
              ),
            ),
            if (!isLast)
              Container(width: 2, height: 40, color: Colors.grey.shade300),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Widget _buildBookingDetails() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.grey.shade50,
  //       borderRadius: BorderRadius.circular(12),
  //       border: Border.all(color: Colors.grey.shade200),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           'Booking Reference',
  //           style: TextStyle(
  //             fontSize: 14,
  //             color: Colors.grey.shade600,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //         const SizedBox(height: 8),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Expanded(
  //               child: Text(
  //                 'Booking ID: ${widget.bookingId}',
  //                 style: TextStyle(
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.bold,
  //                   color: Colors.grey.shade800,
  //                 ),
  //               ),
  //             ),
  //             Icon(Icons.copy, size: 18, color: Colors.grey.shade600),
  //           ],
  //         ),
  //         const SizedBox(height: 12),
  //         Divider(color: Colors.grey.shade300),
  //         const SizedBox(height: 12),
  //         Text(
  //           'Transaction ID: ${widget.transactionId}',
  //           style: TextStyle(
  //             fontSize: 13,
  //             color: Colors.grey.shade600,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: () {
            CustomNavigation.pushReplaceWithTransition(
              context,
              ScreenMybookingpage(),
            );
          },
          icon: const Icon(Icons.receipt_long),
          label: const Text('View My Bookings'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: Size(ResponsiveUtils.wp(70), 52),
            elevation: 3,
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: _navigateToHome,
          icon: const Icon(Icons.home_outlined),
          label: const Text('Back to Home'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: BorderSide(color: Appcolors.kblackcolor.withOpacity(0.3)),
            minimumSize: Size(ResponsiveUtils.wp(70), 50),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'We\'ll notify you once verification is complete',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void _navigateToHome() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => ScreenHomepage()),
      (route) => false,
    );
  }
}
