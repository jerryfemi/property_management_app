import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';
import 'package:pro_app/core/features/properties/providers/location_provider.dart';
import 'package:pro_app/core/features/properties/providers/property_provider.dart';
import 'package:pro_app/core/features/properties/providers/property_filter_providers.dart';
import 'package:pro_app/core/features/properties/ui/widgets/category_chips.dart';
import 'package:pro_app/core/features/properties/ui/widgets/marketplace_sliver_app_bar.dart';
import 'package:pro_app/core/features/properties/ui/widgets/property_card.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/widgets/loading_spinner.dart';

class MarketplaceScreen extends ConsumerWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final propertiesAsync = ref.watch(marketPlaceProvider);

    final selectedLocation = ref.watch(selectedLocationProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final filters = ref.watch(propertyFiltersProvider);

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            // 1. Collapsing Header & Pinned Search/Chips
            const MarketplaceSliverAppBar(),
            // 3. Property Feed
            propertiesAsync.when(
              data: (properties) {
                final filtered = _applyFilters(
                  properties,
                  category: selectedCategory,
                  location: selectedLocation,
                  filters: filters,
                );
                if (filtered.isEmpty) {
                  return SliverFillRemaining(
                    child: _EmptyState(
                      category: selectedCategory,
                      locationName: selectedLocation?.displayName,
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.only(bottom: 24),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final filtered = _applyFilters(
                        properties,
                        category: selectedCategory,
                        location: selectedLocation,
                        filters: filters,
                      );
                      final filter = filtered[index];
                      return PropertyCard(
                        property: filter,
                        onTap: () {
                          context.push('/guest/explore/property/${filter.id}');
                        },
                      );
                    }, childCount: filtered.length),
                  ),
                );
              },
              loading: () => const SliverFillRemaining(
                child: Center(child: BrandedLoadingSpinner()),
              ),
              error: (error, stack) => SliverFillRemaining(
                child: _ErrorState(
                  error: error.toString(),
                  onRetry: () => ref.refresh(marketPlaceProvider),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PropertyModel> _applyFilters(
    List<PropertyModel> all, {
    LocationOption? location,
    required String category,
    required PropertyFilterState filters,
  }) {
    var result = all;

    // Location filter
    if (location != null) {
      final q = location.name.toLowerCase();
      result = result.where((p) {
        return p.city.toLowerCase().contains(q) ||
            p.state.toLowerCase().contains(q) ||
            p.address.toLowerCase().contains(q);
      }).toList();
    }

    // Category chip filter
    if (category != 'All') {
      result = result.where((p) {
        switch (category) {
          case 'Shortlet':
            return p.propertyType == PropertyType.shortLet;
          case 'Commercial':
            return p.propertyType == PropertyType.commercial;
          // '1 Bed' / '2 Bed' are unit-level concepts, but we can give a best
          // effort by checking the title so the chip still does something useful
          // before the user drills into a property.
          case '1 Bed':
            return p.title.toLowerCase().contains('1') ||
                p.propertyType == PropertyType.selfCon;
          case '2 Bed':
            return p.title.toLowerCase().contains('2');
          default:
            return true;
        }
      }).toList();
    }

    // Search query filter
    if (filters.searchQuery.isNotEmpty) {
      final q = filters.searchQuery.toLowerCase();
      result = result.where((p) {
        return p.title.toLowerCase().contains(q) ||
            p.city.toLowerCase().contains(q) ||
            p.state.toLowerCase().contains(q) ||
            p.address.toLowerCase().contains(q);
      }).toList();
    }

    // Property type filter
    if (filters.propertyTypes.isNotEmpty) {
      final allowed = filters.propertyTypes
          .map(_mapPropertyTypeLabel)
          .whereType<PropertyType>()
          .toSet();
      result = result
          .where((p) => allowed.isEmpty || allowed.contains(p.propertyType))
          .toList();
    }

    // Amenities filter (best-effort match)
    if (filters.amenities.isNotEmpty) {
      final wanted = filters.amenities.map((a) => a.toLowerCase()).toSet();
      result = result.where((p) {
        final available = p.amenities.map((a) => a.toLowerCase()).toSet();
        return available.intersection(wanted).isNotEmpty;
      }).toList();
    }

    // Bedrooms filter (best-effort match)
    if (filters.bedrooms != 'Any') {
      final minBeds = _parseMinCount(filters.bedrooms);
      if (minBeds != null) {
        result = result.where((p) {
          final count = _extractCount(
            '${p.title} ${p.description}',
            RegExp(r'(\d+)\s*(bed|bedroom)', caseSensitive: false),
          );
          return count == null || count >= minBeds;
        }).toList();
      }
    }

    // Bathrooms filter (best-effort match)
    if (filters.bathrooms != 'Any') {
      final minBaths = _parseMinCount(filters.bathrooms);
      if (minBaths != null) {
        result = result.where((p) {
          final count = _extractCount(
            '${p.title} ${p.description}',
            RegExp(r'(\d+)\s*(bath|bathroom)', caseSensitive: false),
          );
          return count == null || count >= minBaths;
        }).toList();
      }
    }

    // Area filter (best-effort match)
    result = result.where((p) {
      final areaSqm = _extractAreaSqm('${p.title} ${p.description}');
      if (areaSqm == null) {
        return true;
      }
      return areaSqm >= filters.areaRange.start &&
          areaSqm <= filters.areaRange.end;
    }).toList();

    // Price filter (best-effort match)
    result = result.where((p) {
      final price = _extractPrice('${p.title} ${p.description}');
      if (price == null) {
        return true;
      }
      return price >= filters.priceRange.start &&
          price <= filters.priceRange.end;
    }).toList();

    return result;
  }
}

PropertyType? _mapPropertyTypeLabel(String label) {
  switch (label) {
    case 'Apartment':
      return PropertyType.apartment;
    case 'Shortlet':
      return PropertyType.shortLet;
    case 'Commercial':
      return PropertyType.commercial;
    case 'Self Contain':
      return PropertyType.selfCon;
    default:
      return null;
  }
}

int? _parseMinCount(String label) {
  if (label == 'Any') {
    return null;
  }
  if (label.endsWith('+')) {
    return int.tryParse(label.replaceAll('+', ''));
  }
  return int.tryParse(label);
}

int? _extractCount(String text, RegExp pattern) {
  final match = pattern.firstMatch(text);
  if (match == null) {
    return null;
  }
  return int.tryParse(match.group(1) ?? '');
}

double? _extractAreaSqm(String text) {
  final match = RegExp(
    r'(\d+(?:\.\d+)?)\s*(sqm|sq m|m2|m²|sqft|sq ft)',
    caseSensitive: false,
  ).firstMatch(text);
  if (match == null) {
    return null;
  }
  final value = double.tryParse(match.group(1) ?? '');
  if (value == null) {
    return null;
  }
  final unit = (match.group(2) ?? '').toLowerCase();
  if (unit.contains('sqft') || unit.contains('sq ft')) {
    return value * 0.092903;
  }
  return value;
}

double? _extractPrice(String text) {
  final match = RegExp(
    r'₦\s*([\d,.]+)(m|million)?',
    caseSensitive: false,
  ).firstMatch(text);
  if (match == null) {
    return null;
  }
  final raw = (match.group(1) ?? '').replaceAll(',', '');
  final value = double.tryParse(raw);
  if (value == null) {
    return null;
  }
  final suffix = (match.group(2) ?? '').toLowerCase();
  if (suffix == 'm' || suffix == 'million') {
    return value * 1000000;
  }
  return value;
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final String? locationName;
  final String category;

  const _EmptyState({this.locationName, required this.category});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    final where = locationName ?? 'this area';
    final categoryPart = category != 'All' ? ' matching "$category"' : '';

    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off_outlined,
            size: 56,
            color: appColors.muted.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          Text(
            'No properties found',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'There are no listings in $where$categoryPart.\nTry a different location or clear your filters.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.muted,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Error state ───────────────────────────────────────────────────────────────

class _ErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _ErrorState({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;
    debugPrint(error);
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi_off_rounded, size: 52, color: appColors.muted),
          const SizedBox(height: 16),
          Text(
            'Something went wrong',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            error,
            style: theme.textTheme.bodySmall?.copyWith(color: appColors.muted),
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
