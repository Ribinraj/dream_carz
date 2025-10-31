import 'package:dream_carz/core/appconstants.dart';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/data/city_model.dart';
import 'package:dream_carz/presentation/blocs/fetch_banners_bloc/fetch_banners_bloc.dart';

import 'package:dream_carz/presentation/blocs/fetch_cities_bloc/fetch_cities_bloc.dart';

import 'package:dream_carz/presentation/screens/screen_homepage/widgets/carosal_widget.dart';
import 'package:dream_carz/presentation/screens/screen_homepage/widgets/date_time_selectionwidget.dart';
import 'package:dream_carz/presentation/screens/screen_networkpage/screen_networkpage.dart';
import 'package:dream_carz/presentation/screens/screen_notificationpage/screen_notification.dart';
import 'package:dream_carz/presentation/screens/screen_searchresultscreen.dart/screen_searchresultpage.dart';
import 'package:dream_carz/widgets/custom_drawer.dart';

//import 'package:dream_carz/widgets/custom_appbar.dart';
import 'package:dream_carz/widgets/custom_elevatedbutton.dart';

import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:dream_carz/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

class ScreenHomepage extends StatefulWidget {
  const ScreenHomepage({super.key});

  @override
  State<ScreenHomepage> createState() => _ScreenSearchPageState();
}

