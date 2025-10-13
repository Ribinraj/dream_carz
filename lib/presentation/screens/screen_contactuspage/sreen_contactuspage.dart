
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
  void initState() {
    // TODO: implement initState
    super.initState();
    //context.read<FetchContactBloc>().add(FetchcontactInitailEvent());
  }

  @override
  Widget build(BuildContext context) {
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
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We\'re here to help! Reach out through any of the channels below.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

            ResponsiveSizedBox.height20,

                   Column(
                    children: [
                      // Contact Methods
                      _buildContactItem(
                        icon: Icons.phone,
                        title: 'Phone',
                        subtitle:'9946802969',
                        description: 'Tap to call',
                        color: Colors.green,
                        onTap: () => _launchPhone('9946802969'),
                        onLongPress: () =>
                            _copyToClipboard('9946802969', 'Phone number'),
                      ),
            
                      ResponsiveSizedBox.height10,
            
                      _buildContactItem(
                        icon: Icons.email,
                        title: 'Email',
                        subtitle:'ribinrajop@gmail.com',
                        description:'ribinrajop@gmail.com',
                        color: Colors.orange,
                        onTap: () => _launchEmail('ribinrajop@gmail.com'),
                        onLongPress: () => _copyToClipboard(
                            'ribinrajop@gmail.com', 'Email address'),
                      ),
            
                      ResponsiveSizedBox.height10,
            
                      _buildContactItem(
                        icon: Icons.location_on,
                        title: 'Location',
                        subtitle:'Ribinrajop, ootupurath house, amaramblam south po, malappuram dt',
                        description: 'Tap to view on map',
                        color: Colors.red,
                        onTap: () {},
                        onLongPress: () {},
                      ),
            
                      ResponsiveSizedBox.height10,
            
                      _buildContactItem(
                        icon: Icons.language,
                        title: 'Website',
                        subtitle:'https://dreamcarz.live/',
                        description: 'Tap to visit website',
                        color: Colors.blue,
                        onTap: () => _launchURL('https://dreamcarz.live/'),
                        onLongPress: () => _copyToClipboard(
                            'https://dreamcarz.live/', 'Website URL'),
                      ),
            
                      ResponsiveSizedBox.height20,
            
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
                                  imagePath:
                                      'assets/images/facebook_2504903.png',
                                  color: const Color(0xFF1877F2),
                                  onTap: () =>
                                  ''
                                      //_launchURL(contact.fbLink),
                                ),
                                ResponsiveSizedBox.width20,
                                _buildSocialButtonWithImage(
                                  imagePath:
                                      'assets/images/instagram_2111463.png',
                                  color: const Color(0xFFE4405F),
                                  onTap: () =>
                                  ''
                                      //_launchURL(contact.instaLink),
                                ),
                                ResponsiveSizedBox.width20,
                                _buildSocialButtonWithImage(
                                  imagePath:
                                      'assets/images/whatsapp_3536445.png',
                                  color: const Color(0xFF25D366),
                                  onTap: () => _launchWhatsApp('9946802969',
                                      'Hello! I would like to get in touch.'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                
             

            ResponsiveSizedBox.height50
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String description,
    required Color color,
    required VoidCallback onTap,
    required VoidCallback onLongPress,
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
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
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

  Widget _buildHourRow(String day, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(fontSize: 14),
          ),
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: time == 'Closed' ? Colors.red : Colors.green,
            ),
          ),
        ],
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
        child: Image.asset(
          imagePath,
          height: 24,
          width: 24,
          // color: color, // Optional: apply color tint if needed
        ),
      ),
    );
  }

  /////////////////
  Future<void> _launchWhatsApp(String phoneNumber, [String? message]) async {
    try {
      // Remove any spaces, dashes, or special characters from phone number
      String cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

      // Ensure the number starts with country code
      if (!cleanNumber.startsWith('+')) {
        cleanNumber =
            '+91$cleanNumber'; // Add India country code if not present
      }

      // Create WhatsApp URL
      String whatsappUrl;
      if (message != null && message.isNotEmpty) {
        String encodedMessage = Uri.encodeComponent(message);
        whatsappUrl = 'https://wa.me/$cleanNumber?text=$encodedMessage';
      } else {
        whatsappUrl = 'https://wa.me/$cleanNumber';
      }

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
