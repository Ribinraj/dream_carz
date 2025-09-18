// imports
import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

class ScreenCheckoutpage extends StatefulWidget {
  const ScreenCheckoutpage({super.key});

  @override
  State<ScreenCheckoutpage> createState() => _ScreenBookingdetailpageState();
}

class _ScreenBookingdetailpageState extends State<ScreenCheckoutpage> {
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
          text: 'Review & Checkout',
          color: const Color(0xFF1A365D),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
              child: Column(
                children: [
                  // Car Details Card
                  _buildCarDetailsCard(),

                  ResponsiveSizedBox.height20,

                  // Price Details Card
                  _buildPriceDetailsCard(),
                ],
              ),
            ),
          ),

          // Proceed Button
          _buildProceedButton(),
        ],
      ),
    );
  }

  Widget _buildCarDetailsCard() {
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
        children: [
          Row(
            children: [
              Container(
                width: ResponsiveUtils.wp(20),
                height: ResponsiveUtils.hp(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusStyles.kradius10(),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadiusStyles.kradius10(),
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.transparent,
                      BlendMode.srcOver,
                    ),

                    child: Image.network(
                      'https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&w=2070&q=80',

                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(
                          child: SpinKitFadingCircle(
                            size: ResponsiveUtils.wp(10),
                            color: Appcolors.kgreyColor,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: Icon(
                            Icons.directions_car,
                            size: ResponsiveUtils.sp(8),
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              ResponsiveSizedBox.width20,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyles.subheadline(
                      text: 'KUV100 K4',
                      color: Colors.black,
                    ),
                    ResponsiveSizedBox.height5,
                    Row(
                      children: [
                        TextStyles.medium(
                          text: 'Free Km : ',
                          color: Colors.grey[600],
                        ),
                        TextStyles.medium(
                          text: '105.0',
                          color: Colors.red,
                          weight: FontWeight.w600,
                        ),
                        ResponsiveSizedBox.width20,
                        TextStyles.medium(
                          text: 'Extra : ',
                          color: Colors.grey[600],
                        ),
                        TextStyles.medium(
                          text: '₹8.0/Km',
                          color: Colors.red,
                          weight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ResponsiveSizedBox.height15,

          // Car Features
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildFeatureItem(Appconstants.seatIcon, '6 Seater'),
              _buildFeatureItem(Appconstants.gearIcon, 'Manual'),
              _buildFeatureItem(Appconstants.petrolIcon, 'Diesel'),
            ],
          ),
          ResponsiveSizedBox.height20,

          // Booking Details
          _buildBookingDetailRow('City', 'Mysuru'),
          ResponsiveSizedBox.height10,
          _buildBookingDetailRow('Start Date', '17 Sep 2025 07:00 PM'),
          ResponsiveSizedBox.height10,
          _buildBookingDetailRow('End Date', '18 Sep 2025 01:00 PM'),
          ResponsiveSizedBox.height10,
          _buildBookingDetailRow('Trip Duration', '18.0 hrs'),
          ResponsiveSizedBox.height10,
          Row(
            children: [
              TextStyles.body(text: 'Price Plan', color: Colors.grey[600]),
              ResponsiveSizedBox.width5,
              const Icon(Icons.info_outline, color: Colors.red, size: 16),
              const Spacer(),
              TextStyles.body(text: '140 KM', weight: FontWeight.w600),
            ],
          ),
          ResponsiveSizedBox.height5,
          Row(
            children: [
              TextStyles.caption(text: '(Without Fuel)', color: Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String svgAssetPath, String text) {
    return Row(
      children: [
        SvgPicture.asset(
          svgAssetPath,
          width: ResponsiveUtils.sp(5),
          height: ResponsiveUtils.sp(5),
          colorFilter: const ColorFilter.mode(
            Colors.red, // make SVG red
            BlendMode.srcIn,
          ),
        ),
        ResponsiveSizedBox.width5,
        TextStyles.medium(text: text, color: Colors.grey[700]),
      ],
    );
  }

  Widget _buildBookingDetailRow(String label, String value) {
    return Row(
      children: [
        TextStyles.body(text: label, color: Colors.grey[600]),
        const Spacer(),
        TextStyles.body(text: value, weight: FontWeight.w600),
      ],
    );
  }

  Widget _buildPriceDetailsCard() {
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
          TextStyles.subheadline(text: 'Price Details', color: Colors.black),
          ResponsiveSizedBox.height20,

          _buildPriceRow('Total Tariff', '₹ 1125.0', hasInfo: true),
          ResponsiveSizedBox.height15,

          Container(height: 1, color: Colors.grey[300]),
          ResponsiveSizedBox.height15,

          _buildPriceRow('Total Tax', '₹ 315.0', hasInfo: true),
          ResponsiveSizedBox.height15,

          _buildPriceRow('Delivery Charge', '₹ 0.0'),
          ResponsiveSizedBox.height15,

          _buildPriceRow('Security Deposit', '₹ 200.0'),
          ResponsiveSizedBox.height10,
          Container(height: 1, color: Colors.grey[300]),
          ResponsiveSizedBox.height10,
          _buildPriceRow(
            'Payable Amount',
            '₹ 258.0',
            color: Appcolors.kgreencolor,
          ),
          ResponsiveSizedBox.height10,
          Container(height: 1, color: Colors.grey[300]),
          ResponsiveSizedBox.height10,
          Row(
            children: [
              Spacer(),
              TextStyles.body(
                text: '*incl. of taxes',
                color: Appcolors.kgreencolor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(
    String label,
    String amount, {
    bool hasInfo = false,
    Color color = Appcolors.kgreyColor,
  }) {
    return Row(
      children: [
        TextStyles.body(text: label, color: Colors.grey[600]),
        if (hasInfo) ...[
          ResponsiveSizedBox.width5,
          const Icon(Icons.info_outline, color: Colors.red, size: 16),
        ],
        const Spacer(),
        TextStyles.body(text: amount, weight: FontWeight.w600, color: color),
      ],
    );
  }

  Widget _buildProceedButton() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(ResponsiveUtils.wp(4)),
      child: ElevatedButton(
        onPressed: () {
          // Handle proceed action: you can pass selectedPickupLocation or selectedDeliveryAddress
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(1.6)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyles.kradius10(),
          ),
          elevation: 0,
        ),
        child: TextStyles.body(
          text: 'Checkout',
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
