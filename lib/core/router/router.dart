import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/features/admin/ui/application_review_screen.dart';
import 'package:pro_app/features/admin/ui/applications_screen.dart';
import 'package:pro_app/features/admin/ui/dashboard_screen.dart';
import 'package:pro_app/features/admin/ui/lease_creation_screen.dart';
import 'package:pro_app/features/admin/ui/properties_screen.dart';
import 'package:pro_app/features/applications/ui/application_form_screen.dart';
import 'package:pro_app/features/applications/ui/my_applications_screen.dart';
import 'package:pro_app/features/auth/data/user_model.dart';
import 'package:pro_app/features/auth/providers/auth_providers.dart';
import 'package:pro_app/features/auth/ui/auth_landing_screen.dart';
import 'package:pro_app/features/auth/ui/onboarding_screen.dart';
import 'package:pro_app/features/auth/ui/login_screen.dart';
import 'package:pro_app/features/auth/ui/profile_screen.dart';
import 'package:pro_app/features/auth/ui/saved_screen.dart';
import 'package:pro_app/features/auth/ui/signup_screen.dart';
import 'package:pro_app/features/auth/ui/complete_profile_screen.dart';
import 'package:pro_app/features/maintenance/ui/maintenance_screen.dart';
import 'package:pro_app/features/maintenance/ui/new_ticket_screen.dart';
import 'package:pro_app/features/notifications/ui/notification_screen.dart';
import 'package:pro_app/features/payments/ui/payments_screen.dart';
import 'package:pro_app/features/properties/ui/marketplace_screen.dart';
import 'package:pro_app/features/properties/ui/property_detail_screen.dart';
import 'package:pro_app/features/staff/ui/tasks_screen.dart';
import 'package:pro_app/features/staff/ui/ticket_detail_screen.dart';
import 'package:pro_app/features/tenant/ui/tenant_home_screen.dart';
import 'package:pro_app/features/units/ui/unit_detail_screen.dart';
import 'package:pro_app/navigation/admin_shell.dart';
import 'package:pro_app/navigation/guest_shell.dart';
import 'package:pro_app/navigation/staff_shell.dart';
import 'package:pro_app/navigation/tenant_shell.dart';
import 'package:pro_app/core/router/onboarding_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(routerNotifierProvider.notifier);
  return GoRouter(
    routes: [
      // auth
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthLandingScreen(),
      ),
      GoRoute(path: '/auth/login', builder: (context, state) => LoginScreen()),
      GoRoute(path: '/auth/signup', builder: (context, state) => SignupScreen()),
      GoRoute(
        path: '/complete-profile',
        builder: (context, state) => const CompleteProfileScreen(),
      ),

      // shell route for Guest
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => GuestShell(shell: shell,),
        branches: [
          // explore tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/guest/explore',
                builder: (context, state) => const MarketplaceScreen(),
                // routes under the explore screen
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
                            builder: (context, state) => ApplicationFormScreen(
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

          // saved tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/guest/saved',
                builder: (context, state) => const SavedScreen(),
              ),
            ],
          ),

          // apllications tab
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/guest/applications',
                builder: (context, state) => const MyApplicationsScreen(),
              ),
            ],
          ),

          // profile tab
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

      // shell route for tenant
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => TenantShell(shell: shell),
        branches: [
          // Tab 0 — Home
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tenant/home',
                builder: (_, __) => const TenantHomeScreen(),
              ),
            ],
          ),
          // Tab 1 — Payments
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tenant/payments',
                builder: (_, __) => const PaymentsScreen(),
              ),
            ],
          ),
          // Tab 2 — Maintenance
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/tenant/maintenance',
                builder: (_, __) => const MaintenanceScreen(),
                routes: [
                  GoRoute(
                    path: 'new',
                    builder: (_, __) => const NewTicketScreen(),
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
          // Tab 4 — Profile
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

      // shell routr for staff
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => StaffShell(shell: shell),
        branches: [
          // Tab 0 — Tasks (assigned tickets)
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
          // Tab 1 — Profile
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

      // shell route for admin
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AdminShell(shell: shell),
        branches: [
          // Tab 0 — Dashboard
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/admin/dashboard',
                builder: (_, __) => const AdminDashboardScreen(),
              ),
            ],
          ),
          // Tab 1 — Properties
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/admin/properties',
                builder: (_, __) => const AdminPropertiesScreen(),
              ),
            ],
          ),
          // Tab 2 — Applications
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
          // Tab 3 — Notifications
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

    refreshListenable: notifier,
    initialLocation: '/onboarding',
    debugLogDiagnostics: kDebugMode,
    redirect: (context, state) {
      final role = notifier.role;
      final location = state.matchedLocation;
      final isOnAuth = location.startsWith('/auth');
      final isOnCompleteProfile = location == '/complete-profile';
      final isOnOnboarding = location == '/onboarding';

      // not logged in -> got to auth
      if (role == null) {
        if (notifier.onboardingComplete == false && !isOnOnboarding) {
          return '/onboarding';
        }
        if (notifier.onboardingComplete == true && isOnOnboarding) {
          return '/auth';
        }
        return isOnAuth || isOnOnboarding ? null : '/auth';
      }

      if (notifier.needsProfile && !isOnCompleteProfile && !isOnAuth) {
        return '/complete-profile';
      }

      // logged in but on auth screen => redirect to home
      if (isOnAuth || isOnCompleteProfile) {
        return switch (role) {
          UserRole.guest => '/guest/explore',
          UserRole.tenant => '/tenant/home',
          UserRole.staff => '/staff/tasks',
          UserRole.admin => '/admin/dashboard',
        };
      }

      // Guest→Tenant upgrade mid-session (happens after payment webhook)
      if (role == UserRole.tenant && location.startsWith('/guest')) {
        return '/tenant/home';
      }
      // // Tenant downgrade (lease expired) → back to guest
      // if (role == UserRole.guest && location.startsWith('/tenant')) {
      //   return '/guest/explore';
      // }
      // Staff on wrong shell

      if (role == UserRole.staff &&
          !location.startsWith('/staff') &&
          !location.startsWith('/auth')) {
        return '/staff/tasks';
      }
      // Admin on wrong shell
      if (role == UserRole.admin &&
          !location.startsWith('/admin') &&
          !location.startsWith('/auth')) {
        return '/admin/dashboard';
      }

      return null;
    },
  );
});

// router notifier
final routerNotifierProvider = NotifierProvider<RouterNotifier, void>(
  RouterNotifier.new,
);

class RouterNotifier extends Notifier<void> implements ChangeNotifier {
  UserRole? _role;
  bool _needsProfile = false;
  bool? _onboardingComplete;

  UserRole? get role => _role;
  bool get needsProfile => _needsProfile;
  bool? get onboardingComplete => _onboardingComplete;

  @override
  void build() {
    ref.listen<AsyncValue<UserRole?>>(userRoleProvider, (_, next) {
      _role = next.value;
      notifyListeners();
    });

    ref.listen<bool>(needsProfileCompletionProvider, (_, next) {
      _needsProfile = next;
      notifyListeners();
    });

    ref.listen<AsyncValue<bool>>(onboardingControllerProvider, (_, next) {
      _onboardingComplete = next.value;
      notifyListeners();
    });
  }

  final List<VoidCallback> _listeners = [];
  @override
  void addListener(VoidCallback l) => _listeners.add(l);
  @override
  void removeListener(VoidCallback l) => _listeners.remove(l);
  @override
  bool get hasListeners => _listeners.isNotEmpty;
  @override
  void notifyListeners() {
    for (final l in _listeners) {
      l();
    }
  }

  @override
  void dispose() {}
}
