// import 'dart:async';
// import 'package:dream_carz/core/colors.dart';
// import 'package:dream_carz/core/responsiveutils.dart';
// import 'package:flutter/material.dart';


// class CarCarouselWidget extends StatefulWidget {
//   const CarCarouselWidget({super.key});

//   @override
//   State<CarCarouselWidget> createState() => _CarCarouselWidgetState();
// }

// class _CarCarouselWidgetState extends State<CarCarouselWidget> {
//   final PageController _pageController = PageController();
//   int _currentIndex = 0;
//   Timer? _timer;
//   bool _isUserInteracting = false;

//   final List<String> carImages = [
//     'https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&w=2070&q=80',
//     'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?auto=format&fit=crop&w=2127&q=80',
//     'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?auto=format&fit=crop&w=2070&q=80',
//     'https://images.unsplash.com/photo-1525609004556-c46c7d6cf023?auto=format&fit=crop&w=2052&q=80',
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
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 4), (_) {
//       if (_isUserInteracting) return;
//       if (!mounted) return;

//       int next = _currentIndex + 1;
//       if (next >= carImages.length) {
//         next = 0; // 🔄 Loop back to first image
//       }

//       _pageController.animateToPage(
//         next,
//         duration: const Duration(milliseconds: 600),
//         curve: Curves.easeInOut,
//       );
//     });
//   }

//   void _pauseAutoSlide() {
//     setState(() => _isUserInteracting = true);
//   }

//   void _resumeAutoSlide() {
//     Future.delayed(const Duration(milliseconds: 300), () {
//       if (mounted) {
//         setState(() => _isUserInteracting = false);
//       }
//     });
//   }

//   void _onPageChanged(int index) {
//     setState(() => _currentIndex = index);
//   }

//   void _goToPage(int index) {
//     _pageController.animateToPage(
//       index,
//       duration: const Duration(milliseconds: 400),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Listener(
//       onPointerDown: (_) => _pauseAutoSlide(),
//       onPointerUp: (_) => _resumeAutoSlide(),
//       onPointerCancel: (_) => _resumeAutoSlide(),
//       child: NotificationListener<ScrollNotification>(
//         onNotification: (notification) {
//           if (notification is ScrollStartNotification) {
//             _pauseAutoSlide();
//           } else if (notification is ScrollEndNotification) {
//             _resumeAutoSlide();
//           }
//           return false;
//         },
//         child: Stack(
//           fit: StackFit.expand,
//           children: [
//             PageView.builder(
//               controller: _pageController,
//               onPageChanged: _onPageChanged,
//               itemCount: carImages.length,
//               physics: const BouncingScrollPhysics(),
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                   onTapDown: (_) => _pauseAutoSlide(),
//                   onTapUp: (_) => _resumeAutoSlide(),
//                   onTapCancel: () => _resumeAutoSlide(),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: NetworkImage(carImages[index]),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),

//             // Indicators (bottom-right)
//             Positioned(
//               right: ResponsiveUtils.wp(3),
//               bottom: ResponsiveUtils.hp(1.6),
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: ResponsiveUtils.wp(3),
//                   vertical: ResponsiveUtils.hp(.6),
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.45),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: List.generate(carImages.length, (index) {
//                     final bool active = index == _currentIndex;
//                     return GestureDetector(
//                       onTap: () => _goToPage(index),
//                       child: AnimatedContainer(
//                         duration: const Duration(milliseconds: 250),
//                         margin: EdgeInsets.symmetric(
//                           horizontal: ResponsiveUtils.wp(.6),
//                         ),
//                         width: active
//                             ? ResponsiveUtils.wp(3.2)
//                             : ResponsiveUtils.wp(2.2),
//                         height: ResponsiveUtils.hp(1.1),
//                         decoration: BoxDecoration(
//                           color: active
//                               ? Appcolors.kprimarycolor.withOpacity(0.95)
//                               : Appcolors.kwhitecolor.withOpacity(0.9),
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
/////////////////////////////////
import 'dart:async';
import 'package:dream_carz/core/colors.dart';
import 'package:dream_carz/core/responsiveutils.dart';
import 'package:dream_carz/presentation/blocs/fetch_banners_bloc/fetch_banners_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

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

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide(int imageCount) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_isUserInteracting) return;
      if (!mounted) return;

      int next = _currentIndex + 1;
      if (next >= imageCount) {
        next = 0;
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
    return BlocBuilder<FetchBannersBloc, FetchBannersState>(
      builder: (context, state) {
        if (state is FetchBannersLoadingState) {
          return _buildShimmerLoader();
        }

        if (state is FetchBannersSuccessState) {
          final banners = state.banners;
          
          if (banners.isEmpty) {
            return _buildEmptyState();
          }

          // Start auto-slide when banners are loaded
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _startAutoSlide(banners.length);
          });

          return _buildCarousel(banners);
        }

        if (state is FetchBannersErrorState) {
          return _buildErrorState(state.message);
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildShimmerLoader() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: ResponsiveUtils.wp(15),
                height: ResponsiveUtils.wp(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),
              Container(
                width: ResponsiveUtils.wp(40),
                height: ResponsiveUtils.hp(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported,
              size: ResponsiveUtils.wp(15),
              color: Colors.grey.shade400,
            ),
            SizedBox(height: ResponsiveUtils.hp(1)),
            Text(
              'No banners available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: ResponsiveUtils.sp(3.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: ResponsiveUtils.wp(15),
              color: Colors.red.shade400,
            ),
            SizedBox(height: ResponsiveUtils.hp(1)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(8)),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: ResponsiveUtils.sp(3.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(List<dynamic> banners) {
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
              itemCount: banners.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final banner = banners[index];
                return GestureDetector(
                  onTapDown: (_) => _pauseAutoSlide(),
                  onTapUp: (_) => _resumeAutoSlide(),
                  onTapCancel: () => _resumeAutoSlide(),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(banner.file),
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          // Handle image loading error
                        },
                      ),
                    ),
                    child: banner.file.isEmpty
                        ? Center(
                            child: Icon(
                              Icons.broken_image,
                              size: ResponsiveUtils.wp(20),
                              color: Colors.grey.shade400,
                            ),
                          )
                        : null,
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
                  children: List.generate(banners.length, (index) {
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