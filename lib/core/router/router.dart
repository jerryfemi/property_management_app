import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/admin/ui/application_review_screen.dart';
import 'package:pro_app/core/features/admin/ui/applications_screen.dart';
import 'package:pro_app/core/features/admin/ui/dashboard_screen.dart';
import 'package:pro_app/core/features/admin/ui/lease_creation_screen.dart';
import 'package:pro_app/core/features/admin/ui/properties_screen.dart';
import 'package:pro_app/core/features/applications/ui/application_form_screen.dart';
import 'package:pro_app/core/features/applications/ui/my_applications_screen.dart';
import 'package:pro_app/core/features/auth/data/user_model.dart';
import 'package:pro_app/core/features/auth/providers/auth_providers.dart';
import 'package:pro_app/core/features/auth/ui/auth_landing_screen.dart';
import 'package:pro_app/core/features/auth/ui/onboarding_screen.dart';
import 'package:pro_app/core/features/auth/ui/login_screen.dart';
import 'package:pro_app/core/features/auth/ui/profile_screen.dart';
import 'package:pro_app/core/features/auth/ui/saved_screen.dart';
import 'package:pro_app/core/features/auth/ui/signup_screen.dart';
import 'package:pro_app/core/features/auth/ui/complete_profile_screen.dart';
import 'package:pro_app/core/features/auth/ui/splash_gate.dart';
import 'package:pro_app/core/features/maintenance/ui/maintenance_screen.dart';
import 'package:pro_app/core/features/maintenance/ui/new_ticket_screen.dart';
import 'package:pro_app/core/features/notifications/ui/notification_screen.dart';
import 'package:pro_app/core/features/payments/ui/payments_screen.dart';
import 'package:pro_app/core/features/properties/ui/screens/marketplace_screen.dart';
import 'package:pro_app/core/features/properties/ui/screens/property_detail_screen.dart';
import 'package:pro_app/core/features/staff/ui/tasks_screen.dart';
import 'package:pro_app/core/features/staff/ui/ticket_detail_screen.dart';
import 'package:pro_app/core/features/tenant/ui/tenant_home_screen.dart';
import 'package:pro_app/core/features/units/ui/unit_detail_screen.dart';
import 'package:pro_app/navigation/admin_shell.dart';
import 'package:pro_app/navigation/guest_shell.dart';
import 'package:pro_app/navigation/staff_shell.dart';
import 'package:pro_app/navigation/tenant_shell.dart';
import 'package:pro_app/core/router/onboarding_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider.notifier);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: kDebugMode,
    refreshListenable: notifier,

    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashGate(),
      ),

      // ── Auth ─────────────────────────────────────────────────────────────
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthLandingScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: '/complete-profile',
        builder: (context, state) => const CompleteProfileScreen(),
      ),

      // ── Guest Shell ───────────────────────────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => GuestShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/guest/explore',
                builder: (context, state) => const MarketplaceScreen(),
                routes: [
                  GoRoute(
                    path: 'property/:propertyId',
                    builder: (context, state) => PropertyDetailScreen(
                      propertyId: state.pathParameters['propertyId']!,
                    ),
                    routes: [
                      GoRoute(
                        path: 'unit/:unitId',
                        builder: (context, state) => UnitDetailScreen(
                          unitId: state.pathParameters['unitId']!,
                        ),
                        routes: [
                          GoRoute(
                            path: 'apply',
                            builder: (context, state) =>
                                ApplicationFormScreen(
                              unitId: state.pathParameters['unitId']!,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/guest/saved',
                builder: (context, state) => const SavedScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/guest/applications',
                builder: (context, state) => const MyApplicationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/guest/profile',
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // ── Tenant Shell ──────────────────────────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => TenantShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tenant/home',
                builder: (_, __) => const TenantHomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tenant/payments',
                builder: (_, __) => const PaymentsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tenant/maintenance',
                builder: (_, __) => const MaintenanceScreen(),
                routes: [
                  GoRoute(
                    path: 'new',
                    builder: (_, _) => const NewTicketScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tenant/notifications',
                builder: (_, __) => const NotificationScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tenant/profile',
                builder: (_, __) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // ── Staff Shell ───────────────────────────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => StaffShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/staff/tasks',
                builder: (_, __) => const TasksScreen(),
                routes: [
                  GoRoute(
                    path: 'ticket/:ticketId',
                    builder: (_, s) => TicketDetailScreen(
                      ticketId: s.pathParameters['ticketId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/staff/profile',
                builder: (_, __) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),

      // ── Admin Shell ───────────────────────────────────────────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AdminShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/admin/dashboard',
                builder: (_, __) => const AdminDashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/admin/properties',
                builder: (_, __) => const AdminPropertiesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/admin/applications',
                builder: (_, __) => const AdminApplicationsScreen(),
                routes: [
                  GoRoute(
                    path: ':appId/review',
                    builder: (_, s) => ApplicationReviewScreen(
                      applicationId: s.pathParameters['appId']!,
                    ),
                  ),
                  GoRoute(
                    path: ':appId/lease',
                    builder: (_, s) => LeaseCreationScreen(
                      applicationId: s.pathParameters['appId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/admin/notifications',
                builder: (_, __) => const NotificationScreen(),
              ),
            ],
          ),
        ],
      ),
    ],

    // ── Redirect logic ──────────────────────────────────────────────────────
    redirect: (context, state) {
      final location = state.matchedLocation;

      // ── GATE: Block all redirects until both async values are loaded ──
      // onboardingComplete is null only while SharedPreferences is reading.
      // isAuthenticated relies on Firebase authStateChanges — initially null.
      // We stay on '/' (SplashGate) until both are known.
      if (notifier.onboardingComplete == null ||
          notifier.authStateKnown == false) {
        // Stay on splash gate while loading. Don't redirect away from it yet.
        return location == '/' ? null : '/';
      }

      final isLoggedIn = notifier.isAuthenticated;
      final role = notifier.role ?? UserRole.guest;
      final isOnAuth = location.startsWith('/auth');
      final isOnCompleteProfile = location == '/complete-profile';
      final isOnOnboarding = location == '/onboarding';
      final isOnSplash = location == '/';

      // ── 1. Not logged in ──────────────────────────────────────────────────
      if (!isLoggedIn) {
        if (notifier.onboardingComplete == false) {
          return isOnOnboarding ? null : '/onboarding';
        }
        // Onboarding done, push to auth unless already there
        return isOnAuth ? null : '/auth';
      }

      // ── 2. Logged in, needs profile completion ────────────────────────────
      if (notifier.needsProfile && !isOnCompleteProfile) {
        return '/complete-profile';
      }

      // ── 3. Logged in, profile complete — leave auth/onboarding/splash ─────
      if (isOnAuth || isOnOnboarding || isOnSplash ||
          (isOnCompleteProfile && !notifier.needsProfile)) {
        return switch (role) {
          UserRole.guest  => '/guest/explore',
          UserRole.tenant => '/tenant/home',
          UserRole.staff  => '/staff/tasks',
          UserRole.admin  => '/admin/dashboard',
        };
      }

      // ── 4. Mid-session role upgrades ──────────────────────────────────────
      if (role == UserRole.tenant && location.startsWith('/guest')) {
        return '/tenant/home';
      }
      if (role == UserRole.staff &&
          !location.startsWith('/staff') &&
          !location.startsWith('/auth')) {
        return '/staff/tasks';
      }
      if (role == UserRole.admin &&
          !location.startsWith('/admin') &&
          !location.startsWith('/auth')) {
        return '/admin/dashboard';
      }

      return null; // Already in the right place
    },
  );
});

// ---------------------------------------------------------------------------
// RouterNotifier
// ---------------------------------------------------------------------------

final routerNotifierProvider = NotifierProvider<RouterNotifier, void>(
  RouterNotifier.new,
);

class RouterNotifier extends Notifier<void> implements ChangeNotifier {
  UserRole? _role;
  bool _needsProfile = false;
  bool? _onboardingComplete;
  bool _isAuthenticated = false;

  // authStateKnown is false only for the very first frame before Firebase
  // has emitted its first authStateChanges event. We use this as part of
  // the loading gate in redirect so we never redirect until we are certain.
  bool _authStateKnown = false;

  UserRole? get role => _role;
  bool get needsProfile => _needsProfile;
  bool? get onboardingComplete => _onboardingComplete;
  bool get isAuthenticated => _isAuthenticated;
  bool get authStateKnown => _authStateKnown;

  @override
  void build() {
    // ── Onboarding ───────────────────────────────────────────────────────────
    // Read the current value without subscribing so we get whatever is cached.
    // The listener below handles all future changes.
    final onboardingAsync = ref.read(onboardingControllerProvider);
    if (!onboardingAsync.isLoading) {
      _onboardingComplete = onboardingAsync.value;
    }
    ref.listen<AsyncValue<bool>>(onboardingControllerProvider, (_, next) {
      if (!next.isLoading) {
        _onboardingComplete = next.value;
        notifyListeners();
      }
    });

    // ── Auth state ────────────────────────────────────────────────────────────
    // We use listen (not read) so we always get the very first emission.
    ref.listen<AsyncValue<User?>>(authStateProvider, (_, next) {
      if (!next.isLoading) {
        _authStateKnown = true;
        _isAuthenticated = next.value != null;
        notifyListeners();
      }
    });

    // ── User role ─────────────────────────────────────────────────────────────
    ref.listen<AsyncValue<UserRole?>>(userRoleProvider, (_, next) {
      if (!next.isLoading) {
        _role = next.value;
        notifyListeners();
      }
    });

    // ── Profile completion ────────────────────────────────────────────────────
    ref.listen<bool>(needsProfileCompletionProvider, (_, next) {
      _needsProfile = next;
      notifyListeners();
    });
  }

  // ── ChangeNotifier plumbing ───────────────────────────────────────────────
  final List<VoidCallback> _listeners = [];

  @override
  void addListener(VoidCallback l) => _listeners.add(l);

  @override
  void removeListener(VoidCallback l) => _listeners.remove(l);

  @override
  bool get hasListeners => _listeners.isNotEmpty;

  @override
  void notifyListeners() {
    for (final l in List.of(_listeners)) {
      l();
    }
  }

  @override
  void dispose() {}
}
