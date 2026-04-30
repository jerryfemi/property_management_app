import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _onboardingKey = 'onboarding_complete';

final onboardingControllerProvider =
    StateNotifierProvider<OnboardingController, AsyncValue<bool>>((ref) {
      return OnboardingController();
    });

class OnboardingController extends StateNotifier<AsyncValue<bool>> {
  OnboardingController() : super(const AsyncLoading()) {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final done = prefs.getBool(_onboardingKey) ?? false;
    state = AsyncData(done);
  }

  Future<void> complete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
    state = const AsyncData(true);
  }
}
