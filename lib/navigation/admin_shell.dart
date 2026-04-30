import 'dart:io' show Platform;

import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/features/notifications/providers/notifications_provider.dart';

class AdminShell extends ConsumerWidget {
  const AdminShell({super.key, required this.shell});
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
      onDestinationSelected: (index) =>
          shell.goBranch(index, initialLocation: index == shell.currentIndex),
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        const NavigationDestination(
          icon: Icon(Icons.apartment_outlined),
          selectedIcon: Icon(Icons.apartment),
          label: 'Properties',
        ),
        const NavigationDestination(
          icon: Icon(Icons.description_outlined),
          selectedIcon: Icon(Icons.description),
          label: 'Applications',
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
      ],
    );
  }

  Widget _buildCupertinoBar(int unreadCount) {
    final alertsLabel = unreadCount > 0 ? 'Alerts ($unreadCount)' : 'Alerts';

    return CNTabBar(
      items: [
        CNTabBarItem(label: 'Dashboard', icon: CNSymbol('square.grid.2x2')),
        CNTabBarItem(label: 'Properties', icon: CNSymbol('building.2')),
        CNTabBarItem(label: 'Applications', icon: CNSymbol('doc.text')),
        CNTabBarItem(label: alertsLabel, icon: CNSymbol('bell')),
      ],
      currentIndex: shell.currentIndex,
      onTap: (index) =>
          shell.goBranch(index, initialLocation: index == shell.currentIndex),
    );
  }
}
