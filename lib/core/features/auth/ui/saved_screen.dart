import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/properties/providers/bookmark_property_provider.dart';
import 'package:pro_app/core/features/properties/ui/widgets/property_card.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/widgets/loading_spinner.dart';

class SavedScreen extends ConsumerWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarkAsync = ref.watch(savedPropertiesProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appColors = context.appColors;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: bookmarkAsync.when(
        error: (error, stackTrace) => Center(
          child: Text(
            'Error: $error',
            style: TextStyle(color: colorScheme.error),
          ),
        ),
        loading: () => const BrandedLoadingSpinner(),
        data: (savedProperties) {
          return CustomScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              // Sliver App Bar
              SliverAppBar(
                pinned: true,
                backgroundColor: colorScheme.surface,
                surfaceTintColor: Colors.transparent,
                centerTitle: false,
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bookmarks',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (savedProperties.isNotEmpty)
                        Text(
                          '${savedProperties.length} saved propert${savedProperties.length == 1 ? 'y' : 'ies'}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: appColors.muted,
                          ),
                        ),
                    ],
                  ),
              ),

              // Empty state
              if (savedProperties.isEmpty)
                SliverFillRemaining(
                  child: _EmptyState(appColors: appColors, theme: theme),
                )
              else
                // Property list
                SliverPadding(
                  padding: const EdgeInsets.only(top: 8, bottom: 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final saved = savedProperties[index];
                        return PropertyCard(
                          property: saved,
                          onTap: () => context.push(
                            '/guest/explore/property/${saved.id}',
                          ),
                        );
                      },
                      childCount: savedProperties.length,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.appColors, required this.theme});

  final AppExtraColors appColors;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final colorScheme = theme.colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                CupertinoIcons.bookmark,
                size: 44,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Bookmarks Yet',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Properties you bookmark will appear here so you can revisit them anytime.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: appColors.muted,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () => context.go('/guest/explore'),
              icon: const Icon(CupertinoIcons.search, size: 18),
              label: const Text('Browse Properties'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
