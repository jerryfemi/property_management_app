import 'package:flutter/material.dart';
import 'package:pro_app/core/features/unit/data/unit_model.dart';
import 'package:pro_app/core/features/units/ui/widgets/amenity_chip.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/utils/property_formatters.dart';

class UnitSelectionCard extends StatelessWidget {
  const UnitSelectionCard({
    super.key,
    required this.unit,
    required this.isSelected,
    required this.onTap,
  });

  final UnitModel unit;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;
    final primary = theme.colorScheme.primary;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? primary : appColors.border,
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: primary.withValues(alpha: 0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            // Top row: avatar + name + radio
            Row(
              children: [
                // Unit avatar
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? primary
                        : appColors.border.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    unit.unitNumber,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: isSelected
                          ? Colors.white
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Unit title
                Expanded(
                  child: Text(
                    'Unit ${unit.unitNumber}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                // Custom radio circle
                _RadioIndicator(isSelected: isSelected, color: primary),
              ],
            ),

            // Divider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Divider(height: 1, color: appColors.border),
            ),

            // Bottom row: amenity chips + price
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: unit.amenities
                        .map(
                          (a) => AmenityChip(label: a, isSelected: isSelected),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(width: 12),
                AnimatedDefaultTextStyle(
                  duration: const Duration(milliseconds: 250),
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w900,
                    color: isSelected ? primary : theme.colorScheme.onSurface,
                  ),
                  child: Text(PropertyFormatters.formatPrice(unit.baseRent)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A custom radio-style indicator that animates an inner dot.
class _RadioIndicator extends StatelessWidget {
  const _RadioIndicator({required this.isSelected, required this.color});

  final bool isSelected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final extra = context.appColors;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : extra.muted.withValues(alpha: 0.4),
          width: 2,
        ),
      ),
      child: Center(
        child: AnimatedScale(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutBack,
          scale: isSelected ? 1.0 : 0.0,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
        ),
      ),
    );
  }
}
