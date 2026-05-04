import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/properties/providers/location_provider.dart';
import 'package:pro_app/core/features/properties/ui/widgets/location_picker_sheet.dart';
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
    final selectedLocation = ref.watch(selectedLocationProvider);

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
          GestureDetector(
            onTap: () => LocationPickerSheet.show(context),
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4),

                // label row
                Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 13,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Location',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: appColors.muted,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                // city name
                Row(
                  mainAxisSize: .min,
                  children: [
                    Text(
                      selectedLocation?.displayName ?? 'All Locations',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(fontWeight: .w800),
                    ),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 22,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Avatar Section
          GestureDetector(
            onTap: () => context.go('guest/profile'),
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
