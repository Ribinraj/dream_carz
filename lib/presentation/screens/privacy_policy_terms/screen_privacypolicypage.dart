import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';




class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
        title: TextStyles.subheadline(
          text: 'Privacy Policy',
          color: Appcolors.kwhitecolor,
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
            ResponsiveSizedBox.height20,
            _buildIntroSection(),
            ResponsiveSizedBox.height30,
            _buildSection(
              'Definitions',
              _getDefinitionsContent(),
            ),
            ResponsiveSizedBox.height30,
            _buildSection(
              'Provision of Rental Vehicle',
              _getProvisionContent(),
            ),
            ResponsiveSizedBox.height30,
            _buildSection(
              'General Terms',
              _getGeneralTermsContent(),
            ),
            ResponsiveSizedBox.height30,
            _buildSection(
              'Representations and Warranties by the Hirer',
              _getRepresentationsContent(),
            ),
            ResponsiveSizedBox.height30,
            _buildSection(
              'Remedies Available to the Owner',
              _getRemediesContent(),
            ),
            ResponsiveSizedBox.height30,
            _buildSection(
              'Indemnity',
              _getIndemnityContent(),
            ),
            ResponsiveSizedBox.height30,
            _buildSection(
              'Administrative and Legal Compliance',
              _getAdminComplianceContent(),
            ),
            ResponsiveSizedBox.height30,
            _buildSection(
              'Notice',
              _getNoticeContent(),
            ),
            ResponsiveSizedBox.height30,
            _buildSection(
              'Governing Law and Severability',
              _getGoverningLawContent(),
            ),
            ResponsiveSizedBox.height30,
            _buildContactSection(),
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
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadiusStyles.kradius15(),
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
          Text(
            'Terms & Conditions',
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(6),
              fontWeight: FontWeight.bold,
              color: Appcolors.kprimarycolor,
            ),
          ),
          ResponsiveSizedBox.height10,
          Text(
            'www.dreamcarz.live',
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(3.7),
              fontWeight: FontWeight.w600,
              color: Appcolors.ksecondarycolor,
            ),
          ),
          ResponsiveSizedBox.height10,
          Text(
            'DreamCarz having registered office situated at No. 10, New No. 26, 7th Main, 15th Cross, N S Palya, BTM 2nd Stage, Bangalore - 560076.',
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(3),
              color: Appcolors.kgreyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSection() {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Appcolors.ksecondarycolor.withOpacity(0.1),
        borderRadius: BorderRadiusStyles.kradius10(),
        border: Border.all(
          color: Appcolors.ksecondarycolor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        'Please read the terms of member agreement carefully before using or registering on the website or accessing any material, information or availing services through the website. If you do not agree with these terms, please do not use the website or avail any services being offered through the website.\n\nBy accessing this website, we assume you have agreed to these terms and conditions in full.',
        style: TextStyle(
          fontSize: ResponsiveUtils.sp(3.3),
          color: Appcolors.kblackcolor,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> content) {
    return Container(
      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadiusStyles.kradius15(),
        boxShadow: [
          BoxShadow(
            color: Appcolors.kgreyColor.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(4.8),
              fontWeight: FontWeight.w600,
              color: Appcolors.kprimarycolor,
            ),
          ),
          ResponsiveSizedBox.height15,
          ...content.map((text) => Padding(
                padding: EdgeInsets.only(bottom: ResponsiveUtils.hp(1.5)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: ResponsiveUtils.hp(0.8),
                        right: ResponsiveUtils.wp(2),
                      ),
                      width: ResponsiveUtils.wp(1.5),
                      height: ResponsiveUtils.wp(1.5),
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
                          color: Appcolors.kblackcolor.withOpacity(0.8),
                          height: 1.5,
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

  Widget _buildContactSection() {
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
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(4.8),
              fontWeight: FontWeight.w600,
              color: Appcolors.kwhitecolor,
            ),
          ),
          ResponsiveSizedBox.height10,
          Text(
            'If you have any questions regarding this privacy policy, you may contact us using the information provided on our website.',
            style: TextStyle(
              fontSize: ResponsiveUtils.sp(3.3),
              color: Appcolors.kwhitecolor,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getDefinitionsContent() {
    return [
      'Applicable Law(s): All relevant laws and regulations, including MVT Laws, as well as any statute, ordinance, rule, judgment, order, decree, by-law, directive, guideline, policy, or governmental requirement, along with official interpretations or enforcement by competent authorities.',
      'MVT Laws: Motor Vehicles Act, 1988, and associated rules, with any amendments or re-enactments.',
      'Reservation Details: The specific booking information of the Hirer and vehicle details.',
      'Schedule of Charges: Fees applicable to the Hirer as detailed in the schedule.',
      'Vehicle: The vehicle(s) rented by the Hirer under these terms.',
    ];
  }

  List<String> _getProvisionContent() {
    return [
      'Booking and Vehicle Allocation: Upon receiving a booking request, the Client will provide the requested vehicle for legitimate personal and/or official use on the date indicated in the reservation.',
      'Authorized Driver: The Hirer shall personally operate the vehicle. Any additional driver must have a valid driving license and their details furnished.',
      'Road and Permit Charges: The Hirer is responsible for all tolls, parking, interstate permits, and related expenses.',
      'Usage Compliance: The vehicle must be operated per manufacturer guidelines and in compliance with all applicable laws.',
      'Prohibited Uses: Includes carrying more passengers than allowed, transporting goods for hire, carrying animals, hazardous materials, engaging in illegal activities, participating in motorsports, towing, exceeding 100 km/h, driving under influence, or trips for rewards/records.',
      'Penalties for Misuse: Violations will incur penalties as per the Schedule of Charges.',
    ];
  }

  List<String> _getGeneralTermsContent() {
    return [
      'Eligibility and Liability: Hirer must be at least 21 years old, have at least 1 year of driving experience, and submit valid documents. The Hirer is fully responsible for any accident, malfunction, or loss during use.',
      'Vehicle Integrity and Tampering: No modifications or tampering. Any such actions will result in full liability for costs and penalties.',
    ];
  }

  List<String> _getRepresentationsContent() {
    return [
      'All information and documentation provided must be true and valid.',
      'No transfer, mortgage, sublease, sale, pledge, or disposal of the vehicle.',
      'No major modifications affecting resale or market value.',
      'Operate per Manufacturer\'s Manual with a valid license at all times.',
      'Use only for the stated booking purpose.',
      'No violation of agreement terms or actions that endanger the vehicle.',
    ];
  }

  List<String> _getRemediesContent() {
    return [
      'The Owner may repossess the vehicle without notice in case of default. The Hirer is liable for all related claims, costs, or damages arising from repossession.',
    ];
  }

  List<String> _getIndemnityContent() {
    return [
      'The Hirer agrees to indemnify the Owner against all liabilities, losses, damages, claims, and expenses related to third-party injury, property damage, theft, or breach of terms.',
      'The Owner may use and share documents/data with third parties and government agencies for verification purposes.',
    ];
  }

  List<String> _getAdminComplianceContent() {
    return [
      'The Owner may cooperate with authorities to comply with legal obligations, including accessing, retaining, or disclosing information without prior notice if necessary.',
    ];
  }

  List<String> _getNoticeContent() {
    return [
      'All notices must be in writing and sent via personal delivery, registered post, fax, or email to the provided contact details.',
    ];
  }

  List<String> _getGoverningLawContent() {
    return [
      'This agreement is governed by the laws of India.',
      'If any provision is deemed invalid, the remaining provisions remain in force.',
    ];
  }
}