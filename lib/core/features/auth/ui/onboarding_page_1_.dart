import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

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
              Transform.rotate(
                angle: -0.07,
                child: Container(
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
                    CupertinoIcons.home,
                    color: Theme.of(context).colorScheme.primary,
                    size: 70,
                  ),
                ),
              ),

              // notification type icon
              Positioned(
                top: 0,
                right: 15,
                child:
                    Container(
                          padding: .all(3),
                          decoration: BoxDecoration(
                            color: context.appColors.surface,
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            padding: .all(6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check_rounded,
                              color: Colors.white,
                            ),
                          ),
                        )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .moveY(
                          begin: -5,
                          end: 5,
                          duration: 600.ms,
                          curve: Curves.bounceInOut,
                        ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // title
        Text(
          'Discover Your',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            height: 1.25,
          ),
        ),
        Text(
          'Dream Home',
          style: TextStyle(
            fontSize: 30,
            height: 1.25,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 16),

        // subtitle
        Text(
          'Browse thousands of verified\n properties tailored exactly to your\n lifestyle and budget.',
          style: TextStyle(color: context.appColors.muted, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
