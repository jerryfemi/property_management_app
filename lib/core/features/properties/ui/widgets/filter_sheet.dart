import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/core/features/properties/providers/property_filter_providers.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class FilterSheet extends ConsumerWidget {
  const FilterSheet({super.key});

  static Future<void> show(BuildContext context) {
    final theme = Theme.of(context);
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: theme.colorScheme.surface,
      builder: (context) =>
          const FractionallySizedBox(heightFactor: 0.85, child: FilterSheet()),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = context.appColors;
    final current = ref.watch(propertyFiltersProvider);
    RangeValues priceRange = current.priceRange;
    RangeValues areaRange = current.areaRange;
    final types = {...current.propertyTypes};
    final amenities = {...current.amenities};
    var beds = current.bedrooms;
    var baths = current.bathrooms;

    return StatefulBuilder(
      builder: (context, setState) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Text(
                'Filters',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Price range',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              RangeSlider(
                values: priceRange,
                min: 600000,
                max: 4000000,
                divisions: 20,
                labels: RangeLabels(
                  priceRange.start.toStringAsFixed(0),
                  priceRange.end.toStringAsFixed(0),
                ),
                onChanged: (value) => setState(() => priceRange = value),
              ),
              // const SizedBox(height: 8),
              // Text(
              //   'Area (sqm)',
              //   style: theme.textTheme.bodyMedium?.copyWith(
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
              // RangeSlider(
              //   values: areaRange,
              //   min: 0,
              //   max: 500,
              //   divisions: 20,
              //   labels: RangeLabels(
              //     areaRange.start.toStringAsFixed(0),
              //     areaRange.end.toStringAsFixed(0),
              //   ),
              //   onChanged: (value) => setState(() => areaRange = value),
              // ),
              const SizedBox(height: 8),
              Text(
                'Property type',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    ['Apartment', 'Shortlet', 'Commercial', 'Self Contain'].map(
                      (label) {
                        final isSelected = types.contains(label);
                        return FilterChip(
                          label: Text(label),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                types.add(label);
                              } else {
                                types.remove(label);
                              }
                            });
                          },
                          showCheckmark: false,
                          selectedColor: theme.colorScheme.primary,
                          backgroundColor: appColors.muted.withValues(
                            alpha: 0.04,
                          ),
                          labelStyle: theme.textTheme.bodyMedium?.copyWith(
                            color: isSelected ? Colors.white : appColors.muted,
                            fontWeight: FontWeight.w600,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(
                              color: isSelected
                                  ? theme.colorScheme.primary.withValues(
                                      alpha: 0.35,
                                    )
                                  : theme.colorScheme.primary.withValues(
                                      alpha: 0.15,
                                    ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
              ),
              const SizedBox(height: 16),
              Text(
                'Bedrooms',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['Any', '1', '2', '3+'].map((label) {
                  final isSelected = beds == label;
                  return ChoiceChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (_) => setState(() => beds = label),
                    showCheckmark: false,
                    selectedColor: theme.colorScheme.primary,
                    backgroundColor: appColors.muted.withValues(alpha: 0.04),
                    labelStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected ? Colors.white : appColors.muted,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? theme.colorScheme.primary.withValues(alpha: 0.35)
                            : theme.colorScheme.primary.withValues(alpha: 0.15),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text(
                'Bathrooms',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: ['Any', '1', '2', '3+'].map((label) {
                  final isSelected = baths == label;
                  return ChoiceChip(
                    label: Text(label),
                    selected: isSelected,
                    onSelected: (_) => setState(() => baths = label),
                    showCheckmark: false,
                    selectedColor: theme.colorScheme.primary,
                    backgroundColor: appColors.muted.withValues(alpha: 0.04),
                    labelStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: isSelected ? Colors.white : appColors.muted,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: isSelected
                            ? theme.colorScheme.primary.withValues(alpha: 0.35)
                            : theme.colorScheme.primary.withValues(alpha: 0.15),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Text(
                'Amenities',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    [
                      'WiFi',
                      'Pool',
                      'Gym',
                      'Parking',
                      'Power',
                      'Water',
                      'Security',
                      'AC',
                    ].map((label) {
                      final isSelected = amenities.contains(label);
                      return FilterChip(
                        label: Text(label),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              amenities.add(label);
                            } else {
                              amenities.remove(label);
                            }
                          });
                        },
                        showCheckmark: false,
                        selectedColor: theme.colorScheme.primary,
                        backgroundColor: appColors.muted.withValues(
                          alpha: 0.04,
                        ),
                        labelStyle: theme.textTheme.bodyMedium?.copyWith(
                          color: isSelected ? Colors.white : appColors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: isSelected
                                ? theme.colorScheme.primary.withValues(
                                    alpha: 0.35,
                                  )
                                : theme.colorScheme.primary.withValues(
                                    alpha: 0.15,
                                  ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          priceRange = PropertyFilterState.defaultPriceRange;
                          areaRange = PropertyFilterState.defaultAreaRange;
                          types.clear();
                          beds = 'Any';
                          baths = 'Any';
                          amenities.clear();
                        });
                        ref
                            .read(propertyFiltersProvider.notifier)
                            .clearFilters();
                      },
                      child: const Text('Clear'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        ref.read(propertyFiltersProvider.notifier)
                          ..setPriceRange(priceRange)
                          ..setAreaRange(areaRange)
                          ..setPropertyTypes(types)
                          ..setBedrooms(beds)
                          ..setBathrooms(baths)
                          ..setAmenities(amenities);
                        Navigator.pop(context);
                      },
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}
