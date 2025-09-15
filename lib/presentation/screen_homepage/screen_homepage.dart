import 'dart:developer';

import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/presentation/screen_homepage/widgets/carosal_widget.dart';
import 'package:dream_carz/presentation/screen_homepage/widgets/date_time_selectionwidget.dart';
import 'package:dream_carz/presentation/screen_searchresultscreen.dart/widgets/screen_searchresultpage.dart';

//import 'package:dream_carz/widgets/custom_appbar.dart';
import 'package:dream_carz/widgets/custom_elevatedbutton.dart';
import 'package:flutter/material.dart';

class ScreenHomepage extends StatefulWidget {
  const ScreenHomepage({super.key});

  @override
  State<ScreenHomepage> createState() => _ScreenSearchPageState();
}

class _ScreenSearchPageState extends State<ScreenHomepage> {
  DateTime? fromDate;
  TimeOfDay? fromTime;
  DateTime? toDate;
  TimeOfDay? toTime;
  String? selectedCity;

  // Hardcoded cities list - you can replace this with dynamic data later
  final List<String> cities = [
    'Bangalore',
    'Mumbai',
    'Delhi',
    'Chennai',
    'Kolkata',
    'Hyderabad',
    'Pune',
    'Ahmedabad',
    'Kochi',
    'Coimbatore',
    'Thiruvananthapuram',
    'Mysore',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 235, 235),
      // appBar: const CustomAppBar(),
      // drawer: const CustomDrawer(),
      body: Stack(
        children: [
          // Top Section with Carousel
          Column(
            children: [
              Container(
                height:
                    MediaQuery.of(context).size.height *
                    0.47, // 55% of screen height
                width: double.infinity,
                decoration: const BoxDecoration(color: Appcolors.kblackcolor),
                child: Stack(
                  children: [
                    // Carousel Widget
                    const CarCarouselWidget(),
                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withAlpha(77),
                            Colors.black.withAlpha(150),
                          ],
                        ),
                      ),
                    ),
                    // Text Content
                    Positioned(
                      top: ResponsiveUtils.hp(5),
                      left: ResponsiveUtils.wp(1),
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.format_align_left_rounded,
                              color: Appcolors.kprimarycolor,
                            ),
                            onPressed: () {
                              // Scaffold.of(context).openDrawer();
                            },
                          ),
                          ResponsiveSizedBox.width10,
                          TextStyles.headline(
                            text: 'Dream Carz',
                            color: Appcolors.kprimarycolor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Search Container
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(4)),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Appcolors.kwhitecolor,
                  borderRadius: BorderRadiusStyles.kradius15(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(10),
                      offset: const Offset(0, 8),
                      blurRadius: 30,
                      spreadRadius: 0,
                    ),
                    BoxShadow(
                      color: Colors.black.withAlpha(8),
                      offset: const Offset(0, 1),
                      blurRadius: 4,
                      spreadRadius: 0,
                    ),
                  ],
                  border: Border.all(
                    color: Colors.grey.withAlpha(33),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with icon
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Appcolors.kprimarycolor.withAlpha(33),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.search,
                            color: Appcolors.kprimarycolor,
                            size: ResponsiveUtils.wp(4),
                          ),
                        ),
                        ResponsiveSizedBox.width10,
                        TextStyles.subheadline(
                          text: 'Find Your Dream Car',
                          color: Appcolors.kblackcolor,
                        ),
                      ],
                    ),

                    ResponsiveSizedBox.height20,

                    // Location Selection with enhanced design
                    _buildSectionTitle('Select City', Icons.location_on),
                    ResponsiveSizedBox.height10,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(4),
                        vertical: ResponsiveUtils.hp(.3),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withAlpha(10),
                        border: Border.all(
                          color: Colors.grey.withAlpha(22),
                          width: 1.5,
                        ),
                        borderRadius: BorderRadiusStyles.kradius10(),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: selectedCity,
                          hint: Row(
                            children: [
                              Icon(
                                Icons.location_city,
                                color: Colors.grey.shade600,
                                size: 18,
                              ),
                              ResponsiveSizedBox.width10,
                              TextStyles.body(
                                text: 'Choose your city',
                                color: Colors.grey.shade600,
                              ),
                            ],
                          ),
                          icon: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Appcolors.kprimarycolor.withAlpha(33),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Appcolors.kprimarycolor,
                              size: 18,
                            ),
                          ),
                          isExpanded: true,
                          menuMaxHeight: 300,
                          dropdownColor: Appcolors.kwhitecolor,
                          borderRadius: BorderRadius.circular(12),
                          elevation: 8,
                          selectedItemBuilder: (BuildContext context) {
                            return cities.map((String city) {
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_city,
                                      color: Appcolors.kprimarycolor,
                                      size: 18,
                                    ),
                                    ResponsiveSizedBox.width10,
                                    TextStyles.body(
                                      text: city,
                                      color: Appcolors.kblackcolor,
                                      weight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              );
                            }).toList();
                          },
                          items: cities.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  vertical: ResponsiveUtils.hp(1.2),
                                  horizontal: ResponsiveUtils.wp(2),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.location_city,
                                      color: Colors.grey.shade600,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 12),
                                    TextStyles.body(
                                      text: city,
                                      color: Appcolors.kblackcolor,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCity = newValue;
                            });
                          },
                        ),
                      ),
                    ),

                    ResponsiveSizedBox.height15,

                    // Date/Time sections in a modern card layout
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Appcolors.kprimarycolor.withAlpha(33),
                            Appcolors.kprimarycolor.withAlpha(11),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadiusStyles.kradius10(),
                        border: Border.all(
                          color: Appcolors.kprimarycolor.withAlpha(33),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // From Date/Time
                          _buildDateTimeSection('From', Icons.departure_board, (
                            date,
                            time,
                          ) {
                            setState(() {
                              fromDate = date;
                              fromTime = time;
                            });
                          }),

                          ResponsiveSizedBox.height15,
                          Divider(thickness: .5),
    
                          ResponsiveSizedBox.height5,

                          // To Date/Time
                          _buildDateTimeSection('To', Icons.assignment_return, (
                            date,
                            time,
                          ) {
                            setState(() {
                              toDate = date;
                              toTime = time;
                            });
                          }),
                        ],
                      ),
                    ),

                    ResponsiveSizedBox.height20,

                    CustomElevatedButton(
                      onpress: () {
//                        Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => CarBookingScreen(), // <- target screen widget
//   ),
// );
                        // if (selectedCity != null &&
                        //     fromDate != null &&
                        //     fromTime != null &&
                        //     toDate != null &&
                        //     toTime != null) {
                        //   log('Selected City: $selectedCity');
                        //   log('From Date: ${fromDate.toString()}');
                        //   log('To Date: ${toDate.toString()}');
                        //   log('From Time: ${fromTime.toString()}');
                        //   log('To Time: ${toTime.toString()}');
                        //   //  navigatePush(context, const ScreenSearchResult());
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Row(
                        //         children: [
                        //           Icon(
                        //             Icons.warning_amber_rounded,
                        //             color: Colors.orange.shade300,
                        //           ),
                        //           const SizedBox(width: 8),
                        //           const Expanded(
                        //             child: Text(
                        //               'Please complete all fields to continue',
                        //               style: TextStyle(fontSize: 14),
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       backgroundColor: Colors.orange.shade100,
                        //       behavior: SnackBarBehavior.floating,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(12),
                        //       ),
                        //       margin: const EdgeInsets.all(16),
                        //     ),
                        //   );
                        // }
                      },
                      text: 'Find Carz',
                    ),
                  ],
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Appcolors.kprimarycolor, size: 18),
        const SizedBox(width: 8),
        TextStyles.body(
          text: title,
          weight: FontWeight.w600,
          color: Appcolors.kblackcolor,
        ),
      ],
    );
  }

  Widget _buildDateTimeSection(
    String label,
    IconData icon,
    Function(DateTime?, TimeOfDay?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(label, icon),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            // color: Appcolors.kwhitecolor,
            borderRadius: BorderRadiusStyles.kradius10(),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(11),
                offset: const Offset(0, 2),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: DateTimeSelectionWidget(onDateTimeChanged: onChanged),
        ),
      ],
    );
  }
}
