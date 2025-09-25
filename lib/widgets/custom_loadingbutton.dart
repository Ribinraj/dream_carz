import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/responsiveutils.dart';

import 'package:flutter/material.dart';

class CustomSqureLoadingButton extends StatelessWidget {
  const CustomSqureLoadingButton({
    super.key,

    required this.loading,
    required this.color,
  });

  final Widget loading;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: ResponsiveUtils.hp(6.5),
      width: ResponsiveUtils.screenWidth,
      padding: EdgeInsets.symmetric(vertical: ResponsiveUtils.wp(1.5)),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: .5, color: Appcolors.kprimarycolor),
      ),
      child: Center(
        child:loading,
      ),
    );
  }
}
