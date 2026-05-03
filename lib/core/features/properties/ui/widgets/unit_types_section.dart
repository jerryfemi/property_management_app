import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';
import 'package:pro_app/core/features/unit/data/unit_model.dart';
import 'package:pro_app/core/utils/property_formatters.dart';
import 'package:pro_app/core/widgets/loading_spinner.dart';

class UnitTypesSection extends StatelessWidget {
  final String propertyId;
  final AsyncValue<List<UnitModel>> unitsAsync;
  final PropertyModel property;
  final ThemeData theme;
  final dynamic appColors;

  const UnitTypesSection({
    super.key,
    required this.propertyId,
    required this.unitsAsync,
    required this.property,
    required this.theme,
    required this.appColors,
  });

  @override
  Widget build(BuildContext context) {
    return unitsAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: BrandedLoadingSpinner(),
        ),
      ),
      error: (e, _) => Text(
        'Could not load units: $e',
        style: TextStyle(color: appColors.muted),
      ),
      data: (units) {
        if (units.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: appColors.muted.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: appColors.muted),
                const SizedBox(width: 12),
                Text(
                  'No units currently available.',
                  style: TextStyle(color: appColors.muted),
                ),
              ],
            ),
          );
        }

        // Group units by bedroom count
        final grouped = units.groupByBedrooms();

        return Column(
          children: grouped.entries.map((entry) {
            final bedrooms = entry.key;
            final bedroomUnits = entry.value;
            final minRent = bedroomUnits.minRent;

            return UnitTypeRow(
              bedrooms: bedrooms,
              count: bedroomUnits.length,
              minRent: minRent,
              rentPeriod: property.rentPeriod,
              theme: theme,
              appColors: appColors,
              onTap: () {
                // Navigate to unit selection for this bedroom type
                context.go(
                  '/guest/explore/property/${property.id}/unit/${bedroomUnits.first.id}',
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}

class UnitTypeRow extends StatelessWidget {
  final int bedrooms;
  final int count;
  final double minRent;
  final RentPeriod rentPeriod;
  final ThemeData theme;
  final dynamic appColors;
  final VoidCallback onTap;

  const UnitTypeRow({
    super.key,
    required this.bedrooms,
    required this.count,
    required this.minRent,
    required this.rentPeriod,
    required this.theme,
    required this.appColors,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: appColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Bedroom icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.bed_outlined,
                color: theme.colorScheme.primary,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),

            // Label + count
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    PropertyFormatters.getBedroomLabel(bedrooms),
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '$count unit${count == 1 ? '' : 's'} available',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: appColors.muted,
                    ),
                  ),
                ],
              ),
            ),

            // Price + chevron
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  PropertyFormatters.formatPrice(minRent),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.primary,
                  ),
                ),
                Text(
                  PropertyFormatters.rentPeriodSuffix(rentPeriod),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: appColors.muted,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14,
              color: appColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}
