import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/utils/property_formatters.dart';
import 'package:pro_app/core/widgets/status_badge.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AdminPropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback onTap;
  const AdminPropertyCard({super.key, required this.onTap, required this.property});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    return  GestureDetector(
      onTap:onTap,
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
            Stack(
              children: [
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
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Skeletonizer(
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 200,
                        color: appColors.muted.withValues(alpha: 0.1),
                        child: const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),

                // Top Left Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: StatusBadge(
                    text: '${property.availableUnit} Units Available',
                  ),
                ),

            
              ],
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          property.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: appColors.warning, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '4.8', // Mock rating for now
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

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
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: appColors.muted,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Starting from',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: appColors.muted,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            PropertyFormatters.formatPrice(startingPrice),
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color:theme.colorScheme
                                  .primary, // Used primary color for prominent price
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '/${property.rentPeriod.name.substring(0, 2)}', // e.g. /ye or /mo
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: appColors.muted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ) ;
  }
}
