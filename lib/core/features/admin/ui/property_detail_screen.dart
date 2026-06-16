import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_app/core/features/admin/providers/dashboard_providers.dart';
import 'package:pro_app/core/features/properties/providers/property_provider.dart';
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
    final unitAsync = ref.watch(
      filteredUnitsForPropertyProvider(widget.propertyId),
    );
    final units = unitAsync.value!;
    final property = ref
        .watch(propertyDetailProvider(widget.propertyId))
        .value!;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: .min,
          children: [
            Text(
              property.title,
              style: theme.textTheme.headlineSmall?.copyWith(),
            ),
            StatusBadge(
              text: property.totalUnits.toString(),
              textColor: theme.colorScheme.secondary,
              backgroundColor: theme.colorScheme.secondary.withValues(
                alpha: 0.4,
              ),
            ),
          ],
        ),
      ),
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
              totalUnits: property.totalUnits,
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

class _UnitCard extends StatefulWidget {
  final List<_UnitTile> units;
  final int totalUnits;
  const _UnitCard({required this.units, required this.totalUnits});

  @override
  State<_UnitCard> createState() => _UnitCardState();
}

class _UnitCardState extends State<_UnitCard> {
  final controller = PageController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // next page
  void next() => controller.nextPage(
    duration: Duration(milliseconds: 100),
    curve: Curves.easeInOut,
  );

  // previous page
  void prev() => controller.previousPage(
    duration: Duration(milliseconds: 100),
    curve: Curves.easeInOut,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: .circular(15),
        border: Border.all(color: context.appColors.border),
      ),
      child: Column(
        children: [
          // header
          _header(theme, context),
          Expanded(
            child: ListView.separated(
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => widget.units[index],
              separatorBuilder: (context, index) =>
                  Divider(color: context.appColors.border),
              itemCount: widget.units.length,
            ),
          ),
          // footer
          Container(
            padding: .all(12),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                // number
                Text(
                  'showing 1 to 4 of ${widget.totalUnits} units',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.appColors.muted,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: prev,
                      icon: Icon(
                        Icons.chevron_left,
                        color: context.appColors.muted,
                      ),
                    ),
                    IconButton(
                      onPressed: next,
                      icon: Icon(
                        Icons.chevron_right,
                        color: context.appColors.muted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
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

    return Container(
      padding: .all(12),
      child: Row(
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
      ),
    );
  }
}

Widget _header(ThemeData theme, BuildContext context) {
  return Container(
    padding: .all(12),
    decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
    child: Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        // unit
        Text(
          'UNIT',
          style: theme.textTheme.labelLarge?.copyWith(
            color: context.appColors.muted,
          ),
        ),
        Text(
          'TYPE',
          style: theme.textTheme.labelLarge?.copyWith(
            color: context.appColors.muted,
          ),
        ),
        Text(
          'BASE RENT / YR',
          style: theme.textTheme.labelLarge?.copyWith(
            color: context.appColors.muted,
          ),
        ),
        Text(
          'STATUS',
          style: theme.textTheme.labelLarge?.copyWith(
            color: context.appColors.muted,
          ),
        ),
        Text(
          'CURRENT TENANT',
          style: theme.textTheme.labelLarge?.copyWith(
            color: context.appColors.muted,
          ),
        ),
      ],
    ),
  );
}
