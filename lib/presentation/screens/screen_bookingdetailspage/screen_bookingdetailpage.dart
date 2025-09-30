// imports
import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/data/cars_model.dart';
import 'package:dream_carz/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:dream_carz/presentation/screens/screen_bookingdetailspage/widgets/locationselection_widget.dart';
import 'package:dream_carz/presentation/screens/screen_checkoutpage/screen_checkoutpage.dart';
import 'package:dream_carz/presentation/screens/screen_loginpage.dart/screen_loginpage.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenBookingdetailpage extends StatefulWidget {
  final DateTime pickupDate;
  final TimeOfDay pickupTime;
  final DateTime dropDate;
  final TimeOfDay dropTime;
  final CarsModel car;
  const ScreenBookingdetailpage({
    super.key,
    required this.car,
    required this.pickupDate,
    required this.pickupTime,
    required this.dropDate,
    required this.dropTime,
  });

  @override
  State<ScreenBookingdetailpage> createState() =>
      _ScreenBookingdetailpageState();
}

class _ScreenBookingdetailpageState extends State<ScreenBookingdetailpage> {
  bool isDelivery = true;
  final TextEditingController locationController = TextEditingController();
  final TextEditingController couponController = TextEditingController();

  // NEW: hardcoded pickup locations (for Self-Pickup)
  final List<String> pickupLocations = [
    'ABC Depot - Anna Nagar',
    'Central Hub - T Nagar',
    'Airport Pickup Point',
    'Railway Station Stand',
  ];
  String? selectedPickupLocation;

