import 'dart:io' show Platform;

import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GuestShell extends StatelessWidget {
  const GuestShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final useCupertino = !kIsWeb && Platform.isIOS;

    return Scaffold(
      body: shell,
      bottomNavigationBar: useCupertino
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
          icon: Icon(Icons.house_outlined),
          label: 'Explore',
          selectedIcon: Icon(Icons.house),
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark_outline),
          label: 'Saved',
          selectedIcon: Icon(Icons.bookmark),
        ),
        NavigationDestination(
          icon: Icon(Icons.description_outlined),
          label: 'Applications',
          selectedIcon: Icon(Icons.description),
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
          selectedIcon: Icon(Icons.person),
        ),
      ],
    );
  }

  Widget _buildCupertinoBar() {
    return CNTabBar(
      items: const [
        CNTabBarItem(label: 'Explore', icon: CNSymbol('house')),
        CNTabBarItem(label: 'Saved', icon: CNSymbol('bookmark')),
        CNTabBarItem(label: 'Applications', icon: CNSymbol('doc.text')),
        CNTabBarItem(label: 'Profile', icon: CNSymbol('person')),
      ],
      currentIndex: shell.currentIndex,
      onTap: (index) =>
          shell.goBranch(index, initialLocation: index == shell.currentIndex),
    );
  }
}
