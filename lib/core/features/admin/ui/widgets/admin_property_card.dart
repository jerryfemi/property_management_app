import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';
import 'package:pro_app/core/features/unit/data/unit_model.dart';
import 'package:pro_app/core/features/admin/providers/dashboard_providers.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/utils/property_formatters.dart';
import 'package:pro_app/core/widgets/status_badge.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AdminPropertyCard extends ConsumerWidget {
  final PropertyModel property;
  final VoidCallback onTap;
  const AdminPropertyCard({
    super.key,
    required this.onTap,
    required this.property,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = context.appColors;
    final units = ref.watch(adminUnitsByPropertyProvider)[property.id] ?? [];
    final startingPrice = units.minRent;
    final totalUnits = units.length;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Hero(
                tag: 'property_image_${property.id}',
                child: CachedNetworkImage(
                  imageUrl: property.imageUrls.isNotEmpty
                      ? property.imageUrls.first
                      : 'https://via.placeholder.com/400x200?text=No+Image',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Skeletonizer(
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 150,
                    color: appColors.muted.withValues(alpha: 0.1),
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Title and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),

                      StatusBadge(
                        text: 'dummy',
                        textColor: theme.colorScheme.error,
                        backgroundColor: theme.colorScheme.error.withValues(
                          alpha: 0.1,
                        ),
                      ),
                    ],
                  ),

                  // Location
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: appColors.muted,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          '${property.city}, ${property.state}',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: appColors.muted,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // units and price
                  Row(
                    mainAxisAlignment: .spaceBetween,
                    children: [
                      // unit count
                      Text(
                        '$totalUnits ${totalUnits > 1 ? 'Units' : 'Unit'} ',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: appColors.muted,
                        ),
                      ),

                      // price
                      Text(
                        '${PropertyFormatters.formatPrice(startingPrice)} avg',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: .bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // view unit button
                  SizedBox(
                    width: 250,
                    child: FilledButton(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: appColors.background,
                        foregroundColor: theme.colorScheme.onSurface,
                        shape: RoundedRectangleBorder(
                          borderRadius: .circular(10),
                          side: BorderSide(
                            color: appColors.muted.withValues(alpha: 0.05),
                          ),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'View Units',
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontWeight: .bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
