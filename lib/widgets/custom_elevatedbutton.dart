import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/constants.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onpress,
    required this.text,
  });
  final VoidCallback onpress;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onpress,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusStyles.custom(sizeFactor: 10),
          ),
          backgroundColor: Appcolors.kprimarycolor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Appcolors.kwhitecolor,
            ),
          ),
        ),
      ),
    );
  }
}
