// //////////////////////////////////////////////////////////import 'package:dream_carz/core/appconstants.dart';
// import 'package:dream_carz/core/appconstants.dart';
// import 'package:dream_carz/core/colors.dart';
// import 'package:dream_carz/core/constants.dart';
// import 'package:dream_carz/data/categories_model.dart';
// import 'package:dream_carz/data/city_model.dart';
// import 'package:dream_carz/data/km_model.dart';
// import 'package:dream_carz/presentation/blocs/fetch_categories_bloc/fetch_categories_bloc.dart';
// import 'package:dream_carz/presentation/blocs/fetch_cities_bloc/fetch_cities_bloc.dart';
// import 'package:dream_carz/presentation/blocs/fetch_kmplans_bloc/fetch_kmplans_bloc.dart';
// import 'package:dream_carz/presentation/screens/screen_bookingdetailspage/screen_bookingdetailpage.dart';
// import 'package:dream_carz/widgets/custom_navigation.dart';
// import 'package:dream_carz/widgets/custom_snackbar.dart';
// import 'package:flutter/material.dart';
// import 'package:dream_carz/core/responsiveutils.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';

// // IMPORTANT: use your existing DateTimeSelectionWidget (do NOT modify it).
// // Adjust this import path to where your widget actually lives.
// import 'package:dream_carz/presentation/screens/screen_homepage/widgets/date_time_selectionwidget.dart';

// class ScreenSearchresultpage extends StatefulWidget {
//   final  DateTime fromDate;
//   final TimeOfDay fromTime;
//   final DateTime toDate;
//  final TimeOfDay toTime;
//  final String selectedCityId;
//   const ScreenSearchresultpage({super.key, required this.fromDate, required this.fromTime, required this.toDate, required this.toTime, required this.selectedCityId});

//   @override
//   State<ScreenSearchresultpage> createState() => _CarBookingScreenState();
// }

// class _CarBookingScreenState extends State<ScreenSearchresultpage> {
//  int? selectedKmLimit;
// String? selectedKmId;
//     String? selectedCityId;
//   String selectedCityName = 'Select City';
// String? selectedCategoryId;                 // null initially
// String selectedCategoryName = 'Select Car Type';

//   bool showCityOptions = false;
//   bool showCarTypeOptions = false;

//   // displayed pickup/drop values
//   DateTime pickupDate = DateTime(2025, 9, 16);
//   TimeOfDay pickupTime = const TimeOfDay(hour: 20, minute: 30);
//   DateTime dropDate = DateTime(2025, 9, 18);
//   TimeOfDay dropTime = const TimeOfDay(hour: 14, minute: 30);

//   List<CityModel> fetchedCities = [];

//   List<CategoriesModel> fetchedCategories = [];
// List<KmModel> fetchedKmPlans = [];

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

//   @override
//   void initState() {
//     super.initState();

//   // set initial id from the incoming param
//   selectedCityId = widget.selectedCityId;
//   pickupDate = widget.fromDate;
//   pickupTime = widget.fromTime;
//   dropDate = widget.toDate;
//   dropTime = widget.toTime;
//   // dispatch fetch cities
//   Future.microtask(() {

//     context.read<FetchCitiesBloc>().add(FetchcitiesInitialEvent());
//       context.read<FetchKmplansBloc>().add(FetchKmplansInitialEvent());
//         context.read<FetchCategoriesBloc>().add(FetchCategoreisInitailfetchingEvent());
//   });

//     // Set system UI overlay style in initState for better reliability
//     SystemChrome.setSystemUIOverlayStyle(
//       const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark, // Dark icons
//         statusBarBrightness: Brightness.light,     // iOS compatibility
//       ),
//     );
//   }

//   void _toggleCityOptions() {
//     setState(() {
//       showCityOptions = !showCityOptions;
//       if (showCityOptions) showCarTypeOptions = false;
//     });
//   }

//   // void _toggleCarTypeOptions() {
//   //   setState(() {
//   //     showCarTypeOptions = !showCarTypeOptions;
//   //     if (showCarTypeOptions) showCityOptions = false;
//   //   });
//   // }

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
// void _openDateTimeTopSheet() {
//   // IMPORTANT: seed from current displayed values (pickup vs drop)
//   DateTime tempFromDate = pickupDate;
//   TimeOfDay tempFromTime = pickupTime;
//   DateTime tempToDate = dropDate;
//   TimeOfDay tempToTime = dropTime;

//   showGeneralDialog(
//     context: context,
//     barrierDismissible: true,
//     barrierLabel: 'Edit Date/Time',
//     transitionDuration: const Duration(milliseconds: 260),
//     pageBuilder: (ctx, anim1, anim2) {
//       return SafeArea(
//         child: Align(
//           alignment: Alignment.topCenter,
//           child: Material(
//             color: Colors.transparent,
//             child: Container(
//               margin: EdgeInsets.symmetric(
//                 horizontal: ResponsiveUtils.wp(4),
//                 vertical: ResponsiveUtils.hp(2),
//               ),
//               padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//               decoration: BoxDecoration(
//                 color: Appcolors.kwhitecolor,
//                 borderRadius: BorderRadiusStyles.kradius10(),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withAlpha(25),
//                     blurRadius: 12,
//                     offset: const Offset(0, 6),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Title + Close
//                   Row(
//                     children: [
//                       ResponsiveText('Edit Pickup & Drop', weight: FontWeight.w700),
//                       const Spacer(),
//                       IconButton(
//                         padding: EdgeInsets.zero,
//                         icon: Icon(Icons.close, size: ResponsiveUtils.sp(5)),
//                         onPressed: () => Navigator.of(ctx).pop(),
//                       ),
//                     ],
//                   ),

//                   ResponsiveSizedBox.height10,

