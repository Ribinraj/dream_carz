import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  Future<void> _launchURL(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar('Could not launch $url');
      }
    } catch (e) {
      _showErrorSnackBar('Error launching URL: $e');
    }
  }

  Future<void> _launchEmail(String email) async {
    try {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
        query: 'subject=Contact%20Inquiry',
      );
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        _showErrorSnackBar('Could not launch email client');
      }
    } catch (e) {
      _showErrorSnackBar('Error launching email: $e');
    }
  }

  Future<void> _launchPhone(String phone) async {
    try {
      final Uri phoneUri = Uri(scheme: 'tel', path: phone);
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        _showErrorSnackBar('Could not launch phone dialer');
      }
    } catch (e) {
      _showErrorSnackBar('Error launching phone: $e');
    }
  }

  void _copyToClipboard(String text, String type) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$type copied to clipboard'),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const phoneNumber = '+919482166001';
    const emailAddress = 'support@dreamcarz.live';
    const addressPlain =
        '10 New No 26, 7th Main, 15th Cross Rd,\nNS Palya, BTM 2nd Stage,\nBengaluru, Karnataka 560076';

    return Scaffold(
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
          text: 'Contact Us',
          color: const Color(0xFF1A365D),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.contact_support,
                    size: 48,
                    color: Appcolors.ksecondarycolor,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Get in Touch',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We\'re here to help! Reach out through any of the channels below.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            ResponsiveSizedBox.height20,

            // Contact Items
            Column(
              children: [
                _buildContactItem(
                  icon: Icons.phone,
                  title: 'Phone',
                  subtitle: '(+91) 948 216 6001',
                  description: 'Tap to call',
                  color: Colors.green,
                  onTap: () => _launchPhone(phoneNumber),
                  onLongPress: () =>
                      _copyToClipboard(phoneNumber, 'Phone number'),
                ),
                ResponsiveSizedBox.height10,
                _buildContactItem(
                  icon: Icons.email,
                  title: 'Email',
                  subtitle: emailAddress,
                  description: 'Tap to send email',
                  color: Colors.orange,
                  onTap: () => _launchEmail(emailAddress),
                  onLongPress: () =>
                      _copyToClipboard(emailAddress, 'Email address'),
                ),
                ResponsiveSizedBox.height10,
                _buildContactItem(
                  icon: Icons.location_on,
                  title: 'Location',
                  subtitle: 'Bengaluru, Karnataka',
                  // Provide a RichText widget for styled address.
                  descriptionWidget: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: '365DAYNEEDS\n',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: addressPlain,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  color: Colors.red,
                  onTap: () => _launchURL(
                    'https://maps.google.com/?q=Dream+Carz+BTM+2nd+Stage+Bengaluru',
                  ),
                  onLongPress: () =>
                      _copyToClipboard('365DAYNEEDS\n$addressPlain', 'Address'),
                ),
                ResponsiveSizedBox.height10,
                _buildContactItem(
                  icon: Icons.language,
                  title: 'Website',
                  subtitle: 'https://dreamcarz.live/',
                  description: 'Tap to visit website',
                  color: Colors.blue,
                  onTap: () => _launchURL('https://dreamcarz.live/'),
                  onLongPress: () => _copyToClipboard(
                    'https://dreamcarz.live/',
                    'Website URL',
                  ),
                ),
                ResponsiveSizedBox.height20,

                // Social Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Follow Us',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ResponsiveSizedBox.height10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildSocialButtonWithImage(
                            imagePath: 'assets/images/facebook_2504903.png',
                            color: const Color(0xFF1877F2),
                            onTap: () {
                              _launchURL(
                                "https://www.facebook.com/people/DREAMcarz/61580293407628/",
                              );
                            },
                          ),
                          ResponsiveSizedBox.width20,
                          _buildSocialButtonWithImage(
                            imagePath: 'assets/images/instagram_2111463.png',
                            color: const Color(0xFFE4405F),
                            onTap: () {
                              _launchURL(
                                "https://www.instagram.com/dreamcarz._/#",
                              );
                            },
                          ),
                          ResponsiveSizedBox.width20,
                          _buildSocialButtonWithImage(
                            imagePath: 'assets/images/whatsapp_3536445.png',
                            color: const Color(0xFF25D366),
                            onTap: () => _launchWhatsApp(
                              phoneNumber,
                              'Hello! I would like to get in touch.',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ResponsiveSizedBox.height50,
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
    required VoidCallback onLongPress,
    String? description,
    Widget? descriptionWidget,
  }) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (descriptionWidget != null) descriptionWidget,
                  if (descriptionWidget == null && description != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        description,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButtonWithImage({
    required String imagePath,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Image.asset(imagePath, height: 24, width: 24),
      ),
    );
  }

  Future<void> _launchWhatsApp(String phoneNumber, [String? message]) async {
    try {
      String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
      if (!cleanNumber.startsWith('+')) {
        cleanNumber = '+91$cleanNumber';
      }

      String whatsappUrl = message != null && message.isNotEmpty
          ? 'https://wa.me/$cleanNumber?text=${Uri.encodeComponent(message)}'
          : 'https://wa.me/$cleanNumber';

      final Uri uri = Uri.parse(whatsappUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        _showErrorSnackBar('Could not launch WhatsApp');
      }
    } catch (e) {
      _showErrorSnackBar('Error launching WhatsApp: $e');
    }
  }
}
