import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RotatingSteeringWheel extends StatefulWidget {
  final double size;
  final String steeringWheelAssetPath;

  const RotatingSteeringWheel({
    Key? key,
    required this.size,
    required this.steeringWheelAssetPath,
  }) : super(key: key);

  @override
  _RotatingSteeringWheelState createState() => _RotatingSteeringWheelState();
}

class _RotatingSteeringWheelState extends State<RotatingSteeringWheel>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Rotation speed
      vsync: this,
    )..repeat(); // Infinite rotation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14159, // Full 360-degree rotation
          child: SvgPicture.asset(
            widget.steeringWheelAssetPath,
            width: widget.size,
            height: widget.size,
            colorFilter: const ColorFilter.mode(
              Colors.red, // White steering wheel on red background
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }
}
