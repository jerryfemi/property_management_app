import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/auth/providers/auth_providers.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/utils/property_formatters.dart';

class SideBaritem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final IconData icon;
  final bool isActive;
  const SideBaritem({
    super.key,
    required this.icon,
    required this.isActive,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 0),
        curve: Curves.easeInOut,
        margin: .symmetric(vertical: 2, horizontal: 8),
        padding: .symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: .circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? Colors.white : context.appColors.muted,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : context.appColors.muted,
                fontSize: 13,
                fontWeight: .w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SideBar extends StatelessWidget {
  final StatefulNavigationShell shell;
  const SideBar({super.key, required this.shell});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: 250,
        decoration: const BoxDecoration(color: Color(0xFF0F172A)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              // whole content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      // header
                      Row(
                        children: [
                          // icon
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 18,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.primary.withValues(alpha: 0.2),
                                  offset: const Offset(0, 10),
                                ),
                              ],
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              CupertinoIcons.house_fill,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),

                          const SizedBox(width: 12),
                          //Text
                          Text(
                            'PropApp',
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: .bold,
                                  color: Colors.white,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // navigation
                      SideBaritem(
                        icon: CupertinoIcons.square_grid_2x2,
                        isActive: shell.currentIndex == 0,
                        label: 'Dashboard',
                        onTap: () => shell.goBranch(0),
                      ),
                      SideBaritem(
                        icon: CupertinoIcons.building_2_fill,
                        isActive: shell.currentIndex == 1,
                        label: 'Properties',
                        onTap: () => shell.goBranch(1),
                      ),
                      SideBaritem(
                        icon: CupertinoIcons.person_3,
                        isActive: shell.currentIndex == 2,
                        label: 'Tenants',
                        onTap: () => shell.goBranch(2),
                      ),
                      SideBaritem(
                        icon: CupertinoIcons.doc_text,
                        isActive: shell.currentIndex == 3,
                        label: 'Applications',
                        onTap: () => shell.goBranch(3),
                      ),
                      SideBaritem(
                        icon: CupertinoIcons.money_dollar_circle,
                        isActive: shell.currentIndex == 4,
                        label: 'Financials',
                        onTap: () => shell.goBranch(4),
                      ),
                      const Spacer(),

                      // profile
                    ],
                  ),
                ),
              ),
              Divider(
                color: context.appColors.border.withValues(alpha: 0.3),
                thickness: 0,
              ),
              const SizedBox(height: 10),

              // avatar
              Consumer(
                builder: (context, ref, child) {
                  final user = ref.watch(currentUserProvider).value!;
                  final name = user.name;
                  final role = user.role;
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text(
                        PropertyFormatters.getInitials(ref),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      name,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    subtitle: Text(
                      "${role.name[0].toUpperCase()}${role.name.substring(1)}",
                      style: TextStyle(
                        color: context.appColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