//                   // FROM label + editor (seeded from pickup)
//                   Align(alignment: Alignment.centerLeft, child: ResponsiveText('From', weight: FontWeight.w600)),
//                   const SizedBox(height: 8),
//                   DateTimeSelectionWidget(
//                     key: ValueKey('from_picker'),          // distinct key (optional but safe)
//                     initialDate: tempFromDate,
//                     initialTime: tempFromTime,
//                     onDateTimeChanged: (d, t) {
//                       tempFromDate = d;
//                       tempFromTime = t;
//                     },
//                   ),

//                   ResponsiveSizedBox.height10,
//                   Divider(thickness: 1),
//                   ResponsiveSizedBox.height10,

//                   // TO label + editor (seeded from drop — NOT pickup)
//                   Align(alignment: Alignment.centerLeft, child: ResponsiveText('To', weight: FontWeight.w600)),
//                   const SizedBox(height: 8),
//                   DateTimeSelectionWidget(
//                     key: ValueKey('to_picker'),            // distinct key (optional but safe)
//                     initialDate: tempToDate,
//                     initialTime: tempToTime,
//                     onDateTimeChanged: (d, t) {
//                       tempToDate = d;
//                       tempToTime = t;
//                     },
//                   ),

//                   ResponsiveSizedBox.height15,

//                   // Submit / Cancel
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       TextButton(
//                         onPressed: () => Navigator.of(ctx).pop(),
//                         child: TextStyles.body(text: 'Cancel'),
//                       ),
//                       SizedBox(width: ResponsiveUtils.wp(2)),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Appcolors.kblackcolor,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadiusStyles.kradius10()),
//                         ),
//                         onPressed: () {
//                           final DateTime fromDt = DateTime(
//                             tempFromDate.year,
//                             tempFromDate.month,
//                             tempFromDate.day,
//                             tempFromTime.hour,
//                             tempFromTime.minute,
//                           );
//                           final DateTime toDt = DateTime(
//                             tempToDate.year,
//                             tempToDate.month,
//                             tempToDate.day,
//                             tempToTime.hour,
//                             tempToTime.minute,
//                           );

//                           if (!toDt.isAfter(fromDt)) {
//                             CustomSnackbar.show(
//                               context,
//                               message: 'Drop date/time must be after pickup date/time',
//                               type: SnackbarType.error,
//                             );
//                             return;
//                           }

//                           setState(() {
//                             pickupDate = tempFromDate;
//                             pickupTime = tempFromTime;
//                             dropDate = tempToDate;
//                             dropTime = tempToTime;
//                           });

//                           Navigator.of(ctx).pop();
//                         },
//                         child: TextStyles.body(text: 'Submit', color: Appcolors.kwhitecolor),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     },
//     transitionBuilder: (ctx, anim, secAnim, child) {
//       return SlideTransition(
//         position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero)
//             .animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
//         child: FadeTransition(opacity: anim, child: child),
//       );
//     },
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     // final double chipWidth = _chipWidthForFourAcross(context);
//     // final double kmChipW = _kmChipWidth(context);

//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//         statusBarBrightness: Brightness.light,
//       ),
//       child: Scaffold(
//         backgroundColor: const Color(0xFFF5F5F0),
//         body: SafeArea(
//           child: Column(
//             children: [
//               // TOP area inside body (back button + date display). Kept alignment like your layout.
//               Container(
//                 color: const Color(0xFFF5F5F0),
//                 padding: EdgeInsets.fromLTRB(
//                   ResponsiveUtils.wp(4),
//                   ResponsiveUtils.hp(3),
//                   ResponsiveUtils.wp(4),
//                   ResponsiveUtils.hp(2),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Back + date row
//                     Row(
//                       children: [
//                         InkWell(
//                           onTap: () => Navigator.of(context).pop(),
//                           child: Container(
//                             padding: EdgeInsets.all(ResponsiveUtils.wp(1.5)),
//                             decoration: BoxDecoration(
//                               color: Appcolors.kprimarycolor,
//                               borderRadius: BorderRadiusStyles.kradius10(),
//                               border: Border.all(color: Colors.grey.shade300),
//                             ),
//                             child: Icon(
//                               Icons.chevron_left,
//                               color: Appcolors.kwhitecolor,
//                             ),
//                           ),
//                         ),
//                         ResponsiveSizedBox.width10,
//                         Expanded(
//                           child: Container(
//                             padding: EdgeInsets.all(ResponsiveUtils.wp(2.1)),
//                             decoration: BoxDecoration(
//                               color: Appcolors.kwhitecolor,
//                               borderRadius: BorderRadiusStyles.kradius5(),
//                               border: Border.all(color: Colors.grey.shade300),
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 // Tappable pickup+time display. Opens the top-sheet to edit both from & to.
//                                 InkWell(
//                                   onTap: _openDateTimeTopSheet,
//                                   child: ResponsiveText(
//                                     DateFormat('dd MMM yyyy').format(pickupDate) +
//                                         '  ' +
//                                         _formatTimeOfDay(pickupTime),
//                                     sizeFactor: 0.8,
//                                     weight: FontWeight.w600,
//                                   ),
//                                 ),

//                                 ResponsiveText(
//                                   'To',
//                                   sizeFactor: 0.75,
//                                   color: const Color(0xFFE74C3C),
//                                 ),

//                                 InkWell(
//                                   onTap: _openDateTimeTopSheet,
//                                   child: ResponsiveText(
//                                     DateFormat('dd MMM yyyy').format(dropDate) +
//                                         '  ' +
//                                         _formatTimeOfDay(dropTime),
//                                     sizeFactor: 0.8,
//                                     weight: FontWeight.w600,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         // small spacing on the right (no special submit here; editing happens in top-sheet)
//                         SizedBox(width: ResponsiveUtils.wp(2)),
//                       ],
//                     ),

//                     ResponsiveSizedBox.height10,

//                     // City & CarType selection buttons (same as before)
//                 // (inside build) Replace the top row that shows selection buttons with this:
// SizedBox(
//   height: ResponsiveUtils.hp(5.5),
//   child: Row(
//     children: [
//       Expanded(
//         child: BlocBuilder<FetchCitiesBloc, FetchCitiesState>(
//   builder: (context, state) {
//     if (state is FetchCitiesLoadingState) {
//       return _buildSelectionButton(
//         title: 'Loading...',
//         icon: Icons.location_city,
//         onTap: () {},
//       );
//     }

//     if (state is FetchCitiesSuccessState) {
//       // 🔹 Only keep active cities
//       fetchedCities = state.cities
//           .where((c) => c.status.toLowerCase() == 'active')
//           .toList();

//       // 🔹 Resolve initial selection if not set yet
//       if (selectedCityId != null && selectedCityName == 'Select City') {
//         final found = fetchedCities.firstWhere(
//           (c) => c.cityId == selectedCityId,
//           orElse: () => fetchedCities.isNotEmpty
//               ? fetchedCities.first
//               : CityModel(
//                   cityId: '',
//                   name: 'Select City',
//                   status: '',
//                   createdAt: '',
//                   modifiedAt: '',
//                 ),
//         );
//         if (found.cityId.isNotEmpty) {
//           selectedCityName = found.name;
//         }
//       }

//       return _buildSelectionButton(
//         title: selectedCityName,
//         icon: Icons.location_city,
//         onTap: _toggleCityOptions,
//       );
//     }

//     if (state is FetchCitiesErrorState) {
//       return _buildSelectionButton(
//         title: 'Error loading cities',
//         icon: Icons.location_city,
//         onTap: () {},
//       );
//     }

//     return _buildSelectionButton(
//       title: selectedCityName,
//       icon: Icons.location_city,
//       onTap: _toggleCityOptions,
//     );
//   },
// ),

//       ),

//       ResponsiveSizedBox.width10,

//       // The CarType button unchanged (you can keep your current carTypes list)
//       Expanded(
//         child:BlocBuilder<FetchCategoriesBloc, FetchCategoriesState>(
//   builder: (context, state) {
//     if (state is FetchCategoriesLoadingState) {
//       return _buildSelectionButton(
//         title: 'Loading...',
//         icon: Icons.directions_car,
//         onTap: () {},
//       );
//     }

//     if (state is FetchCategoriesSuccessState) {
//       fetchedCategories = state.categories; // don't filter, per your request

//       // Do NOT auto-select; only update name if user already selected
//       if (selectedCategoryId != null && selectedCategoryName == 'Select Car Type') {
//         final found = fetchedCategories.firstWhere(
//           (c) => c.categoryId == selectedCategoryId,
//           orElse: () => CategoriesModel(
//             categoryId: '',
//             fleetTypeId: '',
//             categoryName: 'Select Car Type',
//             status: '',
//             createdAt: '',
//             modifiedAt: '',
//           ),
//         );
//         if (found.categoryId.isNotEmpty) {
//           selectedCategoryName = found.categoryName;
//         }
//       }

//       return _buildSelectionButton(
//         title: selectedCategoryName,
//         icon: Icons.directions_car,
//         onTap: () {
//           setState(() {
//             showCarTypeOptions = !showCarTypeOptions;
//             if (showCarTypeOptions) showCityOptions = false;
//           });
//         },
//       );
//     }

//     // error/initial
//     return _buildSelectionButton(
//       title: selectedCategoryName,
//       icon: Icons.directions_car,
//       onTap: () {
//         setState(() => showCarTypeOptions = !showCarTypeOptions);
//       },
//     );
//   },
// ),

//       ),
//     ],
//   ),
// ),

//                     ResponsiveSizedBox.height10,

//                  // Inline City options (show when showCityOptions is true)
// if (showCityOptions)
//   SizedBox(
//     height: ResponsiveUtils.hp(5),
//     child: SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Padding(
//         padding: EdgeInsets.only(right: ResponsiveUtils.wp(4)),
//         child: Row(
//           children: fetchedCities.map((city) {
//             final bool isSelected = city.cityId == selectedCityId;
//             return Padding(
//               padding: EdgeInsets.only(right: ResponsiveUtils.wp(2)),
//               child: _buildOptionChip(
//                 text: city.name,
//                 width: _chipWidthForFourAcross(context),
//                 isSelected: isSelected,
//                 onTap: () {
//                   setState(() {
//                     selectedCityId = city.cityId;
//                     selectedCityName = city.name;
//                     showCityOptions = false;
//                   });
//                 },
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     ),
//   ),

