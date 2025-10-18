// import 'package:dream_carz/core/colors.dart';
// import 'package:dream_carz/core/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:dream_carz/core/responsiveutils.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// // Booking model for hardcoded data
// class Booking {
//   final String id;
//   final String carName;
//   final String carImage;
//   final String pickupDate;
//   final String returnDate;
//   final String pickupLocation;
//   final String returnLocation;
//   final double totalPrice;
//   final BookingStatus status;

//   Booking({
//     required this.id,
//     required this.carName,
//     required this.carImage,
//     required this.pickupDate,
//     required this.returnDate,
//     required this.pickupLocation,
//     required this.returnLocation,
//     required this.totalPrice,
//     required this.status,
//   });
// }

// enum BookingStatus { upcoming, live, cancelled, completed }

// class ScreenMybookingpage extends StatefulWidget {
//   const ScreenMybookingpage({super.key});

//   @override
//   State<ScreenMybookingpage> createState() => _BookingsPageState();
// }

// class _BookingsPageState extends State<ScreenMybookingpage>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   int _currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 5, vsync: this);
//     _tabController.addListener(() {
//       setState(() {
//         _currentIndex = _tabController.index;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   // Hardcoded booking data
//   List<Booking> get allBookings => [
//     Booking(
//       id: "BK001",
//       carName: "BMW X5",
//       carImage:
//           'https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&w=2070&q=80',
//       pickupDate: "Dec 20, 2024",
//       returnDate: "Dec 25, 2024",
//       pickupLocation: "Mumbai Airport",
//       returnLocation: "Mumbai Airport",
//       totalPrice: 15000,
//       status: BookingStatus.upcoming,
//     ),
//     Booking(
//       id: "BK002",
//       carName: "Audi Q7",
//       carImage:
//           'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?auto=format&fit=crop&w=2127&q=80',
//       pickupDate: "Dec 18, 2024",
//       returnDate: "Dec 19, 2024",
//       pickupLocation: "Delhi NCR",
//       returnLocation: "Delhi NCR",
//       totalPrice: 8500,
//       status: BookingStatus.live,
//     ),
//     Booking(
//       id: "BK003",
//       carName: "Mercedes C-Class",
//       carImage:
//           'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?auto=format&fit=crop&w=2070&q=80',
//       pickupDate: "Dec 10, 2024",
//       returnDate: "Dec 12, 2024",
//       pickupLocation: "Bangalore City",
//       returnLocation: "Bangalore City",
//       totalPrice: 12000,
//       status: BookingStatus.cancelled,
//     ),
//     Booking(
//       id: "BK004",
//       carName: "Toyota Innova",
//       carImage:
//           'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?auto=format&fit=crop&w=2052&q=80',
//       pickupDate: "Nov 15, 2024",
//       returnDate: "Nov 18, 2024",
//       pickupLocation: "Pune Station",
//       returnLocation: "Pune Station",
//       totalPrice: 9500,
//       status: BookingStatus.completed,
//     ),
//     Booking(
//       id: "BK005",
//       carName: "Hyundai Creta",
//       carImage:
//           'https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&w=2070&q=80',
//       pickupDate: "Dec 22, 2024",
//       returnDate: "Dec 24, 2024",
//       pickupLocation: "Chennai Airport",
//       returnLocation: "Chennai Airport",
//       totalPrice: 7500,
//       status: BookingStatus.upcoming,
//     ),
//     Booking(
//       id: "BK006",
//       carName: "Mahindra Scorpio",
//       carImage:
//           'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?auto=format&fit=crop&w=2127&q=80',
//       pickupDate: "Oct 25, 2024",
//       returnDate: "Oct 28, 2024",
//       pickupLocation: "Kolkata City",
//       returnLocation: "Kolkata City",
//       totalPrice: 11000,
//       status: BookingStatus.completed,
//     ),
//   ];

