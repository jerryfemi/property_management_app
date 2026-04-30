import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

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
                angle: 0.07,
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
                    Icons.description_outlined,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 70,
                  ),
                ),
              ),

              // notification type icon
              Positioned(
                bottom: 10,
                left: 0,
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
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.access_time_outlined,
                              color: Colors.white,
                              // size: 30,
                            ),
                          ),
                        )
                        .animate(
                          onPlay: (controller) =>
                              controller.repeat(reverse: true),
                        )
                        .scale(
                          begin: const Offset(1.0, 1.0),
                          end: const Offset(1.1, 1.1),
                          duration: 900.ms,
                          curve: Curves.easeInOut,
                        )
                        .fade(
                          begin: 1.0,
                          end: 0.5,
                          duration: 900.ms,
                          curve: Curves.easeInOut,
                        ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24),

        // title
        Text(
          'Apply in',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            height: 1.25,
          ),
        ),
        Text(
          'Minutes',
          style: TextStyle(
            fontSize: 30,
            height: 1.25,
            color: Theme.of(context).colorScheme.secondary,
            fontWeight: FontWeight.w900,
          ),
        ),
        SizedBox(height: 16),

        // subtitle
        Text(
          'Say goodbye to paperwork. Submit\nyour application and get verified\n instantly.',
          style: TextStyle(color: context.appColors.muted, fontSize: 15),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 100),
      ],
    );
  }
}
