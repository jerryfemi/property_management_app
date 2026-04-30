import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        // Container
        SizedBox(
          height: 210,
          width: 210,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(35),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(1, 10),
                    ),
                  ],
                ),
                child: Icon(
                  CupertinoIcons.chart_bar_alt_fill,
                  size: 70,
                  color: context.appColors.warning,
                ),
              ),

              // notification type icon
              Positioned(
                bottom: 85,
                right: 0,
                child: Container(
                  padding: .all(3),
                  decoration: BoxDecoration(
                    color: context.appColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    padding: .all(6),
                    decoration: BoxDecoration(
                      color: context.appColors.warning,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.lock_outlined,
                      color: Colors.white,
                      // size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // title
        Text(
          'Manage',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            height: 1.25,
          ),
        ),
        Text(
          'Everything',
          style: TextStyle(
            fontSize: 30,
            height: 1.25,
            color: context.appColors.warning,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 16),

        // subtitle
        Text(
          'Pay rent securely, track maintenance\n tickets, and view your lease from\n anywhere.',
          style: TextStyle(color: context.appColors.muted, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
