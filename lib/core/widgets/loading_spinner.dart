import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BrandedLoadingSpinner extends StatefulWidget {
  final double size;
  final Color spinnerColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final IconData icon;

  const BrandedLoadingSpinner({
    super.key,
    this.size = 35.0,
    // Use your AppColors here if you have them defined
    this.spinnerColor = const Color(0xFF1B4FD8), // AppColors.primary
    this.iconBackgroundColor = const Color(0xFF1B4FD8), // AppColors.primary
    this.iconColor = Colors.white,
    this.icon = Icons.home_rounded,
  });

  @override
  State<BrandedLoadingSpinner> createState() => _BrandedLoadingSpinnerState();
}

class _BrandedLoadingSpinnerState extends State<BrandedLoadingSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // 1. Initialize the controller to spin continuously
    _controller = AnimationController(
      vsync: this,
      duration: 1500.ms, // Speed of the full rotation
    )..repeat(); // repeat() makes it loop infinitely
  }

  @override
  void dispose() {
    // ALWAYS dispose of controllers to prevent memory leaks!
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The total size is determined by the widget property.
    // We calculate inner sizes proportionally so it scales perfectly.
    final double strokeWidth = widget.size * 0.08;
    // Calculate the inner space exactly to remove any gap
    final double iconContainerSize = widget.size - (strokeWidth * 2);
    final double iconSize = iconContainerSize * 0.6;
    final double minScale = (18 / widget.size).clamp(0.8, 1.0);

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. The Spinning Outer Ring
          RotationTransition(
            turns: _controller,
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              // We use CircularProgressIndicator for the arc, but style it
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(widget.spinnerColor),
                strokeWidth: strokeWidth,
                // backgroundColor: Colors.grey.withOpacity(0.2), // Optional: Add a track track
                strokeCap:
                    StrokeCap.round, // Makes the ends of the spinner rounded
              ),
            ),
          ),

          // 2. The Static Central Brand Icon
          Container(
                width: iconContainerSize,
                height: iconContainerSize,
                decoration: BoxDecoration(
                  color: widget.iconBackgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: widget.iconBackgroundColor.withValues(alpha: 0.3),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  widget.icon,
                  color: widget.iconColor,
                  size: iconSize,
                ),
              )
              .animate(onPlay: (controller) => controller.repeat(reverse: true))
              .scale(
                begin: Offset(minScale, minScale),
                end: const Offset(1, 1),
                curve: Curves.easeInOut,
                duration: 500.ms,
              ),
        ],
      ),
    );
  }
}
