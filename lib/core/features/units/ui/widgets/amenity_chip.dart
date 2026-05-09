import 'package:flutter/material.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class AmenityChip extends StatelessWidget {
  const AmenityChip({
    super.key,
    required this.label,
    this.isSelected = false,
  });

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    final bgColor = isSelected
        ? theme.colorScheme.primary.withValues(alpha: 0.12)
        : appColors.border.withValues(alpha: 0.5);

    final textColor = isSelected
        ? theme.colorScheme.primary
        : appColors.muted;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
