import 'package:flutter/material.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class FloorPlanCard extends StatelessWidget {
  const FloorPlanCard({
    super.key,
    required this.bedrooms,
    required this.bathrooms,
    this.floorPlanUrl,
  });

  final int bedrooms;
  final int bathrooms;
  final String? floorPlanUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: appColors.border),
      ),
      child: Column(
        children: [
          //Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Floor Plan',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: expand floor plan (full-screen viewer)
                },
                child: Text(
                  'EXPAND',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // floor plan image
          Container(
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: theme.colorScheme.primary.withValues(alpha: 0.25),
                style: BorderStyle.solid,
              ),
            ),
            child: floorPlanUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.network(floorPlanUrl!, fit: BoxFit.cover),
                  )
                : Icon(
                    Icons.grid_4x4_rounded,
                    size: 48,
                    color: theme.colorScheme.primary.withValues(alpha: 0.4),
                  ),
          ),
          const SizedBox(height: 18),

          // Bed / Bath stat counters
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _StatCounter(value: bedrooms.toString(), label: 'BED'),
              Container(width: 1, height: 28, color: appColors.border),
              _StatCounter(value: bathrooms.toString(), label: 'BATH'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCounter extends StatelessWidget {
  const _StatCounter({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            fontWeight: FontWeight.w800,
            color: appColors.muted,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
