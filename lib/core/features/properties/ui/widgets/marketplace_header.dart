import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/features/auth/providers/auth_providers.dart';

class MarketplaceHeader extends ConsumerWidget {
  const MarketplaceHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    // Watch the current user provider
    final userAsyncValue = ref.watch(currentUserProvider);

    // Extract initials from user name, default to 'GU' (Guest User) if not available
    String getInitials() {
      final user = userAsyncValue.value;
      if (user != null && user.name.isNotEmpty) {
        final names = user.name.trim().split(' ');
        if (names.length > 1) {
          return '${names[0][0]}${names[1][0]}'.toUpperCase();
        }
        return user.name.substring(0, 1).toUpperCase();
      }
      return 'GU';
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Location Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Location',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: appColors.muted,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    'Lagos, Nigeria',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ],
              ),
            ],
          ),

          // Avatar Section
          GestureDetector(
            onTap: () {
              // Navigate to profile
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: theme.colorScheme.primary,
              child: Text(
                getInitials(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
