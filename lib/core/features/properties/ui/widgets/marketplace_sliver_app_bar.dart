import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/core/features/properties/ui/widgets/filter_sheet.dart';
import 'package:pro_app/core/features/properties/ui/widgets/marketplace_header.dart';
import 'package:pro_app/core/features/properties/ui/widgets/category_chips.dart';
import 'package:pro_app/core/features/properties/providers/property_filter_providers.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class MarketplaceSliverAppBar extends ConsumerStatefulWidget {
  const MarketplaceSliverAppBar({super.key});

  @override
  ConsumerState<MarketplaceSliverAppBar> createState() =>
      _MarketplaceSliverAppBarState();
}

class _MarketplaceSliverAppBarState
    extends ConsumerState<MarketplaceSliverAppBar> {
  late final SearchController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = SearchController();
    _searchController.text = ref.read(propertyFiltersProvider).searchQuery;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String>(
      propertyFiltersProvider.select((state) => state.searchQuery),
      (previous, next) {
        if (next != _searchController.text) {
          _searchController.text = next;
        }
      },
    );
    final theme = Theme.of(context);
    final appColors = context.appColors;
    final textScale = MediaQuery.textScaleFactorOf(
      context,
    ).clamp(1.0, 1.2).toDouble();
    final filters = ref.watch(propertyFiltersProvider);

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
        collapseMode: CollapseMode.pin,
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
                      child: SizedBox(
                        height: 40 * textScale,
                        child: SearchBar(
                          controller: _searchController,
                          hintText: 'Search properties...',
                          leading: Icon(Icons.search, color: appColors.muted),
                          onChanged: (value) => ref
                              .read(propertyFiltersProvider.notifier)
                              .setSearchQuery(value),
                          onSubmitted: (value) => ref
                              .read(propertyFiltersProvider.notifier)
                              .setSearchQuery(value),
                          trailing: filters.searchQuery.isEmpty
                              ? null
                              : [
                                  IconButton(
                                    onPressed: () {
                                      _searchController.clear();
                                      ref
                                          .read(
                                            propertyFiltersProvider.notifier,
                                          )
                                          .setSearchQuery('');
                                    },
                                    icon: Icon(
                                      Icons.close_rounded,
                                      color: appColors.muted,
                                    ),
                                    tooltip: 'Clear search',
                                  ),
                                ],
                          textStyle: WidgetStatePropertyAll(
                            theme.textTheme.bodyMedium,
                          ),
                          hintStyle: WidgetStatePropertyAll(
                            theme.textTheme.bodyMedium?.copyWith(
                              color: appColors.muted,
                            ),
                          ),
                          backgroundColor: WidgetStatePropertyAll(
                            appColors.muted.withValues(alpha: 0.05),
                          ),
                          elevation: const WidgetStatePropertyAll(0),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          padding: const WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 6),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    SizedBox(
                      height: 40 * textScale,
                      width: 40 * textScale,
                      child: IconButton(
                        onPressed: () => FilterSheet.show(context),
                        icon: Icon(
                          Icons.tune,
                          color: theme.colorScheme.onSurface,
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: appColors.muted.withValues(
                            alpha: 0.05,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        tooltip: 'Filters',
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
