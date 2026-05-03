import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ImageGallery extends StatelessWidget {
  final List<String> imageUrls;
  final PageController pageController;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;

  const ImageGallery({
    super.key,
    required this.imageUrls,
    required this.pageController,
    required this.currentIndex,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrls.isEmpty) {
      return Container(
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.image_not_supported_outlined, size: 48),
        ),
      );
    }

    return Stack(
      children: [
        // Page view of images
        PageView.builder(
          controller: pageController,
          onPageChanged: onPageChanged,
          itemCount: imageUrls.length,
          itemBuilder: (context, i) => CachedNetworkImage(
            imageUrl: imageUrls[i],
            fit: BoxFit.cover,
            placeholder: (_, _) => Skeletonizer(
              child: Container(
                color: Colors.grey.shade300,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            errorWidget: (_, _, _) => Container(
              color: Colors.grey[200],
              child: const Icon(Icons.broken_image_outlined, size: 48),
            ),
          ),
        ),

        // Dark gradient at top (for back button contrast)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black45, Colors.transparent],
              ),
            ),
          ),
        ),

        // Dot indicators at bottom
        if (imageUrls.length > 1)
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: pageController,
                count: imageUrls.length,
                effect: ExpandingDotsEffect(
                  dotWidth: 8,
                  dotHeight: 8,
                  expansionFactor: 2.5,
                  spacing: 8,
                  dotColor: Colors.white.withValues(alpha: 0.4),
                  activeDotColor: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),

        // Image count badge
        Positioned(
          bottom: 16,
          right: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${currentIndex + 1}/${imageUrls.length}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
