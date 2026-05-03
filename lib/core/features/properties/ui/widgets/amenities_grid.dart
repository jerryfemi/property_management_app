import 'package:flutter/material.dart';

class AmenitiesGrid extends StatelessWidget {
  final List<String> amenities;
  final ThemeData theme;
  final dynamic appColors;

  const AmenitiesGrid({
    super.key,
    required this.amenities,
    required this.theme,
    required this.appColors,
  });

  IconData _iconForAmenity(String amenity) {
    final a = amenity.toLowerCase();
    if (a.contains('pool') || a.contains('swim')) return Icons.pool;
    if (a.contains('gym') || a.contains('fitness')) return Icons.fitness_center;
    if (a.contains('power') || a.contains('generator') || a.contains('solar')) {
      return Icons.power;
    }
    if (a.contains('wifi') || a.contains('internet')) return Icons.wifi;
    if (a.contains('park') || a.contains('car')) return Icons.local_parking;
    if (a.contains('security') || a.contains('cctv') || a.contains('guard')) {
      return Icons.security;
    }
    if (a.contains('water') || a.contains('borehole')) return Icons.water_drop;
    if (a.contains('ac') || a.contains('air')) return Icons.ac_unit;
    if (a.contains('gym')) return Icons.sports;
    if (a.contains('bar') || a.contains('wine')) return Icons.local_bar;
    if (a.contains('garden') || a.contains('organic')) return Icons.yard;
    if (a.contains('laundry')) return Icons.local_laundry_service;
    if (a.contains('lift') || a.contains('elevator')) return Icons.elevator;
    return Icons.check_circle_outline;
  }

  @override
  Widget build(BuildContext context) {
    if (amenities.isEmpty) {
      return Text(
        'No amenities listed',
        style: TextStyle(color: appColors.muted),
      );
    }
    // Wrap layout — adapts to any number of amenities
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: amenities
          .map(
            (a) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.06),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.15),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _iconForAmenity(a),
                    size: 14,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    a,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
