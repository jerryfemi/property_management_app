import 'dart:io' show Platform;

import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/features/notifications/providers/notifications_provider.dart';

class TenantShell extends ConsumerWidget {
  const TenantShell({super.key, required this.shell});
  final StatefulNavigationShell shell;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadCountProvider);
    final useCupertino = !kIsWeb && Platform.isIOS;

    return Scaffold(
      body: shell,
      bottomNavigationBar: useCupertino
          ? _buildCupertinoBar(unreadCount)
          : _buildMaterialBar(unreadCount),
    );
  }

  Widget _buildMaterialBar(int unreadCount) {
    return NavigationBar(
      selectedIndex: shell.currentIndex,
      onDestinationSelected: (i) =>
          shell.goBranch(i, initialLocation: i == shell.currentIndex),
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
          selectedIcon: Icon(Icons.home),
        ),
        const NavigationDestination(
          icon: Icon(Icons.credit_card_outlined),
          label: 'Payments',
          selectedIcon: Icon(Icons.credit_card),
        ),
        const NavigationDestination(
          icon: Icon(Icons.build_outlined),
          label: 'Maintenance',
          selectedIcon: Icon(Icons.build),
        ),
        NavigationDestination(
          icon: Badge(
            isLabelVisible: unreadCount > 0,
            label: Text('$unreadCount'),
            child: const Icon(Icons.notifications_outlined),
          ),
          selectedIcon: Badge(
            isLabelVisible: unreadCount > 0,
            label: Text('$unreadCount'),
            child: const Icon(Icons.notifications),
          ),
          label: 'Alerts',
        ),
        const NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildCupertinoBar(int unreadCount) {
    final alertsLabel = unreadCount > 0 ? 'Alerts ($unreadCount)' : 'Alerts';

    return CNTabBar(
      items: [
        const CNTabBarItem(label: 'Home', icon: CNSymbol('house')),
        const CNTabBarItem(label: 'Payments', icon: CNSymbol('creditcard')),
        const CNTabBarItem(label: 'Maintenance', icon: CNSymbol('wrench')),
        CNTabBarItem(label: alertsLabel, icon: const CNSymbol('bell')),
        const CNTabBarItem(label: 'Profile', icon: CNSymbol('person')),
      ],
      currentIndex: shell.currentIndex,
      onTap: (index) =>
          shell.goBranch(index, initialLocation: index == shell.currentIndex),
    );
  }
}
