import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';


class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

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
          'Terms & Conditions',
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
            _buildMainSection(
              'Documentation & Verification',
              [
                _buildSubSection('ID Verification', [
                  'To be eligible for a rental, the driver\'s license must be at least one year old as of the rental start date. At the time of vehicle pickup, the individual who made the booking must present either the original driving license or its authenticated DigiLocker version. Our representative will conduct a physical verification and collect one original identity document for record purposes. This verification is a mandatory step in the rental process. Failure to provide the required documents will result in the vehicle not being handed over, and the booking will be classified as a late cancellation, subject to a 100% fare charge.',
                ]),
                _buildSubSection('Age Criteria', [
                  'The minimum age requirement to rent a vehicle from DreamCarz is 21 years.',
                ]),
                _buildSubSection('Required Documents for KYC Verification', [
                  'Driving License — Must be valid and at least one year old.',
                  'Aadhaar Card — For identity and address verification.',
                  'Employment or Student Identification — Acceptable forms include Employee ID card, Student ID card, or GST Certificate for business owners.',
                  'For Bangalore Residents — Any one of the following: rental agreement, gas bill, communication bill, or PG accommodation bill.',
                  'For Non-Residents of Bangalore — Travel itinerary and hotel reservation details must be provided.',
                ]),
              ],
            ),
            ResponsiveSizedBox.height30,
            _buildMainSection(
              'Deposit, Cancellation & Reimbursement',
              [
                _buildSubSection('Security Deposit', [
                  'A refundable security deposit ranging from ₹1,500 to ₹4,000 will be collected at the time of booking. The deposit will be refunded within 7 bank working days after the end of the rental period, subject to verification of FASTag toll charges and any traffic violations. Please note that traffic violations may take 3-4 days to appear on official government portals following the conclusion of the booking.',
                ]),
                _buildSubSection('Cancellation and Charges', [
                  'Customers may cancel their booking under the following terms and applicable charges. Refunds will be processed via the original payment method within 7 bank working days.',
                  'Cancellation with 24+ hours\' notice before the scheduled start time: 80% refund of the booking amount.',
                  'Cancellation with less than 24 hours\' notice: 50% refund of the booking amount.',
                  'Bookings made within 12 hours of the rental start time are non-cancellable. Any cancellation request in such cases will incur a 100% penalty, and no refund will be issued.',
                ]),
                _buildSubSection('Fuel Reimbursement', [
                  'All kilometre-based packages are exclusive of fuel. Vehicles will be provided with sufficient fuel at the start of the trip, and customers are expected to return the vehicle with the same fuel level.',
                  'If the vehicle is returned with excess fuel, a refund may be issued only if the fuel level exceeds 20% more than the level at trip commencement. To claim this refund, customers must submit a valid fuel bill along with the vehicle number at the time of drop-off. Fuel bills submitted after the refund process is completed will not be eligible for reimbursement.',
                  'Fuel expenses will be reconciled based on the vehicle\'s standard fuel efficiency, using a conservative mileage estimate lower than the official ARAI (Automotive Research Association of India) rating. The fuel bill must be dated within the booking period, and handwritten bills will not be accepted.',
                ]),
                _buildSubSection('FASTag', [
                  'All DreamCarz vehicles are equipped with RFID FASTag for seamless travel across national highway tolls. Customers are required to recharge the FASTag based on their trip duration using PhonePe or Google Pay only. Please select IDFC Bank as the issuing bank and enter the vehicle number to complete the recharge.',
                  'Once the recharge is successful, a screenshot of the transaction receipt must be shared with our executive at the time of vehicle drop-off. If the FASTag balance is used without prior recharge, the customer will be liable to pay double the toll amount incurred.',
                  'Note: FASTag services are managed externally and not by DreamCarz. Therefore, we are not responsible for any issues related to double charges or toll discrepancies.',
                ]),
              ],
            ),
            ResponsiveSizedBox.height30,
            _buildMainSection(
              'Trip Modification',
              [
                _buildSubSection('Change in Pricing Plan (Without Fuel)', [
                  'Once a booking is confirmed, the selected pricing plan is final and cannot be modified.',
                ]),
                _buildSubSection('Pricing Plans and Extra Kilometres Charges', [
                  'To meet diverse customer needs, we offer multiple kilometre packages, each defined by a specific kilometre limit. The total kilometre allowance for your booking is calculated by multiplying the booking duration by the hourly kilometre limit of your selected pricing plan. If the vehicle is driven beyond this total kilometre limit, additional charges will apply for the extra kilometres. These charges vary depending on the car model and the city.',
                ]),
                _buildSubSection('Extension and Extra Hours', [
                  'Notify us at least 24 hours before the scheduled booking end time to request an extension.',
                  'Extensions are subject to vehicle availability and must be for a minimum duration of 6 hours.',
                  'A 1-hour buffer is provided beyond the booking end time at no additional cost.',
                  'If you inform us more than 6 hours in advance about a late drop-off, extra hours will be charged at ₹250/hour from the drop-off time.',
                  'If you fail to inform or inform within 6 hours of the booking end time, extra hours will be charged at ₹350/hour.',
                  'For any extension, you must share a complete video of the car\'s current condition.',
                ]),
                _buildSubSection('Rescheduling', [
                  'Rescheduling requests must be made at least 24 hours before the scheduled booking start time. Rescheduling is subject to vehicle availability, and the following conditions apply:',
                  'Start times cannot be advanced within 6 hours of the original booking start time.',
                  'The rescheduled duration must be equal to or longer than the original booking duration.',
                  'The selected kilometre package cannot be modified.',
                  'Tariffs may vary depending on weekday or weekend pricing.',
                ]),
                _buildSubSection('Interstate Trip', [
                  'Customers are responsible for covering all tolls and state permit fees. DreamCarz vehicles are registered with an All-India Permit, allowing entry into any state across India. Each vehicle is equipped with original documents, including the RC card, insurance, All-India Permit, and Self-Drive License. Customers must stop at the respective state border RTO check post to obtain a valid state entry permit by paying the applicable charges.',
                  'For travel to Andhra Pradesh or Kerala, inform DreamCarz customer care in advance so that a vehicle with a valid permit for the respective state can be allocated. If such a vehicle is not available, the customer will be responsible for obtaining the required state entry permit and paying the associated fees.',
                  'If a customer travels to another state without securing the necessary travel permit, a penalty will be imposed. The customer will be solely responsible for any legal consequences arising from such non-compliance.',
                  'An e-pass will not be considered a valid travel permit for inter-state vehicle movement.',
                ]),
                _buildSubSection('Swapping Vehicle', [
                  'Customers must notify us at least 24 hours before the booking start time for any changes. Requests will be accommodated based on vehicle availability, and applicable charges may vary depending on the car type.',
                ]),
              ],
            ),
            ResponsiveSizedBox.height30,
            _buildMainSection(
              'Damage & Accident',
              [
                _buildSubSection('Over Speeding', [
                  'The permitted speed range is between 80 km/h and 110 km/h. If the customer exceeds the 110 km/h limit, a charge of ₹500 per violation will be applied, in addition to any applicable government fines or penalties.',
                ]),
                _buildSubSection('Vehicle Damage', [
                  'In the event of customer negligence, including but not limited to failure to comply with applicable laws or the terms outlined in the DreamCarz Customer Agreement, or operating the vehicle under the influence of alcohol or narcotic substances, the customer will be liable as detailed below.',
                ]),
                _buildSubSection('Accident Policy', [
                  '1) General Liability for Damages\nIn the event of any damage to the vehicle, the customer shall be solely responsible for all associated losses—regardless of the cause or the party responsible.',
                  '2) Accident-Related Charges\nIn case of an accident, the customer is liable to pay up to ₹30,000 towards repair costs. The damage fee will be based on the repair estimate provided by an authorized dealership. Additionally, the customer will be charged for downtime losses, equivalent to the rental amount for the number of days the vehicle remains under repair.',
                  '3) Damages Exceeding ₹30,000\nIf repair costs exceed ₹30,000, a comprehensive insurance claim will be initiated. The customer will bear the difference between the insurance payout and the actual repair cost, along with applicable downtime losses as mentioned above. The customer shall bear the full cost of the accident, including downtime losses, until the insurance claim is successfully processed. Once the claim is approved and settled, the claimed amount will be refunded to the customer.',
                  '4) Total Loss Scenario\nIn case of total loss, a comprehensive insurance claim will be filed. The customer will be responsible for any estimation shortfall, parking charges, and downtime losses for up to 3 months, due to the extended claim process.',
                  '5) Documentation Requirement\nFor any damage during the rental period, the customer must obtain an FIR or NCR report from the nearest police station. Without these documents, insurance claims cannot be processed, and the customer will be liable for the entire damage cost, including standby charges. The customer is required to submit all original documents related to the insurance claim until the claim is successfully processed.',
                  '6) User Negligence or Alcohol-Related Incidents\nIn cases involving drunk driving or user negligence, the customer will be liable for the full cost of damages, with no insurance coverage.',
                  '7) Special Conditions & Exceptions\nIn certain cases of irresponsible, unsafe, or negligent usage, DreamCarz reserves the right to hold the customer liable for all damages, regardless of insurance eligibility. These include, but are not limited to:',
                  'Consequential Damage: Continuing to drive despite abnormal vehicle performance, as determined by the workshop or insurance provider.',
                  'Beach/Off-Road Driving: Strictly prohibited. A penalty of ₹10,000 will be charged, in addition to repair costs.',
                  'Illegal Usage: Use of DreamCarz vehicles for prohibited or unlawful activities will result in full legal liability for the customer.',
                  'Unauthorized Driver: If the person driving at the time of the incident is different from the one who made the booking.',
                  'Violation of Agreement or Law: Non-compliance with the DreamCarz Customer Agreement or applicable laws.',
                  'Driving Under Influence: Operating the vehicle under the influence of alcohol or narcotics.',
                  'Overloading: Exceeding the standard seating capacity of the vehicle.',
                  'Inter-State Tax Evasion: Failure to pay inter-state entry taxes.',
                  'False Documentation: Misrepresentation in driving license or ID proof.',
                  'Rash Driving: Clear evidence of reckless or negligent driving.',
                  'Traffic Violations: Breach of traffic rules or the Motor Vehicles Act.',
                ]),
              ],
            ),
            ResponsiveSizedBox.height30,
            _buildFooter(),
            ResponsiveSizedBox.height40,
          ],
        ),
      ),
    );
  }

  Widget _buildMainSection(String title, List<Widget> subsections) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kgreyColor.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(3),
              vertical: ResponsiveUtils.hp(1),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Appcolors.kprimarycolor,
                  Appcolors.ksecondarycolor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadiusStyles.kradius10(),
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: ResponsiveUtils.sp(5),
                fontWeight: FontWeight.bold,
                color: Appcolors.kwhitecolor,
              ),
            ),
          ),
          ResponsiveSizedBox.height20,
          ...subsections,
        ],
      ),
    );
  }

  Widget _buildSubSection(String title, List<String> content) {
    return Padding(
      padding: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(4.2),
              fontWeight: FontWeight.w600,
              color: Appcolors.kprimarycolor,
            ),
          ),
          ResponsiveSizedBox.height10,
          ...content.map((text) => Padding(
                padding: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: ResponsiveUtils.hp(0.6),
                        right: ResponsiveUtils.wp(2.5),
                      ),
                      width: ResponsiveUtils.wp(1.2),
                      height: ResponsiveUtils.wp(1.2),
                      decoration: BoxDecoration(
                        color: Appcolors.ksecondarycolor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.sp(3.3),
                          color: Appcolors.kblackcolor.withOpacity(0.85),
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildFooter() {
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Appcolors.kwhitecolor,
                size: ResponsiveUtils.sp(5),
              ),
              ResponsiveSizedBox.width10,
              Expanded(
                child: Text(
                  'Important Notice',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.sp(4.8),
                    fontWeight: FontWeight.bold,
                    color: Appcolors.kwhitecolor,
                  ),
                ),
              ),
            ],
          ),
          ResponsiveSizedBox.height15,
          Text(
            'By using DreamCarz services, you agree to comply with all terms and conditions outlined above. Failure to adhere to these terms may result in penalties, legal action, and/or termination of services.',
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(3.3),
              color: Appcolors.kwhitecolor,
              height: 1.5,
            ),
          ),
          ResponsiveSizedBox.height15,
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
            decoration: BoxDecoration(
              color: Appcolors.kwhitecolor.withOpacity(0.2),
              borderRadius: BorderRadiusStyles.kradius10(),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.contact_phone,
                  color: Appcolors.kwhitecolor,
                  size: ResponsiveUtils.sp(4.5),
                ),
                ResponsiveSizedBox.width10,
                Expanded(
                  child: Text(
                    'For any queries or clarifications, please contact DreamCarz customer support.',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.sp(3.1),
                      color: Appcolors.kwhitecolor,
                      height: 1.4,
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
}