//                     // Inline CarType options
//               if (showCarTypeOptions)
//   SizedBox(
//     height: ResponsiveUtils.hp(5),
//     child: SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Padding(
//         padding: EdgeInsets.only(right: ResponsiveUtils.wp(4)),
//         child: Row(
//           children: fetchedCategories.map((cat) {
//             final bool isSelected = cat.categoryId == selectedCategoryId;
//             return Padding(
//               padding: EdgeInsets.only(right: ResponsiveUtils.wp(2)),
//               child: _buildOptionChip(
//                 text: cat.categoryName,
//                 width: _chipWidthForFourAcross(context),
//                 isSelected: isSelected,
//                 onTap: () {
//                   setState(() {
//                     // only now set the id & name
//                     selectedCategoryId = cat.categoryId;
//                     selectedCategoryName = cat.categoryName;
//                     showCarTypeOptions = false;
//                   });
//                 },
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     ),
//   ),

//                     // KM plan label + horizontal chips
//                     ResponsiveText(
//                       'Free Kilometer Plans',
//                       sizeFactor: .9,
//                       weight: FontWeight.w500,
//                       color: Appcolors.kprimarycolor,
//                     ),
//                     ResponsiveSizedBox.height10,
//                 // KM plans area — powered by bloc
// SizedBox(
//   height: ResponsiveUtils.hp(5.4),
//   child: BlocBuilder<FetchKmplansBloc, FetchKmplansState>(
//     builder: (context, state) {
//       if (state is FetchKmplansLoadingState) {
//         // show skeleton / loader
//         return Center(
//           child: SpinKitThreeBounce(
//             size: ResponsiveUtils.wp(6),
//             color: Appcolors.kgreyColor,
//           ),
//         );
//       }

