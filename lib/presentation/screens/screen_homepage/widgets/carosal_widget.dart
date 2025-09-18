import 'dart:async';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:flutter/material.dart';

// class CarCarouselWidget extends StatefulWidget {
//   const CarCarouselWidget({super.key});

//   @override
//   State<CarCarouselWidget> createState() => _CarCarouselWidgetState();
// }

// class _CarCarouselWidgetState extends State<CarCarouselWidget> {
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;
//   Timer? _timer;

//   // Dummy car images - replace these URLs with your API data later
//   final List<String> carImages = [
//     'https://images.unsplash.com/photo-1550355291-bbee04a92027?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
//     'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2127&q=80',
//     'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80',
//     'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2052&q=80',
//   ];

//   final List<String> carNames = [
//     'BMW M4 Competition',
//     'Mercedes-Benz AMG GT',
//     'Audi R8 V10',
//     'Porsche 911 GT3',
//     'Ferrari 488 GTB',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _startAutoSlide();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();
//     _pageController.dispose();
//     super.dispose();
//   }

//   void _startAutoSlide() {
//     _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
//       if (_currentIndex < carImages.length - 1) {
//         _currentIndex++;
//       } else {
//         _currentIndex = 0;
//       }

//       if (_pageController.hasClients) {
//         _pageController.animateToPage(
//           _currentIndex,
//           duration: const Duration(milliseconds: 600),
//           curve: Curves.easeInOut,
//         );
//       }
//     });
//   }

//   void _onPageChanged(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         // PageView for carousel
//         PageView.builder(
//           controller: _pageController,
//           onPageChanged: _onPageChanged,
//           itemCount: carImages.length,
//           itemBuilder: (context, index) {
//             return Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: NetworkImage(carImages[index]),
//                   fit: BoxFit.cover,
//                   onError: (error, stackTrace) {
//                     // Fallback for network errors
//                   },
//                 ),
//               ),
//             );
//           },
//         ),

//         // Page indicators
//         Positioned(
//           top: ResponsiveUtils.hp(31),
//           right: ResponsiveUtils.wp(40),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             decoration: BoxDecoration(
//               color: Colors.black.withAlpha(100),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: List.generate(
//                 carImages.length,
//                 (index) => Container(
//                   margin: const EdgeInsets.symmetric(horizontal: 3),
//                   width: _currentIndex == index ? 12 : 8,
//                   height: 8,
//                   decoration: BoxDecoration(
//                     color: _currentIndex == index
//                         ? Appcolors.kprimarycolor.withAlpha(150)
//                         : Appcolors.kwhitecolor.withAlpha(150),
//                     borderRadius: BorderRadius.circular(4),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
class CarCarouselWidget extends StatefulWidget {
  const CarCarouselWidget({super.key});

  @override
  State<CarCarouselWidget> createState() => _CarCarouselWidgetState();
}

class _CarCarouselWidgetState extends State<CarCarouselWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  bool _isUserInteracting = false;

  final List<String> carImages = [
    'https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&w=2070&q=80',
    'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?auto=format&fit=crop&w=2127&q=80',
    'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?auto=format&fit=crop&w=2070&q=80',
    'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?auto=format&fit=crop&w=2052&q=80',
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
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_isUserInteracting) return;
      if (!mounted) return;

      int next = _currentIndex + 1;
      if (next >= carImages.length) {
        next = 0; // 🔄 Loop back to first image
      }

      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  void _pauseAutoSlide() {
    setState(() => _isUserInteracting = true);
  }

  void _resumeAutoSlide() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => _isUserInteracting = false);
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  void _goToPage(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => _pauseAutoSlide(),
      onPointerUp: (_) => _resumeAutoSlide(),
      onPointerCancel: (_) => _resumeAutoSlide(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollStartNotification) {
            _pauseAutoSlide();
          } else if (notification is ScrollEndNotification) {
            _resumeAutoSlide();
          }
          return false;
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: carImages.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTapDown: (_) => _pauseAutoSlide(),
                  onTapUp: (_) => _resumeAutoSlide(),
                  onTapCancel: () => _resumeAutoSlide(),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(carImages[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),

            // Indicators (bottom-right)
            Positioned(
              right: ResponsiveUtils.wp(3),
              bottom: ResponsiveUtils.hp(1.6),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(3),
                  vertical: ResponsiveUtils.hp(.6),
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(carImages.length, (index) {
                    final bool active = index == _currentIndex;
                    return GestureDetector(
                      onTap: () => _goToPage(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.wp(.6),
                        ),
                        width: active
                            ? ResponsiveUtils.wp(3.2)
                            : ResponsiveUtils.wp(2.2),
                        height: ResponsiveUtils.hp(1.1),
                        decoration: BoxDecoration(
                          color: active
                              ? Appcolors.kprimarycolor.withOpacity(0.95)
                              : Appcolors.kwhitecolor.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
