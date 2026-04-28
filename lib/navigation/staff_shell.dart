import 'dart:io' show Platform;

import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StaffShell extends StatelessWidget {
  const StaffShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: Platform.isIOS
          ? _buildCupertinoBar()
          : _buildMaterialBar(),
    );
  }

  Widget _buildMaterialBar() {
    return NavigationBar(
      selectedIndex: shell.currentIndex,
      onDestinationSelected: (index) =>
          shell.goBranch(index, initialLocation: index == shell.currentIndex),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.checklist_outlined),
          selectedIcon: Icon(Icons.checklist),
          label: 'Tasks',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget _buildCupertinoBar() {
    return CNTabBar(
      items: const [
        CNTabBarItem(label: 'Tasks', icon: CNSymbol('checklist')),
        CNTabBarItem(label: 'Profile', icon: CNSymbol('person')),
      ],
      currentIndex: shell.currentIndex,
      onTap: (index) =>
          shell.goBranch(index, initialLocation: index == shell.currentIndex),
    );
  }
}