//       if (state is FetchKmplansSuccessState) {
//         // keep only active plans (optional; remove filter if you don't want it)
//         fetchedKmPlans = state.kmplans
//             .where((k) => k.status.toLowerCase() == 'active')
//             .toList();

//         if (fetchedKmPlans.isEmpty) {
//           return Center(child: Text('No plans available'));
//         }

//         return ListView.separated(
//           scrollDirection: Axis.horizontal,
//           padding: EdgeInsets.only(right: ResponsiveUtils.wp(4)),
//           itemCount: fetchedKmPlans.length,
//           separatorBuilder: (_, __) => SizedBox(width: ResponsiveUtils.wp(2)),
//           itemBuilder: (context, index) {
//             final km = fetchedKmPlans[index];
//             final kmLimitText = km.kmLimit?.toString() ?? km.kmId; // fallback
//             final bool isSelected = km.kmId == selectedKmId;

//             return GestureDetector(
//               onTap: () {
//                 setState(() {
//                   // set selected km id (String) and store limit for display if needed
//                   selectedKmId = km.kmId;
//                   selectedKmLimit = km.kmLimit;
//                 });
//               },
//               child: Container(
//                 width: _kmChipWidth(context),
//                 padding: EdgeInsets.symmetric(
//                   vertical: ResponsiveUtils.hp(.3),
//                   horizontal: ResponsiveUtils.wp(1),
//                 ),
//                 decoration: BoxDecoration(
//                   color: isSelected ? const Color(0xFF2C3E50) : Colors.white,
//                   borderRadius: BorderRadiusStyles.kradius5(),
//                   border: Border.all(
//                     color: isSelected ? const Color(0xFF2C3E50) : Colors.grey.shade300,
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     ResponsiveText(
//                       kmLimitText,
//                       sizeFactor: .8,
//                       weight: FontWeight.bold,
//                       color: isSelected ? Colors.white : Colors.black,
//                     ),
//                     ResponsiveText(
//                       'KM',
//                       sizeFactor: 0.6,
//                       color: isSelected ? Colors.white : Colors.black,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       }

//       if (state is FetchKmplansErrorState) {
//         return Center(child: Text('Failed to load plans'));
//       }

//       // initial / fallback
//       return SizedBox.shrink();
//     },
//   ),
// ),
//                     ResponsiveSizedBox.height10,
//                   ],
//                 ),
//               ),

//               // Cars list (unchanged)
//               Expanded(
//                 child: ListView.builder(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: ResponsiveUtils.wp(4),
//                   ),
//                   itemCount: cars.length,
//                   itemBuilder: (context, index) {
//                     return _buildCarCard(cars[index]);
//                   },
//                 ),
//               ),
//             ],
//           ),
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

// ignore_for_file: use_build_context_synchronously

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
/////////////////////////////////////////////
import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/data/categories_model.dart';
import 'package:dream_carz/data/city_model.dart';
import 'package:dream_carz/data/km_model.dart';
import 'package:dream_carz/data/cars_model.dart'; // Import your CarsModel
import 'package:dream_carz/data/search_model.dart'; // Import SearchModel
import 'package:dream_carz/presentation/blocs/fetch_categories_bloc/fetch_categories_bloc.dart';
import 'package:dream_carz/presentation/blocs/fetch_cities_bloc/fetch_cities_bloc.dart';
import 'package:dream_carz/presentation/blocs/fetch_kmplans_bloc/fetch_kmplans_bloc.dart';
import 'package:dream_carz/presentation/blocs/fetch_cars_bloc/fetch_cars_bloc.dart'; // Import FetchCarsBloc
import 'package:dream_carz/presentation/blocs/fetch_profile_bloc/fetch_profile_bloc.dart';
import 'package:dream_carz/presentation/screens/screen_bookingdetailspage/screen_bookingdetailpage.dart';
import 'package:dream_carz/presentation/screens/screen_homepage/widgets/date_time_selectionwidget.dart';
import 'package:dream_carz/presentation/screens/screen_loginpage.dart/screen_loginpage.dart';
import 'package:dream_carz/presentation/screens/screen_searchresultscreen.dart/widgets/customloading.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:dream_carz/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenSearchresultpage extends StatefulWidget {
  final DateTime fromDate;
  final TimeOfDay fromTime;
  final DateTime toDate;
  final TimeOfDay toTime;
  final String selectedCityId;

  const ScreenSearchresultpage({
    super.key,
    required this.fromDate,
    required this.fromTime,
    required this.toDate,
    required this.toTime,
    required this.selectedCityId,
  });

  @override
  State<ScreenSearchresultpage> createState() => _CarBookingScreenState();
}

class _CarBookingScreenState extends State<ScreenSearchresultpage> {
  int? selectedKmLimit;
  String? selectedKmId;
  String? selectedCityId;
  String selectedCityName = 'Select City';
  String? selectedCategoryId;
  String selectedCategoryName = 'Select Car Type';
  bool _kmInitialized = false;
  bool showCityOptions = false;
  bool showCarTypeOptions = false;

  // displayed pickup/drop values
  late DateTime pickupDate;
  late TimeOfDay pickupTime;
  late DateTime dropDate;
  late TimeOfDay dropTime;

  List<CityModel> fetchedCities = [];
  List<CategoriesModel> fetchedCategories = [];
  List<KmModel> fetchedKmPlans = [];

