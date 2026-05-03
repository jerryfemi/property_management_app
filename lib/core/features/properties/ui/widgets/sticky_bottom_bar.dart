import 'package:flutter/material.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';
import 'package:pro_app/core/utils/property_formatters.dart';

class StickyBottomBar extends StatelessWidget {
  final PropertyModel property;
  final int availableUnits;

  const StickyBottomBar({
    super.key,
    required this.property,
    required this.availableUnits,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
   
    final mutedColor = theme.colorScheme.onSurface.withValues(alpha: 0.6);

    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Starting from',
                style: theme.textTheme.bodySmall?.copyWith(color: mutedColor),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    PropertyFormatters.formatPrice(2500000), // min rent from units
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Text(
                    PropertyFormatters.rentPeriodSuffix(property.rentPeriod),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: mutedColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          FilledButton(
            onPressed: () {
              // Scroll down to units section — or navigate directly
            },
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'View Units',
              style: TextStyle(fontWeight: FontWeight.w800),
            ),
          ),
        ],
      ),
    );
  }
}
