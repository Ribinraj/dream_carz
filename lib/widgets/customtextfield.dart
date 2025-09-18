import 'package:dream_carz/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:dream_carz/core/responsiveutils.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.isPassword = false,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(0.8)),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPassword ? _isObscured : false,
        keyboardType: widget.keyboardType,
        style: TextStyle(
          fontSize: ResponsiveUtils.sp(4),
          color: Appcolors.kblackcolor,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          prefixIcon: Icon(
            widget.prefixIcon,
            color: Appcolors.kgreyColor,
            size: ResponsiveUtils.sp(5.5),
          ),
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: Appcolors.kblackcolor,
                    size: ResponsiveUtils.sp(5.5),
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : null,
          labelStyle: TextStyle(
            fontSize: ResponsiveUtils.sp(3.5),
            color: Appcolors.kgreyColor,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(
            fontSize: ResponsiveUtils.sp(3.5),
            color: Colors.grey[400],
            fontWeight: FontWeight.w400,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(4),
            vertical: ResponsiveUtils.hp(1.8),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.borderRadius(3),
            ),
            borderSide: const BorderSide(
              color: Appcolors.kblackcolor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.borderRadius(3),
            ),
            borderSide: const BorderSide(
              color: Appcolors.kblackcolor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.borderRadius(3),
            ),
            borderSide: const BorderSide(
              color: Appcolors.kprimarycolor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.borderRadius(3),
            ),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              ResponsiveUtils.borderRadius(3),
            ),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          filled: true,
          fillColor: Appcolors.kwhitecolor,
          errorStyle: TextStyle(
            fontSize: ResponsiveUtils.sp(3),
            color: Colors.red,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
