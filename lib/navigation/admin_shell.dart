import 'dart:io' show Platform;

import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/admin/ui/widgets/side_bar_item.dart';
import 'package:pro_app/core/features/notifications/providers/notifications_provider.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class AdminShell extends ConsumerWidget {
  const AdminShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  // Mapping Mobile Nav Index -> Shell Branch Index
  int _getShellIndex(int navIndex) {
    switch (navIndex) {
      case 0:
        return 0; // Dashboard
      case 1:
        return 1; // Properties
      case 2:
        return 3; // Applications
      case 3:
        return 5; // Notifications (Alerts)
      default:
        return 0;
    }
  }

  // Mapping Shell Branch Index -> Mobile Nav Index
  int _getMobileNavIndex(int shellIndex) {
    switch (shellIndex) {
      case 0:
        return 0; // Dashboard
      case 1:
        return 1; // Properties
      case 3:
        return 2; // Applications
      case 5:
        return 3; // Notifications (Alerts)
      default:
        return 0; // Fallback, though we shouldn't really hit this on mobile
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadCountProvider);
    final useCupertino = !kIsWeb && Platform.isIOS;

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 900) {
          return AdminWebLayout(shell: shell);
        }

        return Scaffold(
          body: shell,
          bottomNavigationBar: useCupertino
              ? _buildCupertinoBar(unreadCount)
              : _buildMaterialBar(unreadCount),
        );
      },
    );
  }

  Widget _buildMaterialBar(int unreadCount) {
    final navIndex = _getMobileNavIndex(shell.currentIndex);
    return NavigationBar(
      selectedIndex: navIndex,
      onDestinationSelected: (index) {
        final targetBranch = _getShellIndex(index);
        shell.goBranch(
          targetBranch,
          initialLocation: targetBranch == shell.currentIndex,
        );
      },
      destinations: [
        const NavigationDestination(
          icon: Icon(CupertinoIcons.square_grid_2x2),
          selectedIcon: Icon(CupertinoIcons.square_grid_2x2_fill),
          label: 'Dashboard',
        ),
        const NavigationDestination(
          icon: Icon(CupertinoIcons.building_2_fill),
          selectedIcon: Icon(CupertinoIcons.building_2_fill),
          label: 'Properties',
        ),
        const NavigationDestination(
          icon: Icon(CupertinoIcons.doc_text),
          selectedIcon: Icon(CupertinoIcons.doc_text_fill),
          label: 'Applications',
        ),
        NavigationDestination(
          icon: Badge(
            isLabelVisible: unreadCount > 0,
            label: Text('$unreadCount'),
            child: const Icon(CupertinoIcons.bell),
          ),
          selectedIcon: Badge(
            isLabelVisible: unreadCount > 0,
            label: Text('$unreadCount'),
            child: const Icon(CupertinoIcons.bell_fill),
          ),
          label: 'Alerts',
        ),
      ],
    );
  }

  Widget _buildCupertinoBar(int unreadCount) {
    final alertsLabel = unreadCount > 0 ? 'Alerts ($unreadCount)' : 'Alerts';
    final navIndex = _getMobileNavIndex(shell.currentIndex);

    return CNTabBar(
      items: [
        CNTabBarItem(label: 'Dashboard', icon: CNSymbol('square.grid.2x2')),
        CNTabBarItem(label: 'Properties', icon: CNSymbol('building.2')),
        CNTabBarItem(label: 'Applications', icon: CNSymbol('doc.text')),
        CNTabBarItem(label: alertsLabel, icon: CNSymbol('bell')),
      ],
      currentIndex: navIndex,
      onTap: (index) {
        final targetBranch = _getShellIndex(index);
        shell.goBranch(
          targetBranch,
          initialLocation: targetBranch == shell.currentIndex,
        );
      },
    );
  }
}

class AdminWebHeader extends StatelessWidget {
  final int currentIndex;
  const AdminWebHeader({super.key, required this.currentIndex});

  String get _title {
    switch (currentIndex) {
      case 0:
        return 'Portfolio Overview';
      case 1:
        return 'Properties';
      case 2:
        return 'Tenants';
      case 3:
        return 'Applications';
      case 4:
        return 'Financials';
      case 5:
        return 'Notifications';
      default:
        return 'Dashboard';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: appColors.surface,
        border: Border(bottom: BorderSide(color: appColors.border, width: 1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            _title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: appColors.surface == Colors.white
                  ? Colors.black
                  : Colors.white,
            ),
          ),
          Row(
            children: [
              // Search Input
              SizedBox(
                width: 250,
                child: CupertinoSearchTextField(
                  placeholder: 'Search anything...',
                  placeholderStyle: TextStyle(
                    color: appColors.muted,
                    fontSize: 14,
                    fontFamily: theme.textTheme.bodyMedium?.fontFamily,
                  ),
                  style: TextStyle(
                    color: theme.textTheme.bodyMedium?.color,
                    fontSize: 14,
                    fontFamily: theme.textTheme.bodyMedium?.fontFamily,
                  ),
                  backgroundColor: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  itemColor: appColors.muted,
                  itemSize: 20,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Notifications
              Consumer(
                builder: (context, ref, child) {
                  final unreadCount = ref.watch(unreadCountProvider);
                  return Stack(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: appColors.border),
                        ),
                        child: IconButton(
                          icon: Icon(
                            CupertinoIcons.bell,
                            size: 20,
                            color: appColors.muted,
                          ),
                          onPressed: () => context.go('/admin/notifications'),
                        ),
                      ),
                      if (unreadCount > 0)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.error,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(width: 16),
              // Add Property Button
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                icon: const Icon(CupertinoIcons.add, size: 16),
                label: const Text(
                  'Add Property',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AdminWebLayout extends StatelessWidget {
  final StatefulNavigationShell shell;
  const AdminWebLayout({super.key, required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SideBar(shell: shell),
          Expanded(
            child: Column(
              children: [
                // Header
                AdminWebHeader(currentIndex: shell.currentIndex),
                // body
                Expanded(child: shell),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