class _ScreenSearchPageState extends State<ScreenHomepage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime? fromDate;
  TimeOfDay? fromTime;
  DateTime? toDate;
  TimeOfDay? toTime;
  String? selectedCity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<FetchCitiesBloc>().add(FetchcitiesInitialEvent());
    context.read<FetchBannersBloc>().add(FetchBannersInitialEvnt());

    _initializeDefaultDateTime();
  }

  void _initializeDefaultDateTime() {
    final now = DateTime.now();

    // Set fromDate to today
    fromDate = DateTime(now.year, now.month, now.day);

    // Set fromTime to next available 30-minute slot
    if (now.minute >= 30) {
      // Next hour on the hour
      fromTime = TimeOfDay(hour: now.hour + 1, minute: 0);
    } else {
      // Current hour at 30 minutes
      fromTime = TimeOfDay(hour: now.hour, minute: 30);
    }

    // Optional: Auto-initialize "To" as well (12 hours after "From")
    final fromDateTime = DateTime(
      fromDate!.year,
      fromDate!.month,
      fromDate!.day,
      fromTime!.hour,
      fromTime!.minute,
    );

    final toDateTime = fromDateTime.add(const Duration(hours: 12));
    toDate = DateTime(toDateTime.year, toDateTime.month, toDateTime.day);
    toTime = TimeOfDay(hour: toDateTime.hour, minute: toDateTime.minute);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light, // White icons
        statusBarBrightness: Brightness.dark, // iOS
      ),
    );
    return ConnectivityAwareWidget(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color.fromARGB(255, 237, 235, 235),
        // appBar: const CustomAppBar(),
        drawer: const CustomDrawer(),
        body: Stack(
          children: [
            // Top Section with Carousel
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: double.infinity,
                  decoration: const BoxDecoration(color: Appcolors.kblackcolor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 TOP BAR (Icon + Text)
                      Padding(
                        padding: EdgeInsets.only(
                          top: ResponsiveUtils.hp(5),
                          left: ResponsiveUtils.wp(3),
                          right: ResponsiveUtils.wp(3),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.format_align_left_rounded,
                                color: Appcolors.kprimarycolor,
                              ),
                              onPressed: () {
                                _scaffoldKey.currentState?.openDrawer();
                              },
                            ),
                            // ResponsiveSizedBox.width10,
                            Image.asset(
                              Appconstants.dreamcartext, // your PNG file path
                              width: ResponsiveUtils.wp(
                                50,
                              ), // adjust width as needed
                              fit: BoxFit.contain,
                            ),
                            Spacer(),

                            IconButton(
                              onPressed: () {
                                CustomNavigation.pushWithTransition(
                                  context,
                                  NotificationPage(),
                                );
                              },
                              icon: Icon(
                                Icons.notifications,
                                color: Appcolors.kredcolor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // 🔹 CAROUSEL AS CARD
                      SizedBox(
                        height: ResponsiveUtils.hp(25),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveUtils.wp(3),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Card(
                              elevation: 6,
                              margin: EdgeInsets.zero,
                              clipBehavior: Clip.antiAlias,
                              child: const CarCarouselWidget(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Search Container
            Positioned(
              top: MediaQuery.of(context).size.height * 0.4,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(4),
                ),
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
                      BlocBuilder<FetchCitiesBloc, FetchCitiesState>(
                        builder: (context, state) {
                          if (state is FetchCitiesLoadingState) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: ResponsiveUtils.wp(4),
                                  vertical: ResponsiveUtils.hp(1.5),
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(10),
                                  border: Border.all(
                                    color: Colors.grey.withAlpha(22),
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadiusStyles.kradius10(),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 18,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      width: ResponsiveUtils.wp(30),
                                      height: ResponsiveUtils.hp(2),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }

                          if (state is FetchCitiesSuccessState) {
                            // Filter only Active cities
                            final activeCities = state.cities
                                .where(
                                  (c) => c.status.toLowerCase() == 'active',
                                )
                                .toList();

                            return Container(
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
                                      color: Appcolors.kprimarycolor.withAlpha(
                                        33,
                                      ),
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
                                  // selectedItemBuilder ensures the selected value shows the city name
                                  selectedItemBuilder: (BuildContext context) {
                                    return activeCities.map((CityModel city) {
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
                                              text: city.name,
                                              color: Appcolors.kblackcolor,
                                              weight: FontWeight.w500,
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList();
                                  },
                                  items: activeCities.map((CityModel city) {
                                    return DropdownMenuItem<String>(
                                      value: city.cityId, // store the id
                                      child: Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.symmetric(
                                          vertical: ResponsiveUtils.hp(1.2),
                                          horizontal: ResponsiveUtils.wp(2),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
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
                                              text: city.name,
                                              color: Appcolors.kblackcolor,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newCityId) {
                                    setState(() {
                                      selectedCity = newCityId;
                                    });
                                  },
                                ),
                              ),
                            );
                          } else if (state is FetchCitiesErrorState) {
                            return Center(child: Text(state.message));
                          } else {
                            // initial / other state
                            return SizedBox.shrink();
                          }
                        },
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
                            _buildFromDateTimeSection(
                              'From',
                              Appconstants.dateIcon,
                              (date, time) {
                                setState(() {
                                  fromDate = date;
                                  fromTime = time;
                                  // Reset toDate if it's now invalid
                                  if (toDate != null && toTime != null) {
                                    final fromDT = DateTime(
                                      fromDate!.year,
                                      fromDate!.month,
                                      fromDate!.day,
                                      fromTime!.hour,
                                      fromTime!.minute,
                                    );
                                    final toDT = DateTime(
                                      toDate!.year,
                                      toDate!.month,
                                      toDate!.day,
                                      toTime!.hour,
                                      toTime!.minute,
                                    );
                                    final minAllowed = fromDT.add(
                                      const Duration(hours: 12),
                                    );
                                    if (toDT.isBefore(minAllowed)) {
                                      toDate = null;
                                      toTime = null;
                                    }
                                  }
                                });
                              },
                            ),

                            ResponsiveSizedBox.height15,
                            Divider(thickness: .5),
                            ResponsiveSizedBox.height5,

                            // To Date/Time with 12-hour minimum gap
                            _buildToDateTimeSection(
                              'To',
                              Appconstants.dateIcon,
                              (date, time) {
                                setState(() {
                                  toDate = date;
                                  toTime = time;
                                });
                              },
                              DateTime(
                                fromDate!.year,
                                fromDate!.month,
                                fromDate!.day,
                                fromTime!.hour,
                                fromTime!.minute,
                              ).add(const Duration(hours: 12)),
                            ),
                            // // From Date/Time
                            // _buildDateTimeSection('From', Appconstants.dateIcon, (
                            //   date,
                            //   time,
                            // ) {
                            //   setState(() {
                            //     fromDate = date;
                            //     fromTime = time;
                            //   });
                            // }),

                            // ResponsiveSizedBox.height15,
                            // Divider(thickness: .5),

                            // ResponsiveSizedBox.height5,

                            // // To Date/Time
                            // _buildDateTimeSection('To', Appconstants.dateIcon, (
                            //   date,
                            //   time,
                            // ) {
                            //   setState(() {
                            //     toDate = date;
                            //     toTime = time;
                            //   });
                            // }),
                          ],
                        ),
                      ),

                      ResponsiveSizedBox.height20,
                      CustomElevatedButton(
                        onpress: () {
                          // 🔹 Step 1: make sure city & dates are picked
                          if (selectedCity == null ||
                              fromDate == null ||
                              fromTime == null ||
                              toDate == null ||
                              toTime == null) {
                            CustomSnackbar.show(
                              context,
                              message: 'Please complete all fields to continue',
                              type: SnackbarType.error,
                            );
                            return;
                          }

                          final fromDT = DateTime(
                            fromDate!.year,
                            fromDate!.month,
                            fromDate!.day,
                            fromTime!.hour,
                            fromTime!.minute,
                          );
                          final toDT = DateTime(
                            toDate!.year,
                            toDate!.month,
                            toDate!.day,
                            toTime!.hour,
                            toTime!.minute,
                          );

                          if (!toDT.isAfter(fromDT)) {
                            CustomSnackbar.show(
                              context,
                              message:
                                  'Drop date/time must be after pickup date/time',
                              type: SnackbarType.error,
                            );
                            return;
                          }

                          // ✅ only if all good → navigate
                          CustomNavigation.pushWithTransition(
                            context,
                            ScreenSearchresultpage(
                              fromDate: fromDate!,
                              fromTime: fromTime!,
                              toDate: toDate!,
                              toTime: toTime!,
                              selectedCityId: selectedCity!, // pass safely
                            ),
                          );
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

  Widget _buildFromDateTimeSection(
    String label,
    String svgAssetPath,
    Function(DateTime?, TimeOfDay?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              svgAssetPath,
              width: ResponsiveUtils.sp(4.5),
              height: ResponsiveUtils.sp(4.5),
              colorFilter: const ColorFilter.mode(
                Color(0xFFE74C3C),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            ResponsiveText(
              label,
              sizeFactor: 0.9,
              weight: FontWeight.w600,
              color: Appcolors.kblackcolor,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
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
          child: FromDateTimeSelectionWidget(
            onDateTimeChanged: onChanged,
            initialDate: fromDate,
            initialTime: fromTime,
          ),
        ),
      ],
    );
  }

  Widget _buildToDateTimeSection(
    String label,
    String svgAssetPath,
    Function(DateTime?, TimeOfDay?) onChanged,
    DateTime minDateTime,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              svgAssetPath,
              width: ResponsiveUtils.sp(4.5),
              height: ResponsiveUtils.sp(4.5),
              colorFilter: const ColorFilter.mode(
                Color(0xFFE74C3C),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            ResponsiveText(
              label,
              sizeFactor: 0.9,
              weight: FontWeight.w600,
              color: Appcolors.kblackcolor,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
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
          child: ToDateTimeSelectionWidget(
            key: ValueKey(
              minDateTime,
            ), // Force rebuild when minDateTime changes
            onDateTimeChanged: onChanged,
            minDateTime: minDateTime,
            initialDate: toDate,
            initialTime: toTime,
          ),
        ),
      ],
    );
  }


}
