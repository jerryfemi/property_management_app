import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:pro_app/core/features/auth/providers/auth_providers.dart";
import "package:pro_app/core/router/onboarding_provider.dart";

class SplashGate extends ConsumerWidget {
  const SplashGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authStateProvider);
    ref.watch(onboardingControllerProvider);
    ref.watch(userRoleProvider);

    return const Scaffold(body: SizedBox.shrink());
  }
}
