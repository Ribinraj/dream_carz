// import 'package:dream_carz/core/appconstants.dart';
// import 'package:dream_carz/core/colors.dart';
// import 'package:dream_carz/core/constants.dart';
// import 'package:dream_carz/presentation/screens/screen_bookingdetailspage/screen_bookingdetailpage.dart';
// import 'package:dream_carz/widgets/custom_navigation.dart';
// import 'package:flutter/material.dart';
// import 'package:dream_carz/core/responsiveutils.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';

// // IMPORTANT: use your existing DateTimeSelectionWidget (do NOT modify it).
// // Adjust this import path to where your widget actually lives.
// import 'package:dream_carz/presentation/screens/screen_homepage/widgets/date_time_selectionwidget.dart';

// class CarBookingScreen extends StatefulWidget {
//   const CarBookingScreen({super.key});

//   @override
//   State<CarBookingScreen> createState() => _CarBookingScreenState();
// }

// class _CarBookingScreenState extends State<CarBookingScreen> {
//   int selectedKmPlan = 140;
//   String selectedCity = 'CHENNAI';
//   String selectedCarType = 'Select Car Type';

//   bool showCityOptions = false;
//   bool showCarTypeOptions = false;

//   // displayed pickup/drop values
//   DateTime pickupDate = DateTime(2025, 9, 16);
//   TimeOfDay pickupTime = const TimeOfDay(hour: 20, minute: 30);
//   DateTime dropDate = DateTime(2025, 9, 18);
//   TimeOfDay dropTime = const TimeOfDay(hour: 14, minute: 30);

//   final List<String> cities = [
//     'CHENNAI',
//     'BANGALORE',
//     'MUMBAI',
//     'DELHI',
//     'HYDERABAD',
//     'PUNE',
//     'KOLKATA',
//     'AHMEDABAD',
//   ];

//   final List<String> carTypes = ['SUV', 'MUV', 'MPV', 'SEDAN', 'HATCHBACK'];

//   final List<int> kmPlans = [140, 320, 500, 620, 700, 457];

//   final List<CarModel> cars = [
//     CarModel(
//       name: 'KUV100 K4',
//       price: 2625.0,
//       freeKm: 245.0,
//       extraRate: 8.0,
//       seats: 6,
//       transmission: 'Manual',
//       fuelType: 'Diesel',
//       isAvailable: true,
//       imageAsset:
//           'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?auto=format&fit=crop&w=2052&q=80',
//     ),
//     CarModel(
//       name: 'SWIFT VDI AT',
//       price: 2688.0,
//       freeKm: 245.0,
//       extraRate: 8.0,
//       seats: 5,
//       transmission: 'Automatic',
//       fuelType: 'Diesel',
//       isAvailable: false,
//       imageAsset:
//           'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?auto=format&fit=crop&w=2070&q=80',
//     ),
//     CarModel(
//       name: 'VERNA',
//       price: 2853.06,
//       freeKm: 245.0,
//       extraRate: 11.0,
//       seats: 5,
//       transmission: 'Manual',
//       fuelType: 'Diesel',
//       isAvailable: false,
//       imageAsset:
//           'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?auto=format&fit=crop&w=2127&q=80',
//     ),
//     CarModel(
//       name: 'Nexon AT',
//       price: 3403.68,
//       freeKm: 245.0,
//       extraRate: 11.0,
//       seats: 5,
//       transmission: 'Automatic',
//       fuelType: 'Diesel',
//       isAvailable: false,
//       imageAsset:
//           'https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&w=2070&q=80',
//     ),
//     CarModel(
//       name: 'VITARA BREZZA',
//       price: 4121.04,
//       freeKm: 245.0,
//       extraRate: 13.0,
//       seats: 5,
//       transmission: 'Manual',
//       fuelType: 'Petrol',
//       isAvailable: false,
//       imageAsset:
//           'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?auto=format&fit=crop&w=2052&q=80',
//     ),
//   ];

//   void _toggleCityOptions() {
//     setState(() {
//       showCityOptions = !showCityOptions;
//       if (showCityOptions) showCarTypeOptions = false;
//     });
//   }

//   void _toggleCarTypeOptions() {
//     setState(() {
//       showCarTypeOptions = !showCarTypeOptions;
//       if (showCarTypeOptions) showCityOptions = false;
//     });
//   }

//   double _chipWidthForFourAcross(BuildContext context) {
//     final media = MediaQuery.of(context).size.width;
//     final horizontalPadding =
//         ResponsiveUtils.wp(4) * 2; // left+right padding used in parent
//     final spacingBetween = ResponsiveUtils.wp(2) * 3; // approximate spacing
//     final available = media - horizontalPadding - spacingBetween;
//     return available / 4;
//   }

//   double _kmChipWidth(BuildContext context) {
//     final media = MediaQuery.of(context).size.width;
//     final horizontalPadding = ResponsiveUtils.wp(4) * 2;
//     final available = media - horizontalPadding;
//     return available / 4.0;
//   }

//   String _formatTimeOfDay(TimeOfDay t) {
//     final now = DateTime.now();
//     final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);
//     return DateFormat('h:mm a').format(dt);
//   }

