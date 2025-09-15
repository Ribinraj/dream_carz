import 'dart:async';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/material.dart';

class CarCarouselWidget extends StatefulWidget {
  const CarCarouselWidget({super.key});

  @override
  State<CarCarouselWidget> createState() => _CarCarouselWidgetState();
}

class _CarCarouselWidgetState extends State<CarCarouselWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;

  // Dummy car images - replace these URLs with your API data later
  final List<String> carImages = [
    'https://images.unsplash.com/photo-1550355291-bbee04a92027?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2127&q=80',
    'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
    'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2052&q=80',
  ];

  final List<String> carNames = [
    'BMW M4 Competition',
    'Mercedes-Benz AMG GT',
    'Audi R8 V10',
    'Porsche 911 GT3',
    'Ferrari 488 GTB',
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentIndex < carImages.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // PageView for carousel
        PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          itemCount: carImages.length,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(carImages[index]),
                  fit: BoxFit.cover,
                  onError: (error, stackTrace) {
                    // Fallback for network errors
                  },
                ),
              ),
              // child: Container(
              //   decoration: BoxDecoration(
              //     gradient: LinearGradient(
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //       colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
              //     ),
              //   ),
              //   child: Align(
              //     alignment: Alignment.bottomLeft,
              //     child: Padding(
              //       padding: const EdgeInsets.all(20.0),
              //       child: Column(
              //         mainAxisSize: MainAxisSize.min,
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             carNames[index],
              //             style: const TextStyle(
              //               color: Colors.white,
              //               fontSize: 24,
              //               fontWeight: FontWeight.bold,
              //               shadows: [
              //                 Shadow(
              //                   offset: Offset(0, 1),
              //                   blurRadius: 3.0,
              //                   color: Colors.black54,
              //                 ),
              //               ],
              //             ),
              //           ),
              //           const SizedBox(height: 8),
              //           Text(
              //             'Premium Luxury Car',
              //             style: TextStyle(
              //               color: Colors.white.withOpacity(0.9),
              //               fontSize: 16,
              //               fontWeight: FontWeight.w500,
              //               shadows: const [
              //                 Shadow(
              //                   offset: Offset(0, 1),
              //                   blurRadius: 2.0,
              //                   color: Colors.black54,
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            );
          },
        ),

        // Page indicators
        Positioned(
          top: ResponsiveUtils.hp(31),
          right: ResponsiveUtils.wp(40),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(100),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                carImages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentIndex == index ? 12 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentIndex == index
                        ? Appcolors.kprimarycolor.withAlpha(150)
                        : Appcolors.kwhitecolor.withAlpha(150),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ),
        ),

        // // Navigation arrows (optional)
        // Positioned(
        //   left: 16,
        //   top: 0,
        //   bottom: 0,
        //   child: Center(
        //     child: GestureDetector(
        //       onTap: () {
        //         if (_currentIndex > 0) {
        //           _currentIndex--;
        //           _pageController.animateToPage(
        //             _currentIndex,
        //             duration: const Duration(milliseconds: 300),
        //             curve: Curves.easeInOut,
        //           );
        //         }
        //       },
        //       child: Container(
        //         padding: const EdgeInsets.all(8),
        //         decoration: BoxDecoration(
        //           color: Colors.black.withOpacity(0.3),
        //           shape: BoxShape.circle,
        //         ),
        //         child: Icon(
        //           Icons.arrow_back_ios,
        //           color: Colors.white.withOpacity(0.8),
        //           size: 20,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),

        // Positioned(
        //   right: 16,
        //   top: 0,
        //   bottom: 0,
        //   child: Center(
        //     child: GestureDetector(
        //       onTap: () {
        //         if (_currentIndex < carImages.length - 1) {
        //           _currentIndex++;
        //           _pageController.animateToPage(
        //             _currentIndex,
        //             duration: const Duration(milliseconds: 300),
        //             curve: Curves.easeInOut,
        //           );
        //         }
        //       },
        //       child: Container(
        //         padding: const EdgeInsets.all(8),
        //         decoration: BoxDecoration(
        //           color: Colors.black.withOpacity(0.3),
        //           shape: BoxShape.circle,
        //         ),
        //         child: Icon(
        //           Icons.arrow_forward_ios,
        //           color: Colors.white.withOpacity(0.8),
        //           size: 20,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
