// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

// import 'package:intl/intl.dart';
// import 'package:qcms/core/colors.dart';
// import 'package:qcms/core/constants.dart';
// import 'package:qcms/presentation/blocs/fetch_notifications/fetch_notifications_bloc.dart';
// import 'package:qcms/widgets/custom_routes.dart';

// class NotificationPage extends StatefulWidget {
//   const NotificationPage({super.key});

//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<FetchNotificationsBloc>().add(
//       FetchNotificationsInitialEvent(),
//     );
//   }

//   Future<void> _onRefresh() async {
//     context.read<FetchNotificationsBloc>().add(
//       FetchNotificationsInitialEvent(),
//     );
    
//     // Wait for the bloc to complete the request
//     await Future.delayed(const Duration(milliseconds: 1500));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Appcolors.ksecondarycolor,
//         leading: IconButton(
//           onPressed: () {
//             CustomNavigation.pop(context);
//           },
//           icon: Icon(
//             Icons.chevron_left,
//             size: 30,
//             color: Appcolors.kwhitecolor,
//           ),
//         ),
//         title: TextStyles.subheadline(
//           text: 'Notifications',
//           color: Appcolors.kwhitecolor,
//         ),
//         centerTitle: true,
//       ),
//       body: BlocBuilder<FetchNotificationsBloc, FetchNotificationsState>(
//         builder: (context, state) {
//           if (state is FetchNotificationsLoadingState) {
//             return Center(
//               child: SpinKitCircle(size: 30, color: Appcolors.ksecondarycolor),
//             );
//           } else if (state is FetchNotificationsSuccessState) {
//             // Check if notifications list is empty
//             if (state.notifications.isEmpty) {
//               return RefreshIndicator(
//                 onRefresh: _onRefresh,
//                 color: Appcolors.ksecondarycolor,
//                 child: SingleChildScrollView(
//                   physics: const AlwaysScrollableScrollPhysics(),
//                   child: SizedBox(
//                     height: MediaQuery.of(context).size.height - 
//                            AppBar().preferredSize.height - 
//                            MediaQuery.of(context).padding.top,
//                     child: _buildEmptyState(),
//                   ),
//                 ),
//               );
//             }
            
//             // Show notifications list with RefreshIndicator
//             return RefreshIndicator(
//               onRefresh: _onRefresh,
//               color: Appcolors.ksecondarycolor,
//               child: ListView.builder(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 itemCount: state.notifications.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     margin: const EdgeInsets.only(
//                       right: 16,
//                       left: 16,
//                       top: 10,
//                     ),
//                     elevation: 0,
//                     color: Appcolors.kwhitecolor,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                       side: BorderSide(
//                         color: Colors.grey.withOpacity(0.2),
//                         width: 1,
//                       ),
//                     ),
//                     child: ListTile(
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       leading: const Icon(
//                         Icons.notifications_active_outlined,
//                         color: Appcolors.kprimarycolor,
//                         size: 24,
//                       ),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 4),
//                           Text(
//                             state.notifications[index].notification,
//                             style: TextStyle(
//                               color: Appcolors.kprimarycolor,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             _formatTime(
//                               DateTime.parse(
//                                 state.notifications[index].createdAt.date,
//                               ),
//                             ),
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey[500],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           } else if (state is FetchNotificationsErrorState) {
//             return RefreshIndicator(
//               onRefresh: _onRefresh,
//               color: Appcolors.ksecondarycolor,
//               child: SingleChildScrollView(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 child: SizedBox(
//                   height: MediaQuery.of(context).size.height - 
//                          AppBar().preferredSize.height - 
//                          MediaQuery.of(context).padding.top,
//                   child: Center(child: Text(state.message)),
//                 ),
//               ),
//             );
//           } else {
//             return const SizedBox.shrink();
//           }
//         },
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.notifications_off_outlined,
//             size: 80,
//             color: Colors.grey[400],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             "No notifications yet",
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[700],
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             "Pull down to refresh",
//             style: TextStyle(color: Colors.grey[600]),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatTime(DateTime time) {
//     final now = DateTime.now();
//     final difference = now.difference(time);

//     if (difference.inDays > 7) {
//       return DateFormat('MMM d, yyyy').format(time);
//     } else if (difference.inDays > 0) {
//       return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
//     } else if (difference.inMinutes > 0) {
//       return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
//     } else {
//       return 'Just now';
//     }
//   }
// }