  @override
  void initState() {
    super.initState();

    // Set initial values from widget params
    selectedCityId = widget.selectedCityId;
    pickupDate = widget.fromDate;
    pickupTime = widget.fromTime;
    dropDate = widget.toDate;
    dropTime = widget.toTime;

    // Dispatch fetch events
    Future.microtask(() {
      context.read<FetchCitiesBloc>().add(FetchcitiesInitialEvent());
      context.read<FetchKmplansBloc>().add(FetchKmplansInitialEvent());
      context.read<FetchCategoriesBloc>().add(
        FetchCategoreisInitailfetchingEvent(),
      );

      // Initial car search with current parameters
      _searchCars();
    });

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  // Method to search cars with current filters
  void _searchCars() {
    // 🔐 Guard 1: city selected
    if (selectedCityId == null || selectedCityId!.isEmpty) {
      CustomSnackbar.show(
        context,
        message: 'Please select a city before searching',
        type: SnackbarType.error,
      );
      return;
    }

    // Build DateTimes from the current state
    final fromDateTime = DateTime(
      pickupDate.year,
      pickupDate.month,
      pickupDate.day,
      pickupTime.hour,
      pickupTime.minute,
    );
    final toDateTime = DateTime(
      dropDate.year,
      dropDate.month,
      dropDate.day,
      dropTime.hour,
      dropTime.minute,
    );

    // 🔐 Guard 2: drop after pickup
    if (!toDateTime.isAfter(fromDateTime)) {
      CustomSnackbar.show(
        context,
        message: 'Drop date/time must be after pickup date/time',
        type: SnackbarType.error,
      );
      return;
    }

    String formatDateTime(DateTime dt) =>
        "${dt.year.toString().padLeft(4, '0')}-"
        "${dt.month.toString().padLeft(2, '0')}-"
        "${dt.day.toString().padLeft(2, '0')} "
        "${dt.hour.toString().padLeft(2, '0')}:"
        "${dt.minute.toString().padLeft(2, '0')}:00";

    final search = SearchModel(
      bookingFrom: formatDateTime(fromDateTime),
      bookingTo: formatDateTime(toDateTime),
      cityId: int.parse(selectedCityId!),
      categoryId: selectedCategoryId != null
          ? int.tryParse(selectedCategoryId!)
          : null,
      kmId: selectedKmId != null ? int.tryParse(selectedKmId!) : null,
    );

    context.read<FetchCarsBloc>().add(
      FetchCarsButtonClickEvent(search: search),
    );
  }

  void _toggleCityOptions() {
    setState(() {
      showCityOptions = !showCityOptions;
      if (showCityOptions) showCarTypeOptions = false;
    });
  }

  double _chipWidthForFourAcross(BuildContext context) {
    final media = MediaQuery.of(context).size.width;
    final horizontalPadding = ResponsiveUtils.wp(4) * 2;
    final spacingBetween = ResponsiveUtils.wp(2) * 3;
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

  void _openDateTimeTopSheet() {
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
        // Use StatefulBuilder to manage state within the dialog
        return StatefulBuilder(
          builder: (context, setDialogState) {
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
                        Row(
                          children: [
                            ResponsiveText(
                              'Edit Pickup & Drop',
                              weight: FontWeight.w700,
                            ),
                            const Spacer(),
                            IconButton(
                              padding: EdgeInsets.zero,
                              icon: Icon(
                                Icons.close,
                                size: ResponsiveUtils.sp(5),
                              ),
                              onPressed: () => Navigator.of(ctx).pop(),
                            ),
                          ],
                        ),
                        ResponsiveSizedBox.height10,

                        // FROM Section
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ResponsiveText(
                            'From',
                            weight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FromDateTimeSelectionWidget(
                          key: ValueKey(
                            'from_picker_${tempFromDate}_${tempFromTime}',
                          ),
                          initialDate: tempFromDate,
                          initialTime: tempFromTime,
                          onDateTimeChanged: (d, t) {
                            setDialogState(() {
                              tempFromDate = d;
                              tempFromTime = t;

                              // Check if current "To" selection is still valid
                              final fromDt = DateTime(
                                tempFromDate.year,
                                tempFromDate.month,
                                tempFromDate.day,
                                tempFromTime.hour,
                                tempFromTime.minute,
                              );
                              final toDt = DateTime(
                                tempToDate.year,
                                tempToDate.month,
                                tempToDate.day,
                                tempToTime.hour,
                                tempToTime.minute,
                              );
                              final minAllowed = fromDt.add(
                                const Duration(hours: 12),
                              );

                              // If "To" is now invalid, reset it to minimum allowed
                              if (toDt.isBefore(minAllowed)) {
                                tempToDate = DateTime(
                                  minAllowed.year,
                                  minAllowed.month,
                                  minAllowed.day,
                                );
                                tempToTime = TimeOfDay(
                                  hour: minAllowed.hour,
                                  minute: minAllowed.minute,
                                );
                              }
                            });
                          },
                        ),

                        ResponsiveSizedBox.height10,
                        Divider(thickness: 1),
                        ResponsiveSizedBox.height10,

                        // TO Section
                        Align(
                          alignment: Alignment.centerLeft,
                          child: ResponsiveText('To', weight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        ToDateTimeSelectionWidget(
                          key: ValueKey(
                            'to_picker_${tempFromDate}_${tempFromTime}_${tempToDate}_${tempToTime}',
                          ),
                          initialDate: tempToDate,
                          initialTime: tempToTime,
                          minDateTime: DateTime(
                            tempFromDate.year,
                            tempFromDate.month,
                            tempFromDate.day,
                            tempFromTime.hour,
                            tempFromTime.minute,
                          ).add(const Duration(hours: 12)),
                          onDateTimeChanged: (d, t) {
                            setDialogState(() {
                              tempToDate = d;
                              tempToTime = t;
                            });
                          },
                        ),

                        ResponsiveSizedBox.height15,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
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
                                final DateTime fromDt = DateTime(
                                  tempFromDate.year,
                                  tempFromDate.month,
                                  tempFromDate.day,
                                  tempFromTime.hour,
                                  tempFromTime.minute,
                                );
                                final DateTime toDt = DateTime(
                                  tempToDate.year,
                                  tempToDate.month,
                                  tempToDate.day,
                                  tempToTime.hour,
                                  tempToTime.minute,
                                );

                                // Validate 12-hour minimum gap
                                final minAllowed = fromDt.add(
                                  const Duration(hours: 12),
                                );
                                if (toDt.isBefore(minAllowed)) {
                                  CustomSnackbar.show(
                                    context,
                                    message:
                                        'Drop date/time must be at least 12 hours after pickup',
                                    type: SnackbarType.error,
                                  );
                                  return;
                                }

                                setState(() {
                                  pickupDate = tempFromDate;
                                  pickupTime = tempFromTime;
                                  dropDate = tempToDate;
                                  dropTime = tempToTime;
                                });

                                Navigator.of(ctx).pop();

                                // Trigger new search with updated dates
                                _searchCars();
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
        );
      },
    );
  }

  Future<bool> _checkTokenExists() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('USER_TOKEN') ?? '';
    return token.isNotEmpty;
  }

  Future<void> _handleCheckoutNavigation(
    BuildContext context,
    CarsModel car,
  ) async {
    final hasToken = await _checkTokenExists();

    if (!hasToken) {
      CustomNavigation.pushWithTransition(
        context,
        LoginScreen(
          loginfrom: "searchpage",
          pickupDate: pickupDate,
          pickupTime: pickupTime,
          dropDate: dropDate,
          dropTime: dropTime,
          modelId: car.modelId, // <-- now valid
          cityId: selectedCityId,
          kmId: selectedKmId,
        ),
      );
      return;
    }

    context.read<FetchProfileBloc>().add(FetchProfileInitialEvent());

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(child: CircularProgressIndicator()),
    // );

    context
        .read<FetchProfileBloc>()
        .stream
        .firstWhere(
          (state) =>
              state is FetchProfileSuccessState ||
              state is FetchProfileErrorState,
        )
        .then((state) {
          if (!context.mounted) return;

          if (state is FetchProfileErrorState) {
            if (state.message.toLowerCase().contains('expired') ||
                state.message == 'expiredtoken') {
              CustomNavigation.pushWithTransition(
                context,
                LoginScreen(loginfrom: "searchpage"),
              );
            } else {
              CustomNavigation.pushWithTransition(
                context,
                ScreenBookingdetailpage(
                  pickupDate: pickupDate,
                  pickupTime: pickupTime,
                  dropDate: dropDate,
                  dropTime: dropTime,
                  modelId: car.modelId, // <-- now valid
                  cityId: selectedCityId,
                  kmId: selectedKmId,
                ),
              );
            }
          } else if (state is FetchProfileSuccessState) {
            // (Optional) Handle the success path too
            CustomNavigation.pushWithTransition(
              context,
              ScreenBookingdetailpage(
                pickupDate: pickupDate,
                pickupTime: pickupTime,
                dropDate: dropDate,
                dropTime: dropTime,
                modelId: car.modelId,
                cityId: selectedCityId,
                kmId: selectedKmId,
              ),
            );
          }
        })
        .timeout(
          const Duration(seconds: 10),
          onTimeout: () {
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
  Widget build(BuildContext context) {
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
                                InkWell(
                                  onTap: _openDateTimeTopSheet,
                                  child: ResponsiveText(
                                    '${DateFormat('dd MMM yyyy').format(pickupDate)}  ${_formatTimeOfDay(pickupTime)}',
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
                                    '${DateFormat('dd MMM yyyy').format(dropDate)}  ${_formatTimeOfDay(dropTime)}',
                                    sizeFactor: 0.8,
                                    weight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: ResponsiveUtils.wp(2)),
                      ],
                    ),

                    ResponsiveSizedBox.height10,

                    // City & CarType selection
                    SizedBox(
                      height: ResponsiveUtils.hp(5.5),
                      child: Row(
                        children: [
                          Expanded(
                            child:
                                BlocBuilder<FetchCitiesBloc, FetchCitiesState>(
                                  builder: (context, state) {
                                    if (state is FetchCitiesLoadingState) {
                                      return _buildSelectionButton(
                                        title: 'Loading...',
                                        icon: Icons.location_city,
                                        onTap: () {},
                                      );
                                    }

                                    if (state is FetchCitiesSuccessState) {
                                      fetchedCities = state.cities
                                          .where(
                                            (c) =>
                                                c.status.toLowerCase() ==
                                                'active',
                                          )
                                          .toList();

                                      if (selectedCityId != null &&
                                          selectedCityName == 'Select City') {
                                        final found = fetchedCities.firstWhere(
                                          (c) => c.cityId == selectedCityId,
                                          orElse: () => fetchedCities.isNotEmpty
                                              ? fetchedCities.first
                                              : CityModel(
                                                  cityId: '',
                                                  name: 'Select City',
                                                  status: '',
                                                  createdAt: '',
                                                  modifiedAt: '',
                                                ),
                                        );
                                        if (found.cityId.isNotEmpty) {
                                          selectedCityName = found.name;
                                        }
                                      }

                                      return _buildSelectionButton(
                                        title: selectedCityName,
                                        icon: Icons.location_city,
                                        onTap: _toggleCityOptions,
                                      );
                                    }

                                    return _buildSelectionButton(
                                      title: selectedCityName,
                                      icon: Icons.location_city,
                                      onTap: _toggleCityOptions,
                                    );
                                  },
                                ),
                          ),

                          ResponsiveSizedBox.width10,

                          Expanded(
                            child:
                                BlocBuilder<
                                  FetchCategoriesBloc,
                                  FetchCategoriesState
                                >(
                                  builder: (context, state) {
                                    if (state is FetchCategoriesLoadingState) {
                                      return _buildSelectionButton(
                                        title: 'Loading...',
                                        icon: Icons.directions_car,
                                        onTap: () {},
                                      );
                                    }

                                    if (state is FetchCategoriesSuccessState) {
                                      fetchedCategories = state.categories;

                                      if (selectedCategoryId != null &&
                                          selectedCategoryName ==
                                              'Select Car Type') {
                                        final found = fetchedCategories
                                            .firstWhere(
                                              (c) =>
                                                  c.categoryId ==
                                                  selectedCategoryId,
                                              orElse: () => CategoriesModel(
                                                categoryId: '',
                                                fleetTypeId: '',
                                                categoryName: 'Select Car Type',
                                                status: '',
                                                createdAt: '',
                                                modifiedAt: '',
                                              ),
                                            );
                                        if (found.categoryId.isNotEmpty) {
                                          selectedCategoryName =
                                              found.categoryName;
                                        }
                                      }

                                      return _buildSelectionButton(
                                        title: selectedCategoryName,
                                        icon: Icons.directions_car,
                                        onTap: () {
                                          setState(() {
                                            showCarTypeOptions =
                                                !showCarTypeOptions;
                                            if (showCarTypeOptions)
                                              showCityOptions = false;
                                          });
                                        },
                                      );
                                    }

                                    return _buildSelectionButton(
                                      title: selectedCategoryName,
                                      icon: Icons.directions_car,
                                      onTap: () {
                                        setState(
                                          () => showCarTypeOptions =
                                              !showCarTypeOptions,
                                        );
                                      },
                                    );
                                  },
                                ),
                          ),
                        ],
                      ),
                    ),

                    ResponsiveSizedBox.height10,

                    // City options dropdown
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
                              children: fetchedCities.map((city) {
                                final bool isSelected =
                                    city.cityId == selectedCityId;
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: ResponsiveUtils.wp(2),
                                  ),
                                  child: _buildOptionChip(
                                    text: city.name,
                                    width: _chipWidthForFourAcross(context),
                                    isSelected: isSelected,
                                    onTap: () {
                                      setState(() {
                                        selectedCityId = city.cityId;
                                        selectedCityName = city.name;
                                        showCityOptions = false;
                                      });
                                      // Search with new city
                                      _searchCars();
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),

                    // CarType options dropdown
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
                              children: fetchedCategories.map((cat) {
                                final bool isSelected =
                                    cat.categoryId == selectedCategoryId;
                                return Padding(
                                  padding: EdgeInsets.only(
                                    right: ResponsiveUtils.wp(2),
                                  ),
                                  child: _buildOptionChip(
                                    text: cat.categoryName,
                                    width: _chipWidthForFourAcross(context),
                                    isSelected: isSelected,
                                    onTap: () {
                                      setState(() {
                                        selectedCategoryId = cat.categoryId;
                                        selectedCategoryName = cat.categoryName;
                                        showCarTypeOptions = false;
                                      });
                                      // Search with new category
                                      _searchCars();
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),

                    // KM Plans
                    ResponsiveText(
                      'Free Kilometer Plans',
                      sizeFactor: .9,
                      weight: FontWeight.w500,
                      color: Appcolors.kprimarycolor,
                    ),
                    ResponsiveSizedBox.height10,

                    SizedBox(
                      height: ResponsiveUtils.hp(5.4),
                      child: BlocBuilder<FetchKmplansBloc, FetchKmplansState>(
                        builder: (context, state) {
                          if (state is FetchKmplansLoadingState) {
                            return Center(
                              child: SpinKitThreeBounce(
                                size: ResponsiveUtils.wp(6),
                                color: Appcolors.kgreyColor,
                              ),
                            );
                          }

                          if (state is FetchKmplansSuccessState) {
                            fetchedKmPlans = state.kmplans
                                .where(
                                  (k) => k.status.toLowerCase() == 'active',
                                )
                                .toList();

                            if (fetchedKmPlans.isEmpty) {
                              return Center(child: Text('No plans available'));
                            }
                            // Initialize (only once) to the first active plan and trigger a search.
                            if (!_kmInitialized && fetchedKmPlans.isNotEmpty) {
                              // mark initialized immediately so we don't schedule multiple callbacks
                              _kmInitialized = true;

                              // Schedule setState & search after this frame to avoid calling setState in build
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (!mounted) return;
                                setState(() {
                                  selectedKmId = fetchedKmPlans.first.kmId;
                                  selectedKmLimit =
                                      fetchedKmPlans.first.kmLimit;
                                });

                                // Trigger initial search with the default KM plan
                                _searchCars();
                              });
                            }
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(
                                right: ResponsiveUtils.wp(4),
                              ),
                              itemCount: fetchedKmPlans.length,
                              separatorBuilder: (_, __) =>
                                  SizedBox(width: ResponsiveUtils.wp(2)),
                              itemBuilder: (context, index) {
                                final km = fetchedKmPlans[index];
                                final kmLimitText =
                                    km.kmLimit?.toString() ?? km.kmId;
                                final bool isSelected = km.kmId == selectedKmId;

                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedKmId = km.kmId;
                                      selectedKmLimit = km.kmLimit;
                                    });
                                    // Search with new KM plan
                                    _searchCars();
                                  },
                                  child: Container(
                                    width: _kmChipWidth(context),
                                    padding: EdgeInsets.symmetric(
                                      vertical: ResponsiveUtils.hp(.3),
                                      horizontal: ResponsiveUtils.wp(1),
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? const Color(0xFF2C3E50)
                                          : Colors.white,
                                      borderRadius:
                                          BorderRadiusStyles.kradius5(),
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF2C3E50)
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ResponsiveText(
                                          kmLimitText,
                                          sizeFactor: .8,
                                          weight: FontWeight.bold,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        ResponsiveText(
                                          'KM',
                                          sizeFactor: 0.6,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          }

                          return SizedBox.shrink();
                        },
                      ),
                    ),
                    ResponsiveSizedBox.height10,
                  ],
                ),
              ),

              // Cars list from API
              // --- Replace your current "Cars list from API" RefreshIndicator block with this ---

              // Cars list from API
              Expanded(
                child: RefreshIndicator(
                  // Replace your current onRefresh callback with this:
               // Replace your current onRefresh callback with this:
onRefresh: () async {
  final DateTime fromDateTimeRefresh = DateTime(
    pickupDate.year,
    pickupDate.month,
    pickupDate.day,
    pickupTime.hour,
    pickupTime.minute,
  );
  final DateTime toDateTimeRefresh = DateTime(
    dropDate.year,
    dropDate.month,
    dropDate.day,
    dropTime.hour,
    dropTime.minute,
  );

  String formatDateTime(DateTime dt) =>
      "${dt.year.toString().padLeft(4, '0')}-"
      "${dt.month.toString().padLeft(2, '0')}-"
      "${dt.day.toString().padLeft(2, '0')} "
      "${dt.hour.toString().padLeft(2, '0')}:"
      "${dt.minute.toString().padLeft(2, '0')}:00";

  // Reset UI state variables before making the search
  setState(() {
    selectedCategoryId = null;
    selectedCategoryName = 'Select Car Type';
    
    // Re-initialize KM plan to first active plan (same as initState)
    if (fetchedKmPlans.isNotEmpty) {
      selectedKmId = fetchedKmPlans.first.kmId;
      selectedKmLimit = fetchedKmPlans.first.kmLimit;
    } else {
      selectedKmId = null;
      selectedKmLimit = null;
    }

    showCarTypeOptions = false;
  });

  final searchRefresh = SearchModel(
    bookingFrom: formatDateTime(fromDateTimeRefresh),
    bookingTo: formatDateTime(toDateTimeRefresh),
    cityId: int.parse(
      selectedCityId ?? widget.selectedCityId,
    ),
    categoryId: null,
    kmId: selectedKmId != null ? int.tryParse(selectedKmId!) : null,
  );

  context.read<FetchCarsBloc>().add(
    FetchCarsButtonClickEvent(search: searchRefresh),
  );
  await Future.delayed(const Duration(milliseconds: 200));
},
                  child: BlocBuilder<FetchCarsBloc, FetchCarsState>(
                    builder: (context, state) {
                      // Loading -> show a scrollable with spinner so RefreshIndicator works
                      if (state is FetchCarsLoadingState) {
                        return Container(
                          color: Appcolors.kwhitecolor, // Full red background
                          child: Center(
                            child: RotatingSteeringWheel(
                              size: ResponsiveUtils.wp(
                                30,
                              ), // Adjust size as needed
                              steeringWheelAssetPath:
                                  Appconstants.splashlogo, // Your SVG path
                            ),
                          ),
                        );
                      }

                      // Success with empty result -> scrollable message
                      if (state is FetchCarsSuccessState) {
                        if (state.cars.isEmpty) {
                          return ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.wp(4),
                            ),
                            children: [
                              SizedBox(height: ResponsiveUtils.hp(20)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.directions_car_outlined,
                                    size: ResponsiveUtils.sp(15),
                                    color: Colors.grey,
                                  ),
                                  ResponsiveSizedBox.height10,
                                  ResponsiveText(
                                    'No cars available for selected criteria',
                                    color: Colors.grey,
                                    weight: FontWeight.w500,
                                  ),
                                ],
                              ),
                            ],
                          );
                        }

                        // Normal list
                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveUtils.wp(4),
                          ),
                          itemCount: state.cars.length,
                          itemBuilder: (context, index) =>
                              _buildCarCard(state.cars[index]),
                        );
                      }

                      // Error -> show scrollable error UI so refresh still works
                      if (state is FetchCarsErrorState) {
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveUtils.wp(4),
                          ),
                          children: [
                            SizedBox(height: ResponsiveUtils.hp(20)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: ResponsiveUtils.sp(15),
                                  color: Colors.red,
                                ),
                                ResponsiveSizedBox.height10,
                                ResponsiveText(
                                  'Failed to load cars',
                                  color: Colors.red,
                                  weight: FontWeight.w500,
                                ),
                                ResponsiveSizedBox.height10,
                                ElevatedButton(
                                  onPressed: _searchCars,
                                  child: ResponsiveText('Retry'),
                                ),
                              ],
                            ),
                          ],
                        );
                      }

                      return SizedBox.shrink();
                    },
                  ),
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