  // For storing selected delivery coordinates & address
  double? selectedDeliveryLat;
  double? selectedDeliveryLng;
  String? selectedDeliveryAddress;
  Future<bool> _checkTokenExists() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('USER_TOKEN') ?? '';
    return token.isNotEmpty;
  }

  // Handle checkout navigation with token check
  Future<void> _handleCheckoutNavigation(BuildContext context) async {
    // Check if token exists
    bool hasToken = await _checkTokenExists();

    if (!hasToken) {
      // No token, navigate to login
      CustomNavigation.pushWithTransition(
        context,
        LoginScreen(), // Replace with your actual login screen
      );
      return;
    }

    // Token exists, fetch profile and validate
    context.read<FetchProfileBloc>().add(FetchProfileInitialEvent());

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // Use a one-time listener
    context
        .read<FetchProfileBloc>()
        .stream
        .firstWhere((state) {
          return state is FetchProfileSuccessState ||
              state is FetchProfileErrorState;
        })
        .then((state) {
          // Check if widget is still mounted
          if (!context.mounted) return;

          // Close loading dialog
          Navigator.pop(context);

          if (state is FetchProfileErrorState) {
            // Check if token expired
            if (state.message.toLowerCase().contains('expired') ||
                state.message == 'expiredtoken') {
              // Token expired, navigate to login
              CustomNavigation.pushWithTransition(context, LoginScreen());
            } else {
              CustomNavigation.pushWithTransition(
                context,
                ScreenCheckoutpage(),
              );
            }
          }
        })
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () {
            // Handle timeout
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Request timeout. Please try again.'),
                ),
              );
            }
          },
        );
  }

  @override
  void initState() {
    super.initState();
    // default selected pickup location (optional)
    selectedPickupLocation = pickupLocations.first;
    locationController.text = ''; // will show selected place/address
  }

  // Combine a DateTime (date) and TimeOfDay (time) into a single DateTime
  DateTime _combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  // Build a nicely formatted trip duration like "1 day 2 hrs 30 mins"
  String _formatTripDuration() {
    final start = _combineDateAndTime(widget.pickupDate, widget.pickupTime);
    final end = _combineDateAndTime(widget.dropDate, widget.dropTime);

    // If end is before start, clamp to zero (or you could swap, depending on your UX)
    final diff = end.isAfter(start) ? end.difference(start) : Duration.zero;

    final days = diff.inDays;
    final hours = diff.inHours.remainder(24);
    final mins = diff.inMinutes.remainder(60);

    final parts = <String>[];
    if (days > 0) parts.add('$days ${days == 1 ? "day" : "days"}');
    if (hours > 0) parts.add('$hours ${hours == 1 ? "hr" : "hrs"}');
    if (mins > 0 || parts.isEmpty)
      parts.add('$mins ${mins == 1 ? "min" : "mins"}');

    return parts.join(' ');
  }

  String _formatTimeOfDay(TimeOfDay t) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);
    return DateFormat('h:mm a').format(dt);
  }

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
          text: 'Booking Summary',
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

                  // Fulfillment Details Card - MODIFIED
                  _buildFulfillmentDetailsCard(),
                  ResponsiveSizedBox.height20,

                  // Coupon Code Card
                  _buildCouponCard(),
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
                      widget.car.image!,

                      fit: BoxFit.contain,
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
                      text: widget.car.modelName,
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
                          text: (widget.car.freeKms ?? 0).toString(),
                          color: Colors.red,
                          weight: FontWeight.w600,
                        ),
                        ResponsiveSizedBox.width20,
                        TextStyles.medium(
                          text: 'Extra : ',
                          color: Colors.grey[600],
                        ),
                        TextStyles.medium(
                          text:
                              '₹ ${(widget.car.additionalPerKm ?? 0).toStringAsFixed(1)}/Km',
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
              _buildFeatureItem(
                Appconstants.seatIcon,
                '${widget.car.seater ?? 0} Seater',
              ),
              _buildFeatureItem(
                Appconstants.gearIcon,
                widget.car.transmission ?? 'Unknown',
              ),
              _buildFeatureItem(
                Appconstants.petrolIcon,
                widget.car.fuelType ?? 'Unknown',
              ),
            ],
          ),
          ResponsiveSizedBox.height20,

          // Booking Details
          _buildBookingDetailRow(
            'Start Date',
            DateFormat('dd MMM yyyy').format(widget.pickupDate) +
                '  ' +
                _formatTimeOfDay(widget.pickupTime),
          ),
          ResponsiveSizedBox.height10,
          _buildBookingDetailRow(
            'End Date',
            DateFormat('dd MMM yyyy').format(widget.dropDate) +
                '  ' +
                _formatTimeOfDay(widget.dropTime),
          ),
          ResponsiveSizedBox.height10,
          _buildBookingDetailRow('Trip Duration', _formatTripDuration()),
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

  // ===================== NEW/CHANGED Fulfillment Card =====================
  Widget _buildFulfillmentDetailsCard() {
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
          TextStyles.subheadline(
            text: 'Fulfillment Details',
            color: Colors.black,
          ),
          ResponsiveSizedBox.height20,

          // Selection row - we show a circle and fill inner circle when selected
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => isDelivery = false),
                child: Row(
                  children: [
                    // Outer circle
                    Container(
                      width: ResponsiveUtils.sp(5),
                      height: ResponsiveUtils.sp(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 2),
                        color: Colors.white,
                      ),
                      // inner filled circle only when selected
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: isDelivery ? 0 : ResponsiveUtils.sp(2.2),
                          height: isDelivery ? 0 : ResponsiveUtils.sp(2.2),
                          decoration: BoxDecoration(
                            color: isDelivery ? Colors.transparent : Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    ResponsiveSizedBox.width10,
                    TextStyles.body(
                      text: 'Self-Pickup',
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              ResponsiveSizedBox.width30,
              GestureDetector(
                onTap: () => setState(() => isDelivery = true),
                child: Row(
                  children: [
                    Container(
                      width: ResponsiveUtils.sp(5),
                      height: ResponsiveUtils.sp(5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isDelivery ? Colors.red : Colors.white,
                        border: Border.all(color: Colors.red, width: 2),
                      ),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: isDelivery ? ResponsiveUtils.sp(2.2) : 0,
                          height: isDelivery ? ResponsiveUtils.sp(2.2) : 0,
                          decoration: BoxDecoration(
                            color: isDelivery
                                ? Colors.white
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    ResponsiveSizedBox.width10,
                    TextStyles.body(text: 'Delivery', weight: FontWeight.w500),
                  ],
                ),
              ),
            ],
          ),

          ResponsiveSizedBox.height20,

          // When Self-Pickup -> show dropdown of hardcoded locations
          if (!isDelivery)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.body(
                  text: 'Choose pickup location',
                  color: Colors.grey[600],
                ),
                ResponsiveSizedBox.height10,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.wp(3),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(10),
                    borderRadius: BorderRadiusStyles.kradius10(),
                    border: Border.all(color: Colors.grey.withAlpha(22)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedPickupLocation,
                      isExpanded: true,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.grey.shade700,
                      ),
                      items: pickupLocations.map((loc) {
                        return DropdownMenuItem<String>(
                          value: loc,
                          child: TextStyles.body(text: loc),
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() {
                          selectedPickupLocation = val;
                          // show on the locationController as well (optional)
                          locationController.text = val ?? '';
                        });
                      },
                    ),
                  ),
                ),
                ResponsiveSizedBox.height10,
              ],
            ),

          // When Delivery -> show readonly field which opens Map Picker on tap
          if (isDelivery)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyles.body(
                  text: 'Enter Location',
                  color: Colors.grey[600],
                ),
                ResponsiveSizedBox.height10,
                GestureDetector(
                  onTap: () async {
                    final result = await Navigator.push<LocationSearchResult>(
                      context,
                      MaterialPageRoute(
                        builder: (_) => LocationSearchScreen(
                          apiKey:
                              "AIzaSyBW8UbeKu73pQ3fCj5rh3PXe_mXPorgCHA", // This is required even if set in manifest
                        ),
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        locationController.text = result.address;
                        selectedDeliveryLat = result.latitude;
                        selectedDeliveryLng = result.longitude;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    // make TextField readonly while still showing taps via GestureDetector
                    child: TextField(
                      controller: locationController,
                      decoration: InputDecoration(
                        hintText: 'Tap to pick location on map',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadiusStyles.kradius10(),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadiusStyles.kradius10(),
                          borderSide: BorderSide(color: Colors.grey[300]!),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadiusStyles.kradius10(),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.wp(4),
                          vertical: ResponsiveUtils.hp(1.5),
                        ),
                        suffixIcon: const Icon(Icons.location_on_outlined),
                      ),
                    ),
                  ),
                ),
                ResponsiveSizedBox.height15,

                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(3.2),
                      color: Colors.grey[600],
                    ),
                    children: [
                      const TextSpan(
                        text: 'Disclaimer: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const TextSpan(
                        text:
                            'Delivery Charges may vary for outside city limits locations including Airport pickup / drop. The same will be confirmed upon KYC verification.',
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

  Widget _buildCouponCard() {
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: couponController,
              decoration: InputDecoration(
                hintText: 'Coupon Code',
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: ResponsiveUtils.sp(3.6),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadiusStyles.kradius10(),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadiusStyles.kradius10(),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadiusStyles.kradius10(),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(4),
                  vertical: ResponsiveUtils.hp(1.5),
                ),
              ),
            ),
          ),
          ResponsiveSizedBox.width10,
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(6),
              vertical: ResponsiveUtils.hp(1.5),
            ),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadiusStyles.kradius10(),
            ),
            child: TextStyles.body(
              text: 'Apply',
              color: Colors.white,
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
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
          CustomNavigation.pushWithTransition(context, ScreenCheckoutpage());
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
          text: 'PROCEED',
          color: Colors.white,
          weight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  void dispose() {
    locationController.dispose();
    couponController.dispose();
    super.dispose();
  }
}
