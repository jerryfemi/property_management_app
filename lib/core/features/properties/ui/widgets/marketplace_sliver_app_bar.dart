import 'package:flutter/material.dart';
import 'package:pro_app/core/features/properties/ui/widgets/marketplace_header.dart';
import 'package:pro_app/core/features/properties/ui/widgets/category_chips.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class MarketplaceSliverAppBar extends StatelessWidget {
  const MarketplaceSliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    return SliverAppBar(
      // expandedHeight MUST be > bottom.preferredSize.height
      // The bottom section is ~110px. The header is ~70px.
      expandedHeight: 180.0,
      collapsedHeight: 0.0,
      toolbarHeight: 0.0,
      pinned: true,
      backgroundColor: theme.scaffoldBackgroundColor,
      surfaceTintColor:
          Colors.transparent, // Prevents material 3 color shifting
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: theme.scaffoldBackgroundColor,
          alignment: Alignment.topCenter,
          child: const MarketplaceHeader(),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(110.0),
        child: Container(
          color: theme.scaffoldBackgroundColor,
          child: Column(
            children: [
              // Search Bar & Filter
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: appColors.muted.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 16),
                            Icon(Icons.search, color: appColors.muted),
                            const SizedBox(width: 12),
                            Text(
                              'Search properties...',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: appColors.muted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: appColors.muted.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.tune,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Category Chips
              const SizedBox(height: 60, child: CategoryChips()),
            ],
          ),
        ),
      ),
    );
  }
}