//   // TOP-SHEET: edit both From & To using your existing DateTimeSelectionWidget.
//   // The widget is NOT changed. We capture temporary selections and apply on Submit.
//   void _openDateTimeTopSheet() {
//     // temp vars initialized to current displayed values (so submit will at least keep them if user doesn't change)
//     DateTime tempFromDate = pickupDate;
//     TimeOfDay tempFromTime = pickupTime;
//     DateTime tempToDate = dropDate;
//     TimeOfDay tempToTime = dropTime;

//     showGeneralDialog(
//       context: context,
//       barrierDismissible: true,
//       barrierLabel: 'Edit Date/Time',
//       transitionDuration: const Duration(milliseconds: 260),
//       pageBuilder: (ctx, anim1, anim2) {
//         return SafeArea(
//           child: Align(
//             alignment: Alignment.topCenter,
//             child: Material(
//               color: Colors.transparent,
//               child: Container(
//                 margin: EdgeInsets.symmetric(
//                   horizontal: ResponsiveUtils.wp(4),
//                   vertical: ResponsiveUtils.hp(2),
//                 ),
//                 padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//                 decoration: BoxDecoration(
//                   color: Appcolors.kwhitecolor,
//                   borderRadius: BorderRadiusStyles.kradius10(),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withAlpha(25),
//                       blurRadius: 12,
//                       offset: const Offset(0, 6),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     // Title
//                     Row(
//                       children: [
//                         ResponsiveText(
//                           'Edit Pickup & Drop',
//                           weight: FontWeight.w700,
//                         ),
//                         const Spacer(),
//                         IconButton(
//                           padding: EdgeInsets.zero,
//                           icon: Icon(Icons.close, size: ResponsiveUtils.sp(5)),
//                           onPressed: () => Navigator.of(ctx).pop(),
//                         ),
//                       ],
//                     ),

//                     ResponsiveSizedBox.height10,

//                     // From label + editor
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: ResponsiveText('From', weight: FontWeight.w600),
//                     ),
//                     const SizedBox(height: 8),
//                     // DateTimeSelectionWidget won't accept initial values (per requirement).
//                     // We capture changes via its onDateTimeChanged callback into tempFromDate/tempFromTime.
//                     DateTimeSelectionWidget(
//                       onDateTimeChanged: (d, t) {
//                         tempFromDate = d;
//                         tempFromTime = t;
//                       },
//                     ),

//                     ResponsiveSizedBox.height10,
//                     Divider(thickness: 1),
//                     ResponsiveSizedBox.height10,

//                     // To label + editor
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: ResponsiveText('To', weight: FontWeight.w600),
//                     ),
//                     const SizedBox(height: 8),
//                     DateTimeSelectionWidget(
//                       onDateTimeChanged: (d, t) {
//                         tempToDate = d;
//                         tempToTime = t;
//                       },
//                     ),

//                     ResponsiveSizedBox.height15,

//                     // Submit / Cancel
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(ctx).pop(); // close without applying
//                           },
//                           child: TextStyles.body(text: 'Cancel'),
//                         ),
//                         SizedBox(width: ResponsiveUtils.wp(2)),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Appcolors.kblackcolor,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadiusStyles.kradius10(),
//                             ),
//                           ),
//                           onPressed: () {
//                             // Apply temporary values to the screen state
//                             setState(() {
//                               pickupDate = tempFromDate;
//                               pickupTime = tempFromTime;
//                               dropDate = tempToDate;
//                               dropTime = tempToTime;
//                             });
//                             Navigator.of(ctx).pop(); // close top-sheet
//                           },
//                           child: TextStyles.body(
//                             text: 'Submit',
//                             color: Appcolors.kwhitecolor,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (ctx, anim, secAnim, child) {
//         return SlideTransition(
//           position: Tween<Offset>(
//             begin: const Offset(0, -1),
//             end: Offset.zero,
//           ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
//           child: FadeTransition(opacity: anim, child: child),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark, // White icons
//         statusBarBrightness: Brightness.dark, // iOS
//       ),
//     );
//     final double chipWidth = _chipWidthForFourAcross(context);
//     final double kmChipW = _kmChipWidth(context);

//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F0),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // TOP area inside body (back button + date display). Kept alignment like your layout.
//             Container(
//               color: const Color(0xFFF5F5F0),
//               padding: EdgeInsets.fromLTRB(
//                 ResponsiveUtils.wp(4),
//                 ResponsiveUtils.hp(3),
//                 ResponsiveUtils.wp(4),
//                 ResponsiveUtils.hp(2),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Back + date row
//                   Row(
//                     children: [
//                       InkWell(
//                         onTap: () => Navigator.of(context).pop(),
//                         child: Container(
//                           padding: EdgeInsets.all(ResponsiveUtils.wp(1.5)),
//                           decoration: BoxDecoration(
//                             color: Appcolors.kprimarycolor,
//                             borderRadius: BorderRadiusStyles.kradius10(),
//                             border: Border.all(color: Colors.grey.shade300),
//                           ),
//                           child: Icon(
//                             Icons.chevron_left,
//                             color: Appcolors.kwhitecolor,
//                           ),
//                         ),
//                       ),
//                       ResponsiveSizedBox.width10,
//                       Expanded(
//                         child: Container(
//                           padding: EdgeInsets.all(ResponsiveUtils.wp(2.1)),
//                           decoration: BoxDecoration(
//                             color: Appcolors.kwhitecolor,
//                             borderRadius: BorderRadiusStyles.kradius5(),
//                             border: Border.all(color: Colors.grey.shade300),
//                           ),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               // Tappable pickup+time display. Opens the top-sheet to edit both from & to.
//                               InkWell(
//                                 onTap: _openDateTimeTopSheet,
//                                 child: ResponsiveText(
//                                   DateFormat('dd MMM yyyy').format(pickupDate) +
//                                       '  ' +
//                                       _formatTimeOfDay(pickupTime),
//                                   sizeFactor: 0.8,
//                                   weight: FontWeight.w600,
//                                 ),
//                               ),