  Widget _buildCarCard(CarsModel car) {
    final bool available = !(car.soldOut ?? false);
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
          // Full overlay when unavailable
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

          // Content
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
                          child: car.image != null
                              ? Image.network(
                                  car.image!,
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
                                )
                              : Container(
                                  color: Colors.grey.shade200,
                                  child: Icon(
                                    Icons.directions_car,
                                    size: ResponsiveUtils.sp(8),
                                    color: Colors.grey,
                                  ),
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
                                '₹ ${(car.price ?? 0).toStringAsFixed((car.price ?? 0) == (car.price ?? 0).toInt() ? 0 : 2)}',
                                sizeFactor: 1.2,
                                weight: FontWeight.bold,
                              ),
                              if (available)
                                GestureDetector(
                                  onTap: () {
                                    _handleCheckoutNavigation(context, car);
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
                                (car.freeKms ?? 0).toString(),
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
                                '₹ ${(car.additionalPerKm ?? 0).toStringAsFixed(1)}/Km',
                                sizeFactor: 0.85,
                                weight: FontWeight.w600,
                                color: const Color(0xFFE74C3C),
                              ),
                            ],
                          ),

                          ResponsiveSizedBox.height10,

                          // Car Name
                          ResponsiveText(
                            car.modelName ?? 'Unknown Model',
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
                      '${car.seater ?? 0} Seater',
                    ),
                    ResponsiveSizedBox.width20,
                    _buildFeatureItem(
                      Appconstants.gearIcon,
                      car.transmission ?? 'Unknown',
                    ),
                    ResponsiveSizedBox.width20,
                    _buildFeatureItem(
                      Appconstants.petrolIcon,
                      car.fuelType ?? 'Unknown',
                    ),
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
