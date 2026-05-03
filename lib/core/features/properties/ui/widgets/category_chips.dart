import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pro_app/core/theme/app_theme.dart';

// Local provider to track the selected category
final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

class CategoryChips extends ConsumerWidget {
  const CategoryChips({super.key});

  final List<String> categories = const [
    'All',
    'Shortlet',
    '1 Bed',
    '2 Bed',
    'Commercial',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final appColors = context.appColors;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: categories.map((category) {
          final isSelected = selectedCategory == category;
          
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  ref.read(selectedCategoryProvider.notifier).state = category;
                }
              },
              showCheckmark: false,
              selectedColor: colorScheme.primary,
              backgroundColor: Colors.transparent,
              labelStyle: theme.textTheme.bodyMedium?.copyWith(
                color: isSelected ? colorScheme.onPrimary : appColors.muted,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? colorScheme.primary : appColors.muted,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
