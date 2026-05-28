import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/admin/providers/dashboard_providers.dart';
import 'package:pro_app/core/features/properties/ui/widgets/category_chips.dart';
import 'package:pro_app/core/features/unit/data/unit_model.dart';
import 'package:pro_app/core/theme/app_theme.dart';
import 'package:pro_app/core/widgets/status_badge.dart';

class AdminPropertyDetailScreen extends ConsumerStatefulWidget {
  final String propertyId;
  const AdminPropertyDetailScreen({super.key, required this.propertyId});

  @override
  ConsumerState<AdminPropertyDetailScreen> createState() =>
      _AdminPropertyDetailScreenState();
}

class _AdminPropertyDetailScreenState
    extends ConsumerState<AdminPropertyDetailScreen> {
  // filter category
  List<String> unitcategory = ['All', 'Occupied', 'Vacant', 'Maintenance'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unitAsync = ref.watch(filteredUnitsForPropertyProvider(widget.propertyId));
    final units = unitAsync.value!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            CategoryChips(
              borderRadius: 8,
              categories: unitcategory,
              selectedProvider: selectedUnitProvider,
            ),
            const SizedBox(height: 14),
            _UnitCard(
              units: units
                  .map(
                    (unit) => _UnitTile(
                      amenities: unit.amenities,
                      onTap: () => context.go(''),
                      color: theme.colorScheme.primary,
                      unitNumber: unit.unitNumber,
                      baseRent: unit.baseRent.toString(),
                      status: unit.unitStatus,

                      tenant: unit.currentTenantId!,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitCard extends StatelessWidget {
  final List<_UnitTile> units;
  const _UnitCard({required this.units});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: .circular(15),
      ),
      child: Column(
        children: units.asMap().entries.map((entry) {
          return Column(
            children: [
              entry.value,
              Divider(color: context.appColors.muted),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _UnitTile extends StatelessWidget {
  const _UnitTile({
    this.color,
    required this.amenities,
    required this.onTap,
    required this.unitNumber,
    required this.baseRent,
    required this.status,
    required this.tenant,
  });
  final VoidCallback onTap;
  final String unitNumber;
  final List<String> amenities;
  final String baseRent;
  final UnitStatus status;
  final Color? color;
  final String tenant;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        // unit
        Text(
          unitNumber,
          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: .bold),
        ),
        // type
        Text(amenities.toString()),
        // base rent
        Text(
          baseRent,
          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: .bold),
        ),
        // status
        StatusBadge(
          text: status.name,
          textColor: color,
          backgroundColor: color!.withValues(alpha: 0.2),
        ),
        Text(
          tenant,
          style: theme.textTheme.bodyLarge?.copyWith(fontWeight: .bold),
        ),
      ],
    );
  }
}
