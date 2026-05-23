import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:pro_app/core/theme/app_theme.dart';

// Local provider to track the selected category
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

class CategoryChips extends ConsumerWidget {
  const CategoryChips({
    super.key,
    required this.categories,
    required this.selectedProvider,
    this.borderRadius,
    this.selectedColor,
    this.padding,
  });

  final List<String> categories;

  final StateProvider<String> selectedProvider;

  final double? borderRadius;

  final Color? selectedColor;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appColors = context.appColors;

    final radius = borderRadius ?? 20;
    final selColor = selectedColor ?? colorScheme.primary;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: categories.map((category) {
          final isSelected = selectedCategory == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                category,
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: .bold,
                  color: isSelected ? Colors.white : null,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  ref.read(selectedProvider.notifier).state = category;
                }
              },
              showCheckmark: false,
              selectedColor: selColor,
              backgroundColor: theme.colorScheme.surface.withValues(alpha: 0.6),
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.white : appColors.muted,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius.toDouble()),
                side: BorderSide(
                  color: isSelected
                      ? selColor.withValues(alpha: 0.35)
                      : appColors.muted.withValues(alpha: 0.08),
                ),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
          );
        }).toList(),
      ),
    );
  }
}
