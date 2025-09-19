// Custom Image Picker Widget - Reusable Component
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker {
  static void show({
    required BuildContext context,
    required String title,
    required Function(XFile?) onImageSelected,
    bool allowMultiple = false,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => ImagePickerBottomSheet(
        title: title,
        onImageSelected: onImageSelected,
        allowMultiple: allowMultiple,
      ),
    );
  }
}

class ImagePickerBottomSheet extends StatelessWidget {
  final String title;
  final Function(XFile?) onImageSelected;
  final bool allowMultiple;

  const ImagePickerBottomSheet({
    super.key,
    required this.title,
    required this.onImageSelected,
    this.allowMultiple = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(ResponsiveUtils.wp(4)),
      decoration: BoxDecoration(
        color: Appcolors.kwhitecolor,
        borderRadius: BorderRadiusStyles.kradius20(),
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: ResponsiveUtils.wp(15),
              height: ResponsiveUtils.hp(0.5),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusStyles.kradius10(),
              ),
            ),
            
            ResponsiveSizedBox.height20,
            
            // Title
            ResponsiveText(
              title,
              sizeFactor: 1.3,
              weight: FontWeight.bold,
              color: Appcolors.kblackcolor,
            ),
            
            ResponsiveSizedBox.height10,
            
            ResponsiveText(
              'Choose an option to upload your document',
              sizeFactor: 0.9,
              color: Colors.grey[600],
            ),
            
            ResponsiveSizedBox.height30,
            
            // Options
            Row(
              children: [
                Expanded(
                  child: _buildPickerOption(
                    context: context,
                    icon: Icons.camera_alt,
                    title: 'Camera',
                    subtitle: 'Take a photo',
                    onTap: () => _pickFromCamera(context),
                  ),
                ),
                ResponsiveSizedBox.width20,
                Expanded(
                  child: _buildPickerOption(
                    context: context,
                    icon: Icons.photo_library,
                    title: 'Gallery',
                    subtitle: 'Choose from gallery',
                    onTap: () => _pickFromGallery(context),
                  ),
                ),
              ],
            ),
            
            ResponsiveSizedBox.height30,
            
            // Cancel button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[400]!),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusStyles.kradius10(),
                  ),
                  padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(2)),
                ),
                child: ResponsiveText(
                  'Cancel',
                  sizeFactor: 1.0,
                  weight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),
            
            ResponsiveSizedBox.height20,
          ],
        ),
      ),
    );
  }

  Widget _buildPickerOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
        decoration: BoxDecoration(
          color: Appcolors.kprimarycolor.withOpacity(0.05),
          borderRadius: BorderRadiusStyles.kradius15(),
          border: Border.all(
            color: Appcolors.kprimarycolor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Container(
              width: ResponsiveUtils.wp(15),
              height: ResponsiveUtils.wp(15),
              decoration: BoxDecoration(
                color: Appcolors.kprimarycolor,
                borderRadius: BorderRadiusStyles.kradius10(),
              ),
              child: Icon(
                icon,
                size: ResponsiveUtils.sp(8),
                color: Appcolors.kwhitecolor,
              ),
            ),
            ResponsiveSizedBox.height15,
            ResponsiveText(
              title,
              sizeFactor: 1.0,
              weight: FontWeight.bold,
              color: Appcolors.kblackcolor,
            ),
            ResponsiveSizedBox.height5,
            ResponsiveText(
              subtitle,
              sizeFactor: 0.8,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }

  void _pickFromCamera(BuildContext context) async {
    Navigator.pop(context);
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      onImageSelected(image);
    } catch (e) {
      debugPrint('Error picking image from camera: $e');
    }
  }

  void _pickFromGallery(BuildContext context) async {
    Navigator.pop(context);
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      onImageSelected(image);
    } catch (e) {
      debugPrint('Error picking image from gallery: $e');
    }
  }
}