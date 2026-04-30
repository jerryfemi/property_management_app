import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/router/onboarding_provider.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/features/auth/ui/onboarding_page_1_.dart';
import 'package:pro_app/features/auth/ui/onboarding_page_2.dart';
import 'package:pro_app/features/auth/ui/onboarding_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int currentPage = 0;

  late List<Widget> _pages;

  void _next() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    _pages = [OnboardingPage1(), OnboardingPage2(), OnboardingPage3()];
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await ref.read(onboardingControllerProvider.notifier).complete();
    if (mounted) context.go('/auth');
  }

  // Accent color per page — matches the colored title text
  List<Color> get _pageAccentColors => [
    Theme.of(context).colorScheme.primary, // Page 1: blue
    Theme.of(context).colorScheme.secondary, // Page 2: green
    context.appColors.warning, // Page 3: orange
  ];

  @override
  Widget build(BuildContext context) {
    final isLast = currentPage == _pages.length - 1;
    final accentColor = _pageAccentColors[currentPage];

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemBuilder: (context, index) => _pages[index],
            itemCount: _pages.length,
            onPageChanged: (page) => setState(() {
              currentPage = page;
            }),
          ),

          // skip button
          Positioned(
            top: 60,
            right: 10,
            child: TextButton(onPressed: _finish, child: const Text('Skip')),
          ),

          // Bottom bar: indicator + button
          Positioned(
            bottom: 48,
            left: 24,
            right: 24,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Smooth page indicator with animated color
                SmoothPageIndicator(
                  effect: ExpandingDotsEffect(
                    dotWidth: 10,
                    dotHeight: 10,
                    expansionFactor: 3,
                    dotColor: Colors.grey.shade300,
                    spacing: 8,
                    activeDotColor: accentColor,
                  ),
                  controller: _controller,
                  count: _pages.length,
                ),

                const Spacer(),

                // Animated next / Get Started button
                GestureDetector(
                  onTap: isLast ? _finish : _next,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    height: 56,
                    width: isLast ? 150 : 56,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSurface,
                      borderRadius: BorderRadius.circular(isLast ? 16 : 28),
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isLast
                            ? const Text(
                                'Get Started',
                                key: ValueKey('get_started'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              )
                            : const Icon(
                                Icons.chevron_right,
                                key: ValueKey('chevron'),
                                color: Colors.white,
                                size: 28,
                              ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