//                               ResponsiveText(
//                                 'To',
//                                 sizeFactor: 0.75,
//                                 color: const Color(0xFFE74C3C),
//                               ),

//                               InkWell(
//                                 onTap: _openDateTimeTopSheet,
//                                 child: ResponsiveText(
//                                   DateFormat('dd MMM yyyy').format(dropDate) +
//                                       '  ' +
//                                       _formatTimeOfDay(dropTime),
//                                   sizeFactor: 0.8,
//                                   weight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       // small spacing on the right (no special submit here; editing happens in top-sheet)
//                       SizedBox(width: ResponsiveUtils.wp(2)),
//                     ],
//                   ),

//                   ResponsiveSizedBox.height10,

//                   // City & CarType selection buttons (same as before)
//                   SizedBox(
//                     height: ResponsiveUtils.hp(5.5),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: _buildSelectionButton(
//                             title: selectedCity,
//                             icon: Icons.location_city,
//                             onTap: _toggleCityOptions,
//                           ),
//                         ),
//                         ResponsiveSizedBox.width10,
//                         Expanded(
//                           child: _buildSelectionButton(
//                             title: selectedCarType,
//                             icon: Icons.directions_car,
//                             onTap: _toggleCarTypeOptions,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   ResponsiveSizedBox.height10,

//                   // Inline City options
//                   if (showCityOptions)
//                     SizedBox(
//                       height: ResponsiveUtils.hp(5),
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                             right: ResponsiveUtils.wp(4),
//                           ),
//                           child: Row(
//                             children: cities.map((city) {
//                               final bool isSelected = city == selectedCity;
//                               return Padding(
//                                 padding: EdgeInsets.only(
//                                   right: ResponsiveUtils.wp(2),
//                                 ),
//                                 child: _buildOptionChip(
//                                   text: city,
//                                   width: chipWidth,
//                                   isSelected: isSelected,
//                                   onTap: () {
//                                     setState(() {
//                                       selectedCity = city;
//                                       showCityOptions = false;
//                                     });
//                                   },
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ),

