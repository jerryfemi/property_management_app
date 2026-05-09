import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/unit/data/unit_model.dart';
import 'package:pro_app/core/features/unit/providers/unit_provider.dart';
import 'package:pro_app/core/features/units/ui/widgets/floor_plan_card.dart';
import 'package:pro_app/core/features/units/ui/widgets/unit_selection_card.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/utils/property_formatters.dart';
import 'package:pro_app/core/widgets/circle_icon_button.dart';
import 'package:pro_app/core/widgets/loading_spinner.dart';
import 'package:pro_app/core/widgets/primary_button.dart';

class UnitDetailScreen extends ConsumerStatefulWidget {
  const UnitDetailScreen({super.key, required this.unitId});

  final String unitId;

  @override
  ConsumerState<UnitDetailScreen> createState() => _UnitDetailScreenState();
}

class _UnitDetailScreenState extends ConsumerState<UnitDetailScreen> {
  String? _selectedUnitId;

  @override
  Widget build(BuildContext context) {
    final unitAsync = ref.watch(watchUnitProvider(widget.unitId));

    return unitAsync.when(
      loading: () =>
          const Scaffold(body: Center(child: BrandedLoadingSpinner())),
      error: (e, _) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 12),
              Text('Could not load unit: $e'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => ref.refresh(watchUnitProvider(widget.unitId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (unit) {
        if (unit == null) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: Text('Unit not found.')),
          );
        }
        return _UnitSelectionView(
          unit: unit,
          selectedUnitId: _selectedUnitId ?? unit.id,
          onUnitSelected: (id) => setState(() => _selectedUnitId = id),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Main View
// ─────────────────────────────────────────────────────────────────────────────

class _UnitSelectionView extends ConsumerWidget {
  const _UnitSelectionView({
    required this.unit,
    required this.selectedUnitId,
    required this.onUnitSelected,
  });

  final UnitModel unit;
  final String selectedUnitId;
  final ValueChanged<String> onUnitSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    // Watch all available units for this property
    final allUnitsAsync = ref.watch(availableUnitsProvider(unit.propertyId));

    return Scaffold(
      //  App Bar
      appBar: AppBar(
        leading: CircleIconButton(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: () => context.pop(),
        ),
        title: Text(
          '${PropertyFormatters.getBedroomLabel(unit.bedrooms)} Units',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),

      //  Body
      body: allUnitsAsync.when(
        loading: () => const Center(child: BrandedLoadingSpinner()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 12),
              Text('Could not load units: $e'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () =>
                    ref.refresh(availableUnitsProvider(unit.propertyId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (allUnits) {
          // Filter to only units matching this bedroom count
          final sameUnits = allUnits
              .where((u) => u.bedrooms == unit.bedrooms)
              .toList();

          if (sameUnits.isEmpty) {
            return const Center(
              child: Text('No available units in this category.'),
            );
          }

          // Find the currently selected unit object
          final selectedUnit = sameUnits.firstWhere(
            (u) => u.id == selectedUnitId,
            orElse: () => sameUnits.first,
          );

          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 200),
            children: [
              // Floor plan card
              FloorPlanCard(
                bedrooms: unit.bedrooms,
                bathrooms: unit.bathrooms,
                floorPlanUrl: unit.floorPlanUrl,
              ),
              const SizedBox(height: 28),

              // Section title
              Text(
                'Select a specific unit',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),

              // Unit cards
              ...sameUnits.map(
                (unit) => Padding(
                  padding: const EdgeInsets.only(bottom: 14),
                  child: UnitSelectionCard(
                    unit: unit,
                    isSelected: unit.id == selectedUnit.id,
                    onTap: () => onUnitSelected(unit.id),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // bottom bar
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Selected: ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: .w600,
                        color: appColors.muted,
                      ),
                      children: [
                        TextSpan(
                          text: selectedUnit.unitNumber,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: .bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    mainAxisSize: .min,
                    children: [
                      Text(
                        PropertyFormatters.formatPrice(unit.baseRent),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: .bold,
                        ),
                      ),
                      Text(
                        'Base Rent',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: .w600,
                          color: appColors.muted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 14),
              PrimaryButton(text: 'Apply Now', onPressed: () {}),
            ],
          );
        },
      ),
    );
  }
}

