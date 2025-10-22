import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';


class RefundCancellationPage extends StatelessWidget {
  const RefundCancellationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.kbackgroundcolor,
      appBar: AppBar(
        backgroundColor: Appcolors.kprimarycolor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Appcolors.kwhitecolor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Refund & Cancellation',
          style: TextStyle(
            fontSize: ResponsiveUtils.sp(4.8),
            fontWeight: FontWeight.w600,
            color: Appcolors.kwhitecolor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.wp(5),
          vertical: ResponsiveUtils.hp(2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            ResponsiveSizedBox.height30,
            _buildInfoCard(),
            ResponsiveSizedBox.height30,
            _buildCancellationCard(
              '24+ Hours Before',
              '80% Refund',
              'Cancel 24 hours or more before the scheduled start time',
              Icons.check_circle,
              Appcolors.kgreencolor,
              '80',
            ),
            ResponsiveSizedBox.height20,
            _buildCancellationCard(
              'Less Than 24 Hours',
              '50% Refund',
              'Cancel less than 24 hours before the scheduled start time',
              Icons.warning,
              Colors.orange,
              '50',
            ),
            ResponsiveSizedBox.height20,
            _buildCancellationCard(
              'Within 12 Hours',
              'No Refund',
              'Bookings made within 12 hours of rental start time are non-cancellable',
              Icons.cancel,
              Appcolors.kredcolor,
              '0',
            ),
            ResponsiveSizedBox.height30,
            _buildProcessingTimeCard(),
            ResponsiveSizedBox.height30,
            _buildImportantNotice(),
            ResponsiveSizedBox.height40,
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolors.kprimarycolor,
            Appcolors.ksecondarycolor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kprimarycolor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
            decoration: BoxDecoration(
              color: Appcolors.kwhitecolor.withOpacity(0.2),
              borderRadius: BorderRadiusStyles.kradius10(),
            ),
            child: Icon(
              Icons.policy,
              color: Appcolors.kwhitecolor,
              size: ResponsiveUtils.sp(8),
            ),
          ),
          ResponsiveSizedBox.width20,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cancellation Policy',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(5.5),
                    fontWeight: FontWeight.bold,
                    color: Appcolors.kwhitecolor,
                  ),
                ),
                ResponsiveSizedBox.height5,
                Text(
                  'Know your refund options',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(3.2),
                    color: Appcolors.kwhitecolor.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadiusStyles.kradius15(),
        border: Border.all(
          color: Appcolors.ksecondarycolor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kgreyColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Appcolors.kprimarycolor,
                size: ResponsiveUtils.sp(5),
              ),
              ResponsiveSizedBox.width10,
              Text(
                'General Information',
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(4.5),
                  fontWeight: FontWeight.bold,
                  color: Appcolors.kprimarycolor,
                ),
              ),
            ],
          ),
          ResponsiveSizedBox.height15,
          Text(
            'Customers may cancel their booking under the following terms and applicable charges. Refunds will be processed via the original payment method within 7 bank working days.',
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(3.4),
              color: Appcolors.kblackcolor.withOpacity(0.8),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCancellationCard(
    String title,
    String refundText,
    String description,
    IconData icon,
    Color color,
    String percentage,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.only(
                topLeft: BorderRadiusStyles.kradius15().topLeft,
                topRight: BorderRadiusStyles.kradius15().topRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(ResponsiveUtils.wp(2.5)),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: ResponsiveUtils.sp(6),
                  ),
                ),
                ResponsiveSizedBox.width10,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(4.5),
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      ResponsiveSizedBox.height5,
                      Text(
                        refundText,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(4),
                          fontWeight: FontWeight.w600,
                          color: Appcolors.kblackcolor,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: ResponsiveUtils.wp(3),
                    vertical: ResponsiveUtils.hp(1),
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadiusStyles.kradius10(),
                  ),
                  child: Text(
                    '$percentage%',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(5),
                      fontWeight: FontWeight.bold,
                      color: Appcolors.kwhitecolor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: ResponsiveUtils.hp(0.5),
                    right: ResponsiveUtils.wp(2),
                  ),
                  width: ResponsiveUtils.wp(1.2),
                  height: ResponsiveUtils.wp(1.2),
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(3.3),
                      color: Appcolors.kblackcolor.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProcessingTimeCard() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadiusStyles.kradius15(),
        border: Border.all(
          color: Appcolors.kprimarycolor.withOpacity(0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kgreyColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
            decoration: BoxDecoration(
              color: Appcolors.kprimarycolor.withOpacity(0.1),
              borderRadius: BorderRadiusStyles.kradius10(),
            ),
            child: Icon(
              Icons.access_time,
              color: Appcolors.kprimarycolor,
              size: ResponsiveUtils.sp(7),
            ),
          ),
          ResponsiveSizedBox.width10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Processing Time',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(4.5),
                    fontWeight: FontWeight.bold,
                    color: Appcolors.kprimarycolor,
                  ),
                ),
                ResponsiveSizedBox.height5,
                Text(
                  'Refunds processed within 7 bank working days',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(3.3),
                    color: Appcolors.kblackcolor.withOpacity(0.8),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImportantNotice() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Appcolors.kredcolor.withOpacity(0.8),
            Appcolors.kredcolor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kredcolor.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Appcolors.kwhitecolor,
                size: ResponsiveUtils.sp(6),
              ),
              ResponsiveSizedBox.width10,
              Text(
                'Important Notice',
                style: TextStyle(
                  fontSize: ResponsiveUtils.sp(5),
                  fontWeight: FontWeight.bold,
                  color: Appcolors.kwhitecolor,
                ),
              ),
            ],
          ),
          ResponsiveSizedBox.height15,
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
            decoration: BoxDecoration(
              color: Appcolors.kwhitecolor.withOpacity(0.2),
              borderRadius: BorderRadiusStyles.kradius10(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNoticePoint(
                  'Bookings made within 12 hours of the rental start time are non-cancellable.',
                ),
                ResponsiveSizedBox.height10,
                _buildNoticePoint(
                  'Any cancellation request in such cases will incur a 100% penalty.',
                ),
                ResponsiveSizedBox.height10,
                _buildNoticePoint(
                  'No refund will be issued for cancellations within 12 hours.',
                ),
              ],
            ),
          ),
          ResponsiveSizedBox.height15,
          Row(
            children: [
              Icon(
                Icons.payment,
                color: Appcolors.kwhitecolor,
                size: ResponsiveUtils.sp(4.5),
              ),
              ResponsiveSizedBox.width10,
              Expanded(
                child: Text(
                  'Refunds will be credited to the original payment method used during booking.',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(3.2),
                    color: Appcolors.kwhitecolor,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoticePoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            top: ResponsiveUtils.hp(0.5),
            right: ResponsiveUtils.wp(2),
          ),
          width: ResponsiveUtils.wp(1.5),
          height: ResponsiveUtils.wp(1.5),
          decoration: BoxDecoration(
            color: Appcolors.kwhitecolor,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(3.3),
              color: Appcolors.kwhitecolor,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}