//   List<Booking> getFilteredBookings() {
//     switch (_currentIndex) {
//       case 0: // All Bookings
//         return allBookings;
//       case 1: // Upcoming
//         return allBookings
//             .where((booking) => booking.status == BookingStatus.upcoming)
//             .toList();
//       case 2: // Live
//         return allBookings
//             .where((booking) => booking.status == BookingStatus.live)
//             .toList();
//       case 3: // Cancelled
//         return allBookings
//             .where((booking) => booking.status == BookingStatus.cancelled)
//             .toList();
//       case 4: // Completed
//         return allBookings
//             .where((booking) => booking.status == BookingStatus.completed)
//             .toList();
//       default:
//         return allBookings;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Appcolors.kbackgroundcolor,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Icon(
//             Icons.chevron_left,
//             size: ResponsiveUtils.wp(8),
//             color: Colors.black,
//           ),
//         ),
//         title: TextStyles.subheadline(
//           text: 'My Bookings',
//           color: const Color(0xFF1A365D),
//         ),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           // Custom Tab Bar
//           Container(
//             color: Appcolors.kwhitecolor,
//             child: Container(
//               color: Appcolors.kwhitecolor,
//               child: Container(
//                 height: ResponsiveUtils.hp(8),
//                 margin: EdgeInsets.all(ResponsiveUtils.wp(4)),
//                 padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
//                 decoration: BoxDecoration(
//                   color: Colors.grey[100],
//                   borderRadius: BorderRadiusStyles.kradius10(),
//                 ),
//                 child: TabBar(
//                   tabAlignment: TabAlignment.start,
//                   padding: EdgeInsets.all(0),
//                   controller: _tabController,
//                   isScrollable: true,
//                   dividerColor: Colors.transparent,
//                   indicatorSize: TabBarIndicatorSize.tab,
//                   indicator: BoxDecoration(
//                     color: Appcolors.kprimarycolor,
//                     borderRadius: BorderRadiusStyles.kradius5(),
//                   ),
//                   labelColor: Appcolors.kwhitecolor,
//                   unselectedLabelColor: Appcolors.kblackcolor,
//                   labelStyle: TextStyle(
//                     fontSize: ResponsiveUtils.sp(3.2),
//                     fontWeight: FontWeight.w600,
//                   ),
//                   unselectedLabelStyle: TextStyle(
//                     fontSize: ResponsiveUtils.sp(3.2),
//                     fontWeight: FontWeight.w500,
//                   ),
//                   labelPadding: EdgeInsets.symmetric(
//                     horizontal: ResponsiveUtils.wp(3),
//                     vertical: ResponsiveUtils.hp(0.5),
//                   ),
//                   tabs: const [
//                     Tab(text: 'All Bookings'),
//                     Tab(text: 'Upcoming'),
//                     Tab(text: 'Live'),
//                     Tab(text: 'Cancelled'),
//                     Tab(text: 'Completed'),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           // Bookings List
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: List.generate(
//                 5,
//                 (index) => BookingsList(bookings: getFilteredBookings()),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class BookingsList extends StatelessWidget {
//   final List<Booking> bookings;

//   const BookingsList({super.key, required this.bookings});

//   @override
//   Widget build(BuildContext context) {
//     if (bookings.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.event_busy,
//               size: ResponsiveUtils.sp(20),
//               color: Colors.grey[400],
//             ),
//             ResponsiveSizedBox.height20,
//             ResponsiveText(
//               'No bookings found',
//               sizeFactor: 1.2,
//               weight: FontWeight.w500,
//               color: Colors.grey[600],
//             ),
//           ],
//         ),
//       );
//     }

//     return ListView.builder(
//       padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//       itemCount: bookings.length,
//       itemBuilder: (context, index) {
//         return BookingCard(booking: bookings[index]);
//       },
//     );
//   }
// }

// class BookingCard extends StatelessWidget {
//   final Booking booking;

//   const BookingCard({super.key, required this.booking});

//   Color getStatusColor(BookingStatus status) {
//     switch (status) {
//       case BookingStatus.upcoming:
//         return Colors.blue;
//       case BookingStatus.live:
//         return Colors.green;
//       case BookingStatus.cancelled:
//         return Colors.red;
//       case BookingStatus.completed:
//         return Colors.grey;
//     }
//   }

//   String getStatusText(BookingStatus status) {
//     switch (status) {
//       case BookingStatus.upcoming:
//         return 'Upcoming';
//       case BookingStatus.live:
//         return 'Live';
//       case BookingStatus.cancelled:
//         return 'Cancelled';
//       case BookingStatus.completed:
//         return 'Completed';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
//       decoration: BoxDecoration(
//         color: Appcolors.kwhitecolor,
//         borderRadius: BorderRadiusStyles.kradius15(),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             spreadRadius: 1,
//             blurRadius: 10,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header with booking ID and status
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ResponsiveText(
//                   'Booking ID: ${booking.id}',
//                   sizeFactor: 0.9,
//                   weight: FontWeight.w600,
//                   color: Appcolors.kblackcolor,
//                 ),
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: ResponsiveUtils.wp(3),
//                     vertical: ResponsiveUtils.hp(0.5),
//                   ),
//                   decoration: BoxDecoration(
//                     color: getStatusColor(booking.status).withOpacity(0.1),
//                     borderRadius: BorderRadiusStyles.kradius5(),
//                     border: Border.all(
//                       color: getStatusColor(booking.status),
//                       width: 1,
//                     ),
//                   ),
//                   child: ResponsiveText(
//                     getStatusText(booking.status),
//                     sizeFactor: 0.75,
//                     weight: FontWeight.w600,
//                     color: getStatusColor(booking.status),
//                   ),
//                 ),
//               ],
//             ),

//             ResponsiveSizedBox.height15,

//             // Car details
//             Row(
//               children: [
//                 // Car image placeholder
//                 Container(
//                   width: ResponsiveUtils.wp(20),
//                   height: ResponsiveUtils.hp(8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadiusStyles.kradius10(),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadiusStyles.kradius10(),
//                     child: Image.network(
//                       booking.carImage,
//                       fit: BoxFit.cover,
//                       loadingBuilder: (context, child, progress) {
//                         if (progress == null) return child;
//                         return Center(
//                           child: SpinKitFadingCircle(
//                             size: ResponsiveUtils.wp(10),
//                             color: Appcolors.kgreyColor,
//                           ),
//                         );
//                       },
//                       errorBuilder: (context, error, stackTrace) {
//                         return Container(
//                           color: Colors.grey.shade200,
//                           child: Icon(
//                             Icons.directions_car,
//                             size: ResponsiveUtils.sp(8),
//                             color: Colors.grey,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),

//                 ResponsiveSizedBox.width20,

//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ResponsiveText(
//                         booking.carName,
//                         sizeFactor: 1,
//                         weight: FontWeight.bold,
//                         color: Appcolors.kblackcolor,
//                       ),
//                       ResponsiveSizedBox.height5,
//                       ResponsiveText(
//                         '₹${booking.totalPrice.toStringAsFixed(0)}',
//                         sizeFactor: 1,
//                         weight: FontWeight.bold,
//                         color: Appcolors.kprimarycolor,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             ResponsiveSizedBox.height15,

//             // Pickup and return details
//             Container(
//               padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
//               decoration: BoxDecoration(
//                 color: Colors.grey[50],
//                 borderRadius: BorderRadiusStyles.kradius10(),
//               ),
//               child: Column(
//                 children: [
//                   // Pickup details
//                   Row(
//                     children: [
//                       Container(
//                         width: ResponsiveUtils.wp(8),
//                         height: ResponsiveUtils.wp(8),
//                         decoration: BoxDecoration(
//                           color: Appcolors.kprimarycolor.withAlpha(150),
//                           borderRadius: BorderRadiusStyles.kradius5(),
//                         ),
//                         child: Icon(
//                           Icons.location_on,
//                           size: ResponsiveUtils.sp(4),
//                           color: Appcolors.kwhitecolor,
//                         ),
//                       ),
//                       ResponsiveSizedBox.width10,
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ResponsiveText(
//                               'Pickup',
//                               sizeFactor: 0.8,
//                               weight: FontWeight.w500,
//                               color: Colors.grey[600],
//                             ),
//                             ResponsiveText(
//                               '${booking.pickupDate} • ${booking.pickupLocation}',
//                               sizeFactor: 0.8,
//                               weight: FontWeight.w600,
//                               color: Appcolors.kblackcolor,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),

//                   ResponsiveSizedBox.height15,

//                   // Return details
//                   Row(
//                     children: [
//                       Container(
//                         width: ResponsiveUtils.wp(8),
//                         height: ResponsiveUtils.wp(8),
//                         decoration: BoxDecoration(
//                           color: Appcolors.kprimarycolor.withAlpha(150),
//                           borderRadius: BorderRadiusStyles.kradius5(),
//                         ),
//                         child: Icon(
//                           Icons.flag,
//                           size: ResponsiveUtils.sp(4),
//                           color: Appcolors.kwhitecolor,
//                         ),
//                       ),
//                       ResponsiveSizedBox.width10,
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ResponsiveText(
//                               'Return',
//                               sizeFactor: 0.8,
//                               weight: FontWeight.w500,
//                               color: Colors.grey[600],
//                             ),
//                             ResponsiveText(
//                               '${booking.returnDate} • ${booking.returnLocation}',
//                               sizeFactor: 0.8,
//                               weight: FontWeight.w600,
//                               color: Appcolors.kblackcolor,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             ResponsiveSizedBox.height15,
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////////////////////
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/presentation/blocs/my_orders_bloc/my_orders_bloc.dart';
import 'package:dream_carz/presentation/screens/screen_mydocuments/screen_mydocuments.dart';
import 'package:dream_carz/widgets/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dream_carz/data/ordermodel.dart';

import 'package:intl/intl.dart';

class ScreenMybookingpage extends StatefulWidget {
  const ScreenMybookingpage({super.key});

  @override
  State<ScreenMybookingpage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<ScreenMybookingpage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentIndex = _tabController.index;
      });
    });

    // Fetch orders on init
    context.read<MyOrdersBloc>().add(MyordersInitialFetchingEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Ordermodel> getFilteredBookings(List<Ordermodel> allBookings) {
    switch (_currentIndex) {
      case 0: // All Bookings
        return allBookings;
      case 1: // Upcoming
        return allBookings.where((booking) {
          final status = booking.status?.toLowerCase() ?? '';
          return status == 'Pending' || status == 'confirmed';
        }).toList();
      case 2: // Active/Live
        return allBookings.where((booking) {
          final status = booking.status?.toLowerCase() ?? '';
          return status == 'Active' || status == 'ongoing';
        }).toList();
      case 3: // Cancelled
        return allBookings.where((booking) {
          final status = booking.status?.toLowerCase() ?? '';
          return status == 'cancelled';
        }).toList();
      case 4: // Completed
        return allBookings.where((booking) {
          final status = booking.status?.toLowerCase() ?? '';
          return status == 'completed';
        }).toList();
      default:
        return allBookings;
    }
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
          text: 'My Bookings',
          color: const Color(0xFF1A365D),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Custom Tab Bar
          Container(
            color: Appcolors.kwhitecolor,
            child: Container(
              height: ResponsiveUtils.hp(8),
              margin: EdgeInsets.all(ResponsiveUtils.wp(4)),
              padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadiusStyles.kradius10(),
              ),
              child: TabBar(
                tabAlignment: TabAlignment.start,
                padding: EdgeInsets.zero,
                controller: _tabController,
                isScrollable: true,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Appcolors.kprimarycolor,
                  borderRadius: BorderRadiusStyles.kradius5(),
                ),
                labelColor: Appcolors.kwhitecolor,
                unselectedLabelColor: Appcolors.kblackcolor,
                labelStyle: TextStyle(
                  fontSize: ResponsiveUtils.sp(3.2),
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: ResponsiveUtils.sp(3.2),
                  fontWeight: FontWeight.w500,
                ),
                labelPadding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(3),
                  vertical: ResponsiveUtils.hp(0.5),
                ),
                tabs: const [
                  Tab(text: 'All Bookings'),
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Active'),
                  Tab(text: 'Cancelled'),
                  Tab(text: 'Completed'),
                ],
              ),
            ),
          ),

          // Bookings List with BLoC
          Expanded(
            child: BlocBuilder<MyOrdersBloc, MyOrdersState>(
              builder: (context, state) {
                if (state is MyordersLoadingState) {
                  return Center(
                    child: SpinKitFadingCircle(
                      size: ResponsiveUtils.wp(15),
                      color: Appcolors.kprimarycolor,
                    ),
                  );
                }

                if (state is MyordersErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: ResponsiveUtils.sp(20),
                          color: Colors.red[400],
                        ),
                        ResponsiveSizedBox.height20,
                        ResponsiveText(
                          state.message,
                          sizeFactor: 1,
                          weight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                        ResponsiveSizedBox.height20,
                        ElevatedButton(
                          onPressed: () {
                            context.read<MyOrdersBloc>().add(
                              MyordersInitialFetchingEvent(),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolors.kprimarycolor,
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.wp(8),
                              vertical: ResponsiveUtils.hp(1.5),
                            ),
                          ),
                          child: ResponsiveText(
                            'Retry',
                            sizeFactor: 1,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                if (state is MyordersSuccessState) {
                  final filteredBookings = getFilteredBookings(state.orders);

                  return TabBarView(
                    controller: _tabController,
                    children: List.generate(
                      5,
                      (index) => BookingsList(bookings: filteredBookings),
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookingsList extends StatelessWidget {
  final List<Ordermodel> bookings;

  const BookingsList({super.key, required this.bookings});

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.event_busy,
              size: ResponsiveUtils.sp(20),
              color: Colors.grey[400],
            ),
            ResponsiveSizedBox.height20,
            ResponsiveText(
              'No bookings found',
              sizeFactor: 1.2,
              weight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        return BookingCard(booking: bookings[index]);
      },
    );
  }
}

class BookingCard extends StatelessWidget {
  final Ordermodel booking;

  const BookingCard({super.key, required this.booking});

  Color getStatusColor(String? status) {
    final statusLower = status?.toLowerCase() ?? '';
    switch (statusLower) {
      case 'Pending':
      case 'confirmed':
        return Colors.blue;
      case 'Active':
      case 'ongoing':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'completed':
        return Colors.grey;
      default:
        return Colors.orange;
    }
  }

  String getStatusText(String? status) {
    if (status == null) return 'Unknown';
    return status[0].toUpperCase() + status.substring(1).toLowerCase();
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    return DateFormat('MMM dd, yyyy hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final hasDocuments = booking.documents?.isNotEmpty ?? false;
    final isDelivery = booking.fulfillment?.toLowerCase() == 'delivery';

    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with booking ID and status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ResponsiveText(
                    'Booking #${booking.bookingNumber ?? booking.bookingId ?? 'N/A'}',
                    sizeFactor: 0.9,
                    weight: FontWeight.w600,
                    color: Appcolors.kblackcolor,
                  ),
                ),
                ResponsiveSizedBox.width10,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.wp(3),
                    vertical: ResponsiveUtils.hp(0.5),
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(booking.status).withOpacity(0.1),
                    borderRadius: BorderRadiusStyles.kradius5(),
                    border: Border.all(
                      color: getStatusColor(booking.status),
                      width: 1,
                    ),
                  ),
                  child: ResponsiveText(
                    getStatusText(booking.status),
                    sizeFactor: 0.75,
                    weight: FontWeight.w600,
                    color: getStatusColor(booking.status),
                  ),
                ),
              ],
            ),

            ResponsiveSizedBox.height15,

            // Car details
            Row(
              children: [
                // Car image
                Container(
                  width: ResponsiveUtils.wp(20),
                  height: ResponsiveUtils.hp(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusStyles.kradius10(),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadiusStyles.kradius10(),
                    child: booking.model?.image != null
                        ? Image.network(
                            booking.model!.image!,
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

                ResponsiveSizedBox.width20,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveText(
                        booking.model?.modelName ?? 'Car Model',
                        sizeFactor: 1,
                        weight: FontWeight.bold,
                        color: Appcolors.kblackcolor,
                      ),
                      ResponsiveSizedBox.height5,
                      ResponsiveText(
                        '₹${booking.grandTotal ?? '0'}',
                        sizeFactor: 1,
                        weight: FontWeight.bold,
                        color: Appcolors.kprimarycolor,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ResponsiveSizedBox.height15,

            // Booking dates and location
            Container(
              padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadiusStyles.kradius10(),
              ),
              child: Column(
                children: [
                  // From details
                  Row(
                    children: [
                      Container(
                        width: ResponsiveUtils.wp(8),
                        height: ResponsiveUtils.wp(8),
                        decoration: BoxDecoration(
                          color: Appcolors.kprimarycolor.withAlpha(150),
                          borderRadius: BorderRadiusStyles.kradius5(),
                        ),
                        child: Icon(
                          Icons.calendar_today,
                          size: ResponsiveUtils.sp(4),
                          color: Appcolors.kwhitecolor,
                        ),
                      ),
                      ResponsiveSizedBox.width10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ResponsiveText(
                              'From',
                              sizeFactor: 0.8,
                              weight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                            ResponsiveText(
                              formatDate(booking.bookingFrom),
                              sizeFactor: 0.8,
                              weight: FontWeight.w600,
                              color: Appcolors.kblackcolor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  ResponsiveSizedBox.height15,

                  // To details
                  Row(
                    children: [
                      Container(
                        width: ResponsiveUtils.wp(8),
                        height: ResponsiveUtils.wp(8),
                        decoration: BoxDecoration(
                          color: Appcolors.kprimarycolor.withAlpha(150),
                          borderRadius: BorderRadiusStyles.kradius5(),
                        ),
                        child: Icon(
                          Icons.event_available,
                          size: ResponsiveUtils.sp(4),
                          color: Appcolors.kwhitecolor,
                        ),
                      ),
                      ResponsiveSizedBox.width10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ResponsiveText(
                              'To',
                              sizeFactor: 0.8,
                              weight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                            ResponsiveText(
                              formatDate(booking.bookingTo),
                              sizeFactor: 0.8,
                              weight: FontWeight.w600,
                              color: Appcolors.kblackcolor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ResponsiveSizedBox.height15,

            // Fulfillment details (Delivery/Pickup)
            Container(
              padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadiusStyles.kradius10(),
                border: Border.all(color: Colors.blue[200]!, width: 1),
              ),
              child: Row(
                children: [
                  Icon(
                    isDelivery ? Icons.local_shipping : Icons.store,
                    size: ResponsiveUtils.sp(5),
                    color: Appcolors.kprimarycolor,
                  ),
                  ResponsiveSizedBox.width10,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResponsiveText(
                          isDelivery ? 'Delivery' : 'Pickup',
                          sizeFactor: 0.85,
                          weight: FontWeight.w600,
                          color: Appcolors.kprimarycolor,
                        ),
                        if (isDelivery && booking.deliveryAddress != null) ...[
                          ResponsiveSizedBox.height5,
                          ResponsiveText(
                            booking.deliveryAddress!,
                            sizeFactor: 0.75,
                            weight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                          if (booking.deliveryContactName != null) ...[
                            ResponsiveSizedBox.height5,
                            ResponsiveText(
                              '${booking.deliveryContactName} • ${booking.deliveryContactMobile ?? ''}',
                              sizeFactor: 0.75,
                              weight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ],
                        ],
                        if (!isDelivery && booking.branch?.address != null) ...[
                          ResponsiveSizedBox.height5,
                          ResponsiveText(
                            booking.branch!.address!,
                            sizeFactor: 0.75,
                            weight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Document upload warning if no documents
            if (!hasDocuments) ...[
              ResponsiveSizedBox.height15,
              Container(
                padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                decoration: BoxDecoration(
                  color: Colors.orange[50],
                  borderRadius: BorderRadiusStyles.kradius10(),
                  border: Border.all(color: Colors.orange[300]!, width: 1),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          size: ResponsiveUtils.sp(5),
                          color: Colors.orange[700],
                        ),
                        ResponsiveSizedBox.width10,
                        Expanded(
                          child: ResponsiveText(
                            'Please upload documents to confirm your booking',
                            sizeFactor: 0.8,
                            weight: FontWeight.w500,
                            color: Colors.orange[900],
                          ),
                        ),
                      ],
                    ),
                    ResponsiveSizedBox.height10,
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          CustomNavigation.pushWithTransition(
                            context,
                            MyDocumentsPage(bookingId: booking.bookingId!),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[700],
                          padding: EdgeInsets.symmetric(
                            vertical: ResponsiveUtils.hp(1.5),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusStyles.kradius10(),
                          ),
                        ),
                        child: ResponsiveText(
                          'Upload Documents',
                          sizeFactor: 0.9,
                          weight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Additional booking details
            ResponsiveSizedBox.height15,
            Container(
              padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadiusStyles.kradius10(),
              ),
              child: Column(
                children: [
                  _buildDetailRow(
                    'Security Deposit',
                    '₹${booking.securityDeposit ?? '0'}',
                  ),
                  _buildDivider(),
                  _buildDetailRow(
                    'Delivery Charges',
                    '₹${booking.deliveryCharges ?? '0'}',
                  ),
                  _buildDivider(),
                  _buildDetailRow(
                    'Duration',
                    '${booking.duration ?? 'N/A'} days',
                  ),
                  _buildDivider(),
                  _buildDetailRow(
                    'Total Amount',
                    '₹${booking.grandTotal ?? '0'}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ResponsiveText(
            label,
            sizeFactor: isTotal ? 0.9 : 0.8,
            weight: isTotal ? FontWeight.bold : FontWeight.w500,
            color: isTotal ? Appcolors.kblackcolor : Colors.grey[700],
          ),
          ResponsiveText(
            value,
            sizeFactor: isTotal ? 0.95 : 0.8,
            weight: isTotal ? FontWeight.bold : FontWeight.w600,
            color: isTotal ? Appcolors.kprimarycolor : Appcolors.kblackcolor,
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(0.5)),
      child: Divider(color: Colors.grey[300], height: 1),
    );
  }
}
