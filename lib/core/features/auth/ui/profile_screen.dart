import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/core/features/auth/data/user_model.dart';
import 'package:pro_app/core/features/auth/providers/auth_providers.dart';
import 'package:pro_app/core/theme/app_colors.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/theme/theme_provider.dart';
import 'package:pro_app/core/widgets/primary_button.dart';
import 'package:pro_app/core/widgets/section_label.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final roleAsync = ref.watch(userRoleProvider);
    final role = roleAsync.value ?? UserRole.guest;

    return Scaffold(
      body: userAsync.when(
        error: (error, stackTrace) => const Center(child: Text('Error $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
        data: (user) {
          if (user == null) {
            return const Center(child: Text('No User data'));
          }

          return CustomScrollView(
            physics: BouncingScrollPhysics(parent: ClampingScrollPhysics()),
            slivers: [
              // App bar
              _AppBar(user: user, role: role),
              // Account section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                  child: SectionLabel('Account'),
                ),
              ),
              // menu
              SliverToBoxAdapter(
                child: _MenuCard(
                  items: [
                    _MenuItem(
                      icon: CupertinoIcons.person,
                      iconColor: Theme.of(context).colorScheme.primary,
                      label: 'Personal Information',
                      onTap: () {},
                    ),
                    if (role == UserRole.tenant) ...[
                      _MenuItem(
                        icon: CupertinoIcons.doc_text,
                        iconColor: Colors.purple,
                        label: 'Lease Documents',
                      ),
                    ],
                  ],
                ),
              ),

              // settings section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
                  child: SectionLabel('Settings'),
                ),
              ),
              SliverToBoxAdapter(
                child: _MenuCard(
                  items: [
                    _MenuItem(
                      icon: CupertinoIcons.moon,
                      iconColor: Colors.deepOrange,
                      label: 'Dark Mode',
                      trailing: _DarkModeToggle(),
                    ),
                    _MenuItem(
                      icon: CupertinoIcons.bell,
                      iconColor: Colors.red,
                      label: 'Notifications',
                      onTap: () {},
                    ),
                    _MenuItem(
                      icon: CupertinoIcons.info_circle,
                      iconColor: AppColorsLight.dark,
                      label: 'Help & Support',
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              // logout
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: PrimaryButton(
                    text: 'Log out',
                    onPressed: () =>
                        ref.read(authControllerProvider.notifier).signOut(),
                  ),
                ),
              ),
              SliverFillRemaining(),
            ],
          );
        },
      ),
    );
  }
}

////// WIDGETS/////////

class _AppBar extends StatelessWidget {
  const _AppBar({required this.user, required this.role});
  final UserModel user;
  final UserRole role;

  @override
  Widget build(BuildContext context) {
    final initials = _initials(user.name);
    final roleLable = _roleLabel(role, user);
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      clipBehavior: Clip.antiAlias,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          user.name.isEmpty ? 'User' : user.name,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        background: Container(
          color: Theme.of(context).colorScheme.surface,
          child: Center(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // profile photo
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.15),
                        backgroundImage: user.profileImage != null
                            ? NetworkImage(user.profileImage!)
                            : null,
                        child: user.profileImage == null
                            ? Text(
                                initials,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            : null,
                      ),

                      // Edit Icon
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.surface,
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            CupertinoIcons.pencil,
                            color: Theme.of(context).colorScheme.surface,
                            size: 13,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),
                  Text(
                    roleLable,
                    style: TextStyle(
                      fontSize: 14,
                      color: context.appColors.muted,
                    ),
                  ),

                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(color: context.appColors.border),
                    ),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _initials(String name) {
  final parts = name.trim().split(' ');
  if (parts.length >= 2) {
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
  if (parts.isNotEmpty && parts[0].isNotEmpty) {
    return parts[0][0].toUpperCase();
  }
  return 'U';
}

String _roleLabel(UserRole role, dynamic user) {
  return switch (role) {
    UserRole.tenant => 'Tenant',
    UserRole.staff => 'Maintenance Staff',
    UserRole.admin => 'Property Manager',
    UserRole.guest => 'Guest',
  };
}

class _MenuCard extends StatelessWidget {
  final List<_MenuItem> items;
  const _MenuCard({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.appColors.border),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final isLast = entry.key == items.length - 1;
          return Column(
            children: [
              entry.value,
              if (!isLast)
                Divider(
                  height: 1,
                  thickness: 1,
                  color: context.appColors.border,
                  indent: 2,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback? onTap;
  final Widget? trailing;
  const _MenuItem({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.onTap,
    this.trailing,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            trailing ??
                Icon(
                  CupertinoIcons.chevron_right,
                  size: 16,
                  color: context.appColors.muted,
                ),
          ],
        ),
      ),
    );
  }
}

class _DarkModeToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark =
        themeMode == ThemeMode.dark ||
        (themeMode == ThemeMode.system &&
            WidgetsBinding.instance.platformDispatcher.platformBrightness ==
                Brightness.dark);

    return Switch(
      value: isDark,
      onChanged: (value) {
        ref
            .read(themeProvider.notifier)
            .setThemeMode(value ? ThemeMode.dark : ThemeMode.light);
      },
    );
  }
}
