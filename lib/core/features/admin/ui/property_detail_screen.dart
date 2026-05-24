import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pro_app/core/features/properties/ui/widgets/category_chips.dart';
import 'package:pro_app/core/features/unit/data/unit_model.dart';
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
  final selectedUnitProvider = StateProvider<String>((ref) => 'All');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: .circular(15),
              ),child: Column(children: [],),
            ),
          ],
        ),
      ),
    );
  }
}



class _UnitCard extends StatelessWidget{
  const _UnitCard();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}



class _PropertyTile extends StatelessWidget {
  const _PropertyTile({
    required this.amenities,
    required this.onTap,
    required this.unitNumber,
    required this.baseRent,
    required this.status,
    required this.color,
    required this.tenant,
  });
  final VoidCallback onTap;
  final String unitNumber;
  final List<String> amenities;
  final String baseRent;
  final UnitStatus status;
  final Color color;
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
          backgroundColor: color.withValues(alpha: 0.2),
        ),
      ],
    );
  }
}
