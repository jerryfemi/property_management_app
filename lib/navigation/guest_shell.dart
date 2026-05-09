import 'dart:io' show Platform;
import 'package:cupertino_native/cupertino_native.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Added for SystemUiOverlayStyle
import 'package:go_router/go_router.dart';

class GuestShell extends StatelessWidget {
  const GuestShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final useCupertino = !kIsWeb && Platform.isIOS;

    // Use the overlay style defined in our theme
    final systemStyle = theme.appBarTheme.systemOverlayStyle ??
        const SystemUiOverlayStyle();

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemStyle,
      child: Scaffold(
        body: shell,
        bottomNavigationBar:
            useCupertino ? _buildCupertinoBar() : _buildMaterialBar(),
      ),
    );
  }

  Widget _buildMaterialBar() {
    return NavigationBar(
      selectedIndex: shell.currentIndex,
      onDestinationSelected: (index) =>
          shell.goBranch(index, initialLocation: index == shell.currentIndex),
      destinations: const [
        NavigationDestination(
          icon: Icon(CupertinoIcons.house),
          label: 'Explore',
          selectedIcon: Icon(CupertinoIcons.house_fill),
        ),
        NavigationDestination(
          icon: Icon(CupertinoIcons.bookmark),
          label: 'Saved',
          selectedIcon: Icon(CupertinoIcons.bookmark_fill),
        ),
        NavigationDestination(
          icon: Icon(CupertinoIcons.doc_text),
          label: 'Applications',
          selectedIcon: Icon(CupertinoIcons.doc_text_fill),
        ),
        NavigationDestination(
          icon: Icon(CupertinoIcons.person),
          label: 'Profile',
          selectedIcon: Icon(CupertinoIcons.person_fill),
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
