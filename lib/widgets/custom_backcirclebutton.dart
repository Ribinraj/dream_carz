import 'package:dream_carz/core/colors.dart';
import 'package:flutter/material.dart';

class BackCircleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const BackCircleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),

      child: SizedBox(
        height: 40,
        width: 40,
        child: IconButton(
          icon: const Icon(Icons.chevron_left, color: Appcolors.kprimarycolor),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