//                   // Inline CarType options
//                   if (showCarTypeOptions)
//                     SizedBox(
//                       height: ResponsiveUtils.hp(5),
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Padding(
//                           padding: EdgeInsets.only(
//                             right: ResponsiveUtils.wp(4),
//                           ),
//                           child: Row(
//                             children: carTypes.map((ct) {
//                               final bool isSelected = ct == selectedCarType;
//                               return Padding(
//                                 padding: EdgeInsets.only(
//                                   right: ResponsiveUtils.wp(2),
//                                 ),
//                                 child: _buildOptionChip(
//                                   text: ct,
//                                   width: chipWidth,
//                                   isSelected: isSelected,
//                                   onTap: () {
//                                     setState(() {
//                                       selectedCarType = ct;
//                                       showCarTypeOptions = false;
//                                     });
//                                   },
//                                 ),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ),

//                   // KM plan label + horizontal chips
//                   ResponsiveText(
//                     'Free Kilometer Plans',
//                     sizeFactor: .9,
//                     weight: FontWeight.w500,
//                     color: Appcolors.kprimarycolor,
//                   ),
//                   ResponsiveSizedBox.height10,
//                   SizedBox(
//                     height: ResponsiveUtils.hp(5.4),
//                     child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       padding: EdgeInsets.only(right: ResponsiveUtils.wp(4)),
//                       itemCount: kmPlans.length,
//                       separatorBuilder: (_, __) =>
//                           SizedBox(width: ResponsiveUtils.wp(2)),
//                       itemBuilder: (context, index) {
//                         final km = kmPlans[index];
//                         return _buildKmChipScrollable(
//                           km: km,
//                           width: kmChipW,
//                           isSelected: selectedKmPlan == km,
//                           onTap: () {
//                             setState(() {
//                               selectedKmPlan = km;
//                             });
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                   ResponsiveSizedBox.height10,
//                 ],
//               ),
//             ),

//             // Cars list (unchanged)
//             Expanded(
//               child: ListView.builder(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: ResponsiveUtils.wp(4),
//                 ),
//                 itemCount: cars.length,
//                 itemBuilder: (context, index) {
//                   return _buildCarCard(cars[index]);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSelectionButton({
//     required String title,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadiusStyles.kradius5(),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: InkWell(
//         onTap: onTap,
//         child: Row(
//           children: [
//             Icon(icon, size: ResponsiveUtils.sp(5), color: Colors.black87),
//             ResponsiveSizedBox.width10,
//             Expanded(
//               child: ResponsiveText(
//                 title,
//                 sizeFactor: .85,
//                 weight: FontWeight.w600,
//               ),
//             ),
//             Icon(
//               Icons.keyboard_arrow_down,
//               size: ResponsiveUtils.sp(5),
//               color: Colors.black87,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOptionChip({
//     required String text,
//     required double width,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: width,
//         padding: EdgeInsets.symmetric(
//           vertical: ResponsiveUtils.hp(.5),
//           horizontal: ResponsiveUtils.wp(2),
//         ),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF2C3E50) : Colors.white,
//           borderRadius: BorderRadiusStyles.kradius5(),
//           border: Border.all(
//             color: isSelected ? const Color(0xFF2C3E50) : Colors.grey.shade300,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ResponsiveText(
//               text,
//               sizeFactor: .65,
//               weight: FontWeight.bold,
//               color: isSelected ? Colors.white : Colors.black,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildKmChipScrollable({
//     required int km,
//     required double width,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: width,
//         padding: EdgeInsets.symmetric(
//           vertical: ResponsiveUtils.hp(.3),
//           horizontal: ResponsiveUtils.wp(1),
//         ),
//         decoration: BoxDecoration(
//           color: isSelected ? const Color(0xFF2C3E50) : Colors.white,
//           borderRadius: BorderRadiusStyles.kradius5(),
//           border: Border.all(
//             color: isSelected ? const Color(0xFF2C3E50) : Colors.grey.shade300,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ResponsiveText(
//               km.toString(),
//               sizeFactor: .8,
//               weight: FontWeight.bold,
//               color: isSelected ? Colors.white : Colors.black,
//             ),
//             ResponsiveText(
//               'KM',
//               sizeFactor: 0.6,
//               color: isSelected ? Colors.white : Colors.black,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCarCard(CarModel car) {
//     final bool available = car.isAvailable;
//     // remove padding when unavailable so overlay covers the full card
//     final EdgeInsetsGeometry containerPadding = available
//         ? EdgeInsets.all(ResponsiveUtils.wp(3))
//         : EdgeInsets.zero;

//     return Container(
//       margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
//       padding: containerPadding,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadiusStyles.kradius10(),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withAlpha(22),
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Stack(
//         children: [
//           // Full overlay when unavailable (no inner white padding visible)
//           if (!available)
//             Positioned.fill(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(
//                     255,
//                     221,
//                     214,
//                     214,
//                   ).withAlpha(220),
//                   borderRadius: BorderRadiusStyles.kradius10(),
//                 ),
//               ),
//             ),

//           // Content (keeps your original alignment)
//           Padding(
//             padding: available
//                 ? EdgeInsets.zero
//                 : EdgeInsets.all(ResponsiveUtils.wp(3)),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     // Car Image
//                     Container(
//                       width: ResponsiveUtils.wp(20),
//                       height: ResponsiveUtils.hp(8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadiusStyles.kradius10(),
//                       ),
//                       child: ClipRRect(
//                         borderRadius: BorderRadiusStyles.kradius10(),
//                         child: ColorFiltered(
//                           colorFilter: available
//                               ? const ColorFilter.mode(
//                                   Colors.transparent,
//                                   BlendMode.srcOver,
//                                 )
//                               : ColorFilter.mode(
//                                   Colors.grey.withAlpha(100),
//                                   BlendMode.srcATop,
//                                 ),
//                           child: Image.network(
//                             car.imageAsset,
//                             fit: BoxFit.cover,
//                             loadingBuilder: (context, child, progress) {
//                               if (progress == null) return child;
//                               return Center(
//                                 child: SpinKitFadingCircle(
//                                   size: ResponsiveUtils.wp(10),
//                                   color: Appcolors.kgreyColor,
//                                 ),
//                               );
//                             },
//                             errorBuilder: (context, error, stackTrace) {
//                               return Container(
//                                 color: Colors.grey.shade200,
//                                 child: Icon(
//                                   Icons.directions_car,
//                                   size: ResponsiveUtils.sp(8),
//                                   color: Colors.grey,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ),

//                     ResponsiveSizedBox.width10,

//                     // Car Details
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Price and Book/SoldOut
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               ResponsiveText(
//                                 '₹ ${car.price.toStringAsFixed(car.price == car.price.toInt() ? 0 : 2)}',
//                                 sizeFactor: 1.2,
//                                 weight: FontWeight.bold,
//                               ),
//                               if (available)
//                                 GestureDetector(
//                                   onTap: () {
//                                     CustomNavigation.pushWithTransition(
//                                       context,
//                                       ScreenBookingdetailpage(),
//                                     );
//                                   },
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: ResponsiveUtils.wp(5),
//                                       vertical: ResponsiveUtils.hp(1),
//                                     ),
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xFFE74C3C),
//                                       borderRadius:
//                                           BorderRadiusStyles.kradius5(),
//                                     ),
//                                     child: ResponsiveText(
//                                       'BOOK',
//                                       sizeFactor: 0.6,
//                                       weight: FontWeight.bold,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 )
//                               else
//                                 Container(
//                                   padding: EdgeInsets.symmetric(
//                                     horizontal: ResponsiveUtils.wp(2),
//                                     vertical: ResponsiveUtils.hp(1),
//                                   ),
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade400,
//                                     borderRadius: BorderRadiusStyles.kradius5(),
//                                   ),
//                                   child: ResponsiveText(
//                                     'SOLD OUT',
//                                     sizeFactor: 0.6,
//                                     weight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                             ],
//                           ),

//                           ResponsiveSizedBox.height10,

//                           // Free KM and Extra Rate
//                           Row(
//                             children: [
//                               ResponsiveText(
//                                 'Free Km : ',
//                                 sizeFactor: 0.85,
//                                 color: Colors.grey.shade600,
//                               ),
//                               ResponsiveText(
//                                 car.freeKm.toStringAsFixed(1),
//                                 sizeFactor: 0.85,
//                                 weight: FontWeight.w600,
//                                 color: const Color(0xFFE74C3C),
//                               ),
//                               ResponsiveSizedBox.width20,
//                               ResponsiveText(
//                                 'Extra : ',
//                                 sizeFactor: 0.85,
//                                 color: Colors.grey.shade600,
//                               ),
//                               ResponsiveText(
//                                 '₹ ${car.extraRate.toStringAsFixed(1)}/Km',
//                                 sizeFactor: 0.85,
//                                 weight: FontWeight.w600,
//                                 color: const Color(0xFFE74C3C),
//                               ),
//                             ],
//                           ),

//                           ResponsiveSizedBox.height10,

//                           // Car Name
//                           ResponsiveText(
//                             car.name,
//                             sizeFactor: 1.0,
//                             weight: FontWeight.w600,
//                           ),

//                           ResponsiveSizedBox.height10,
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Car Features
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     ResponsiveSizedBox.width10,
//                     _buildFeatureItem(
//                       Appconstants.seatIcon,
//                       '${car.seats} Seater',
//                     ),
//                     ResponsiveSizedBox.width20,
//                     _buildFeatureItem(Appconstants.gearIcon, car.transmission),
//                     ResponsiveSizedBox.width20,
//                     _buildFeatureItem(Appconstants.petrolIcon, car.fuelType),
//                     ResponsiveSizedBox.width10,
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFeatureItem(String assetPath, String text) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SvgPicture.asset(
//           assetPath,
//           width: ResponsiveUtils.sp(4),
//           height: ResponsiveUtils.sp(4),
//           colorFilter: const ColorFilter.mode(
//             Color(0xFFE74C3C), // red color
//             BlendMode.srcIn,
//           ),
//         ),
//         SizedBox(width: ResponsiveUtils.wp(1)),
//         ResponsiveText(text, sizeFactor: 0.8, color: Colors.grey.shade600),
//       ],
//     );
//   }
// }

// class CarModel {
//   final String name;
//   final double price;
//   final double freeKm;
//   final double extraRate;
//   final int seats;
//   final String transmission;
//   final String fuelType;
//   final bool isAvailable;
//   final String imageAsset;

//   CarModel({
//     required this.name,
//     required this.price,
//     required this.freeKm,
//     required this.extraRate,
//     required this.seats,
//     required this.transmission,
//     required this.fuelType,
//     required this.isAvailable,
//     required this.imageAsset,
//   });
// }
//////////////////////////////////////////////////////////
import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/presentation/screens/screen_bookingdetailspage/screen_bookingdetailpage.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

// IMPORTANT: use your existing DateTimeSelectionWidget (do NOT modify it).
// Adjust this import path to where your widget actually lives.
import 'package:dream_carz/presentation/screens/screen_homepage/widgets/date_time_selectionwidget.dart';

class CarBookingScreen extends StatefulWidget {
  const CarBookingScreen({super.key});

  @override
  State<CarBookingScreen> createState() => _CarBookingScreenState();
}

class _CarBookingScreenState extends State<CarBookingScreen> {
  int selectedKmPlan = 140;
  String selectedCity = 'CHENNAI';
  String selectedCarType = 'Select Car Type';

  bool showCityOptions = false;
  bool showCarTypeOptions = false;

  // displayed pickup/drop values
  DateTime pickupDate = DateTime(2025, 9, 16);
  TimeOfDay pickupTime = const TimeOfDay(hour: 20, minute: 30);
  DateTime dropDate = DateTime(2025, 9, 18);
  TimeOfDay dropTime = const TimeOfDay(hour: 14, minute: 30);

  final List<String> cities = [
    'CHENNAI',
    'BANGALORE',
    'MUMBAI',
    'DELHI',
    'HYDERABAD',
    'PUNE',
    'KOLKATA',
    'AHMEDABAD',
  ];

  final List<String> carTypes = ['SUV', 'MUV', 'MPV', 'SEDAN', 'HATCHBACK'];

  final List<int> kmPlans = [140, 320, 500, 620, 700, 457];

  final List<CarModel> cars = [
    CarModel(
      name: 'KUV100 K4',
      price: 2625.0,
      freeKm: 245.0,
      extraRate: 8.0,
      seats: 6,
      transmission: 'Manual',
      fuelType: 'Diesel',
      isAvailable: true,
      imageAsset:
          'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?auto=format&fit=crop&w=2052&q=80',
    ),
    CarModel(
      name: 'SWIFT VDI AT',
      price: 2688.0,
      freeKm: 245.0,
      extraRate: 8.0,
      seats: 5,
      transmission: 'Automatic',
      fuelType: 'Diesel',
      isAvailable: false,
      imageAsset:
          'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?auto=format&fit=crop&w=2070&q=80',
    ),
    CarModel(
      name: 'VERNA',
      price: 2853.06,
      freeKm: 245.0,
      extraRate: 11.0,
      seats: 5,
      transmission: 'Manual',
      fuelType: 'Diesel',
      isAvailable: false,
      imageAsset:
          'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?auto=format&fit=crop&w=2127&q=80',
    ),
    CarModel(
      name: 'Nexon AT',
      price: 3403.68,
      freeKm: 245.0,
      extraRate: 11.0,
      seats: 5,
      transmission: 'Automatic',
      fuelType: 'Diesel',
      isAvailable: false,
      imageAsset:
          'https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&w=2070&q=80',
    ),
    CarModel(
      name: 'VITARA BREZZA',
      price: 4121.04,
      freeKm: 245.0,
      extraRate: 13.0,
      seats: 5,
      transmission: 'Manual',
      fuelType: 'Petrol',
      isAvailable: false,
      imageAsset:
          'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?auto=format&fit=crop&w=2052&q=80',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Set system UI overlay style in initState for better reliability
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // Dark icons
        statusBarBrightness: Brightness.light,     // iOS compatibility
      ),
    );
  }

  void _toggleCityOptions() {
    setState(() {
      showCityOptions = !showCityOptions;
      if (showCityOptions) showCarTypeOptions = false;
    });
  }

  void _toggleCarTypeOptions() {
    setState(() {
      showCarTypeOptions = !showCarTypeOptions;
      if (showCarTypeOptions) showCityOptions = false;
    });
  }

  double _chipWidthForFourAcross(BuildContext context) {
    final media = MediaQuery.of(context).size.width;
    final horizontalPadding =
        ResponsiveUtils.wp(4) * 2; // left+right padding used in parent
    final spacingBetween = ResponsiveUtils.wp(2) * 3; // approximate spacing
    final available = media - horizontalPadding - spacingBetween;
    return available / 4;
  }

  double _kmChipWidth(BuildContext context) {
    final media = MediaQuery.of(context).size.width;
    final horizontalPadding = ResponsiveUtils.wp(4) * 2;
    final available = media - horizontalPadding;
    return available / 4.0;
  }

  String _formatTimeOfDay(TimeOfDay t) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);
    return DateFormat('h:mm a').format(dt);
  }

  // TOP-SHEET: edit both From & To using your existing DateTimeSelectionWidget.
  // The widget is NOT changed. We capture temporary selections and apply on Submit.
  void _openDateTimeTopSheet() {
    // temp vars initialized to current displayed values (so submit will at least keep them if user doesn't change)
    DateTime tempFromDate = pickupDate;
    TimeOfDay tempFromTime = pickupTime;
    DateTime tempToDate = dropDate;
    TimeOfDay tempToTime = dropTime;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Edit Date/Time',
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (ctx, anim1, anim2) {
        return SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(4),
                  vertical: ResponsiveUtils.hp(2),
                ),
                padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                decoration: BoxDecoration(
                  color: Appcolors.kwhitecolor,
                  borderRadius: BorderRadiusStyles.kradius10(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(25),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Row(
                      children: [
                        ResponsiveText(
                          'Edit Pickup & Drop',
                          weight: FontWeight.w700,
                        ),
                        const Spacer(),
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(Icons.close, size: ResponsiveUtils.sp(5)),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),

                    ResponsiveSizedBox.height10,

                    // From label + editor
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ResponsiveText('From', weight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    // DateTimeSelectionWidget won't accept initial values (per requirement).
                    // We capture changes via its onDateTimeChanged callback into tempFromDate/tempFromTime.
                    DateTimeSelectionWidget(
                      onDateTimeChanged: (d, t) {
                        tempFromDate = d;
                        tempFromTime = t;
                      },
                    ),

                    ResponsiveSizedBox.height10,
                    Divider(thickness: 1),
                    ResponsiveSizedBox.height10,

                    // To label + editor
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ResponsiveText('To', weight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    DateTimeSelectionWidget(
                      onDateTimeChanged: (d, t) {
                        tempToDate = d;
                        tempToTime = t;
                      },
                    ),

                    ResponsiveSizedBox.height15,

                    // Submit / Cancel
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop(); // close without applying
                          },
                          child: TextStyles.body(text: 'Cancel'),
                        ),
                        SizedBox(width: ResponsiveUtils.wp(2)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolors.kblackcolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusStyles.kradius10(),
                            ),
                          ),
                          onPressed: () {
                            // Apply temporary values to the screen state
                            setState(() {
                              pickupDate = tempFromDate;
                              pickupTime = tempFromTime;
                              dropDate = tempToDate;
                              dropTime = tempToTime;
                            });
                            Navigator.of(ctx).pop(); // close top-sheet
                          },
                          child: TextStyles.body(
                            text: 'Submit',
                            color: Appcolors.kwhitecolor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (ctx, anim, secAnim, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
          child: FadeTransition(opacity: anim, child: child),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double chipWidth = _chipWidthForFourAcross(context);
    final double kmChipW = _kmChipWidth(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F0),
        body: SafeArea(
          child: Column(
            children: [
              // TOP area inside body (back button + date display). Kept alignment like your layout.
              Container(
                color: const Color(0xFFF5F5F0),
                padding: EdgeInsets.fromLTRB(
                  ResponsiveUtils.wp(4),
                  ResponsiveUtils.hp(3),
                  ResponsiveUtils.wp(4),
                  ResponsiveUtils.hp(2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Back + date row
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            padding: EdgeInsets.all(ResponsiveUtils.wp(1.5)),
                            decoration: BoxDecoration(
                              color: Appcolors.kprimarycolor,
                              borderRadius: BorderRadiusStyles.kradius10(),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Icon(
                              Icons.chevron_left,
                              color: Appcolors.kwhitecolor,
                            ),
                          ),
                        ),
                        ResponsiveSizedBox.width10,
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(ResponsiveUtils.wp(2.1)),
                            decoration: BoxDecoration(
                              color: Appcolors.kwhitecolor,
                              borderRadius: BorderRadiusStyles.kradius5(),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Tappable pickup+time display. Opens the top-sheet to edit both from & to.
                                InkWell(
                                  onTap: _openDateTimeTopSheet,
                                  child: ResponsiveText(
                                    DateFormat('dd MMM yyyy').format(pickupDate) +
                                        '  ' +
                                        _formatTimeOfDay(pickupTime),
                                    sizeFactor: 0.8,
                                    weight: FontWeight.w600,
                                  ),
                                ),

                                ResponsiveText(
                                  'To',
                                  sizeFactor: 0.75,
                                  color: const Color(0xFFE74C3C),
                                ),

                                InkWell(
                                  onTap: _openDateTimeTopSheet,
                                  child: ResponsiveText(
                                    DateFormat('dd MMM yyyy').format(dropDate) +
                                        '  ' +
                                        _formatTimeOfDay(dropTime),
                                    sizeFactor: 0.8,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // small spacing on the right (no special submit here; editing happens in top-sheet)
                        SizedBox(width: ResponsiveUtils.wp(2)),
                      ],
                    ),

                    ResponsiveSizedBox.height10,

                    // City & CarType selection buttons (same as before)
                    SizedBox(
                      height: ResponsiveUtils.hp(5.5),
                      child: Row(
                        children: [
                          Expanded(
                            child: _buildSelectionButton(
                              title: selectedCity,
                              icon: Icons.location_city,
                              onTap: _toggleCityOptions,
                            ),
                          ),
                          ResponsiveSizedBox.width10,
                          Expanded(
                            child: _buildSelectionButton(
                              title: selectedCarType,
                              icon: Icons.directions_car,
                              onTap: _toggleCarTypeOptions,
                            ),
                          ),
                        ],
                      ),
                    ),

                    ResponsiveSizedBox.height10,

                    // Inline City options
                    if (showCityOptions)
                      SizedBox(
                        height: ResponsiveUtils.hp(5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: ResponsiveUtils.wp(4),
                            ),
                            child: Row(
                              children: cities.map((city) {
                                final bool isSelected = city == selectedCity;
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: ResponsiveUtils.wp(2),
                                  ),
                                  child: _buildOptionChip(
                                    text: city,
                                    width: chipWidth,
                                    isSelected: isSelected,
                                    onTap: () {
                                      setState(() {
                                        selectedCity = city;
                                        showCityOptions = false;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),

                    // Inline CarType options
                    if (showCarTypeOptions)
                      SizedBox(
                        height: ResponsiveUtils.hp(5),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: ResponsiveUtils.wp(4),
                            ),
                            child: Row(
                              children: carTypes.map((ct) {
                                final bool isSelected = ct == selectedCarType;
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: ResponsiveUtils.wp(2),
                                  ),
                                  child: _buildOptionChip(
                                    text: ct,
                                    width: chipWidth,
                                    isSelected: isSelected,
                                    onTap: () {
                                      setState(() {
                                        selectedCarType = ct;
                                        showCarTypeOptions = false;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),

                    // KM plan label + horizontal chips
                    ResponsiveText(
                      'Free Kilometer Plans',
                      sizeFactor: .9,
                      weight: FontWeight.w500,
                      color: Appcolors.kprimarycolor,
                    ),
                    ResponsiveSizedBox.height10,
                    SizedBox(
                      height: ResponsiveUtils.hp(5.4),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.only(right: ResponsiveUtils.wp(4)),
                        itemCount: kmPlans.length,
                        separatorBuilder: (_, __) =>
                            SizedBox(width: ResponsiveUtils.wp(2)),
                        itemBuilder: (context, index) {
                          final km = kmPlans[index];
                          return _buildKmChipScrollable(
                            km: km,
                            width: kmChipW,
                            isSelected: selectedKmPlan == km,
                            onTap: () {
                              setState(() {
                                selectedKmPlan = km;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    ResponsiveSizedBox.height10,
                  ],
                ),
              ),

              // Cars list (unchanged)
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.wp(4),
                  ),
                  itemCount: cars.length,
                  itemBuilder: (context, index) {
                    return _buildCarCard(cars[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusStyles.kradius5(),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, size: ResponsiveUtils.sp(5), color: Colors.black87),
            ResponsiveSizedBox.width10,
            Expanded(
              child: ResponsiveText(
                title,
                sizeFactor: .85,
                weight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              size: ResponsiveUtils.sp(5),
              color: Colors.black87,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionChip({
    required String text,
    required double width,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.hp(.5),
          horizontal: ResponsiveUtils.wp(2),
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2C3E50) : Colors.white,
          borderRadius: BorderRadiusStyles.kradius5(),
          border: Border.all(
            color: isSelected ? const Color(0xFF2C3E50) : Colors.grey.shade300,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResponsiveText(
              text,
              sizeFactor: .65,
              weight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKmChipScrollable({
    required int km,
    required double width,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          vertical: ResponsiveUtils.hp(.3),
          horizontal: ResponsiveUtils.wp(1),
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2C3E50) : Colors.white,
          borderRadius: BorderRadiusStyles.kradius5(),
          border: Border.all(
            color: isSelected ? const Color(0xFF2C3E50) : Colors.grey.shade300,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ResponsiveText(
              km.toString(),
              sizeFactor: .8,
              weight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.black,
            ),
            ResponsiveText(
              'KM',
              sizeFactor: 0.6,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarCard(CarModel car) {
    final bool available = car.isAvailable;
    // remove padding when unavailable so overlay covers the full card
    final EdgeInsetsGeometry containerPadding = available
        ? EdgeInsets.all(ResponsiveUtils.wp(3))
        : EdgeInsets.zero;

    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
      padding: containerPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadiusStyles.kradius10(),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(22),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Full overlay when unavailable (no inner white padding visible)
          if (!available)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    221,
                    214,
                    214,
                  ).withAlpha(220),
                  borderRadius: BorderRadiusStyles.kradius10(),
                ),
              ),
            ),

          // Content (keeps your original alignment)
          Padding(
            padding: available
                ? EdgeInsets.zero
                : EdgeInsets.all(ResponsiveUtils.wp(3)),
            child: Column(
              children: [
                Row(
                  children: [
                    // Car Image
                    Container(
                      width: ResponsiveUtils.wp(20),
                      height: ResponsiveUtils.hp(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusStyles.kradius10(),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadiusStyles.kradius10(),
                        child: ColorFiltered(
                          colorFilter: available
                              ? const ColorFilter.mode(
                                  Colors.transparent,
                                  BlendMode.srcOver,
                                )
                              : ColorFilter.mode(
                                  Colors.grey.withAlpha(100),
                                  BlendMode.srcATop,
                                ),
                          child: Image.network(
                            car.imageAsset,
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

                    ResponsiveSizedBox.width10,

                    // Car Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price and Book/SoldOut
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ResponsiveText(
                                '₹ ${car.price.toStringAsFixed(car.price == car.price.toInt() ? 0 : 2)}',
                                sizeFactor: 1.2,
                                weight: FontWeight.bold,
                              ),
                              if (available)
                                GestureDetector(
                                  onTap: () {
                                    CustomNavigation.pushWithTransition(
                                      context,
                                      ScreenBookingdetailpage(),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveUtils.wp(5),
                                      vertical: ResponsiveUtils.hp(1),
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE74C3C),
                                      borderRadius:
                                          BorderRadiusStyles.kradius5(),
                                    ),
                                    child: ResponsiveText(
                                      'BOOK',
                                      sizeFactor: 0.6,
                                      weight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              else
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: ResponsiveUtils.wp(2),
                                    vertical: ResponsiveUtils.hp(1),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadiusStyles.kradius5(),
                                  ),
                                  child: ResponsiveText(
                                    'SOLD OUT',
                                    sizeFactor: 0.6,
                                    weight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                            ],
                          ),

                          ResponsiveSizedBox.height10,

                          // Free KM and Extra Rate
                          Row(
                            children: [
                              ResponsiveText(
                                'Free Km : ',
                                sizeFactor: 0.85,
                                color: Colors.grey.shade600,
                              ),
                              ResponsiveText(
                                car.freeKm.toStringAsFixed(1),
                                sizeFactor: 0.85,
                                weight: FontWeight.w600,
                                color: const Color(0xFFE74C3C),
                              ),
                              ResponsiveSizedBox.width20,
                              ResponsiveText(
                                'Extra : ',
                                sizeFactor: 0.85,
                                color: Colors.grey.shade600,
                              ),
                              ResponsiveText(
                                '₹ ${car.extraRate.toStringAsFixed(1)}/Km',
                                sizeFactor: 0.85,
                                weight: FontWeight.w600,
                                color: const Color(0xFFE74C3C),
                              ),
                            ],
                          ),

                          ResponsiveSizedBox.height10,

                          // Car Name
                          ResponsiveText(
                            car.name,
                            sizeFactor: 1.0,
                            weight: FontWeight.w600,
                          ),

                          ResponsiveSizedBox.height10,
                        ],
                      ),
                    ),
                  ],
                ),
                // Car Features
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ResponsiveSizedBox.width10,
                    _buildFeatureItem(
                      Appconstants.seatIcon,
                      '${car.seats} Seater',
                    ),
                    ResponsiveSizedBox.width20,
                    _buildFeatureItem(Appconstants.gearIcon, car.transmission),
                    ResponsiveSizedBox.width20,
                    _buildFeatureItem(Appconstants.petrolIcon, car.fuelType),
                    ResponsiveSizedBox.width10,
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String assetPath, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          assetPath,
          width: ResponsiveUtils.sp(4),
          height: ResponsiveUtils.sp(4),
          colorFilter: const ColorFilter.mode(
            Color(0xFFE74C3C), // red color
            BlendMode.srcIn,
          ),
        ),
        SizedBox(width: ResponsiveUtils.wp(1)),
        ResponsiveText(text, sizeFactor: 0.8, color: Colors.grey.shade600),
      ],
    );
  }
}

class CarModel {
  final String name;
  final double price;
  final double freeKm;
  final double extraRate;
  final int seats;
  final String transmission;
  final String fuelType;
  final bool isAvailable;
  final String imageAsset;

  CarModel({
    required this.name,
    required this.price,
    required this.freeKm,
    required this.extraRate,
    required this.seats,
    required this.transmission,
    required this.fuelType,
    required this.isAvailable,
    required this.imageAsset,
  });
}