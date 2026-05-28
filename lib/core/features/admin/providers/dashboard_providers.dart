import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pro_app/core/features/admin/models/dashboard_stat_model.dart';
import 'package:pro_app/core/features/maintenance/providers/ticket_provider.dart';
import 'package:pro_app/core/features/payments/providers/payments_provider.dart';
import 'package:pro_app/core/features/properties/data/property_model.dart';
import 'package:pro_app/core/features/properties/providers/property_provider.dart';
import 'package:pro_app/core/features/unit/providers/unit_provider.dart';
import 'package:pro_app/core/features/unit/data/unit_model.dart';

final dashboardStatsProvider = Provider.autoDispose<List<DashboardStatModel>>((
  ref,
) {
  // 1. Watch source providers
  final propertiesAsync = ref.watch(allPropertiesProvider);
  final paymentsAsync = ref.watch(allPaymentsProvider);
  final ticketsAsync = ref.watch(watchAllTicketsProvider);

  // 2. Extract Data
  final propCount = propertiesAsync.value?.length ?? 0;
  final totalRevenue =
      paymentsAsync.value?.fold<double>(0, (sum, p) => sum + p.amountPaid) ??
      0.0;
  final activeTickets = ticketsAsync.value?.length ?? 0;

  final totalUnits = propertiesAsync.maybeWhen(
    orElse: () => 0,
    data: (properties) {
      var sum = 0;
      for (final property in properties) {
        sum += property.totalUnits;
      }
      return sum;
    },
  );

  final occupiedAsync = ref.watch(occupiedUnisProvider);

  final totalOccupiedUnits = occupiedAsync.maybeWhen(
    orElse: () => 0,
    data: (units) => units.length,
  );

  final occupancyRate = totalUnits == 0
      ? 0.0
      : (totalOccupiedUnits / totalUnits) * 100;

  // 3. Return the mapped list
  return [
    DashboardStatModel(
      title: 'Total Properties',
      value: '$propCount',
      icon: CupertinoIcons.building_2_fill,
      color: const Color(0xFF1B4FD8), // Primary
      trend: '+2%',
      isPositive: true,
    ),
    DashboardStatModel(
      title: 'Monthly Revenue',
      value: '₦${(totalRevenue / 1000000).toStringAsFixed(1)}M',
      icon: CupertinoIcons.money_dollar_circle,
      color: const Color(0xFF10B981), // Accent/Success
      trend: '+14%',
      isPositive: true,
    ),
    DashboardStatModel(
      title: 'Occupancy Rate',
      value: '$occupancyRate%',
      icon: CupertinoIcons.person_3_fill,
      color: const Color(0xFF8B5CF6), // Purple
      trend: '-1%',
      isPositive: false,
    ),
    DashboardStatModel(
      title: 'Active Tickets',
      value: '$activeTickets',
      icon: CupertinoIcons.doc_text_fill,
      color: const Color(0xFFF59E0B), // Warning/Orange
      badgeText: '3 Pending',
    ),
  ];
});

// ── Admin Property Filters ──────────────────────────────────────────────────

// Selected filter chip state
final adminPropertyFilterProvider = StateProvider<String>((ref) => 'All');

// Filtered properties list derived from allPropertiesProvider + allUnitsProvider + filter
final filteredAdminPropertiesProvider =
    Provider.autoDispose<AsyncValue<List<PropertyModel>>>((ref) {
      final filter = ref.watch(adminPropertyFilterProvider);
      final propertiesAsync = ref.watch(allPropertiesProvider);
      final unitsAsync = ref.watch(allUnitsProvider);

      if (propertiesAsync.hasError) {
        return AsyncError(propertiesAsync.error!, propertiesAsync.stackTrace!);
      }
      if (unitsAsync.hasError) {
        return AsyncError(unitsAsync.error!, unitsAsync.stackTrace!);
      }
      if (propertiesAsync.isLoading || !propertiesAsync.hasValue) {
        return const AsyncLoading();
      }

      final properties = propertiesAsync.value!;
      if (filter == 'All') {
        return AsyncData(properties);
      }
      if (unitsAsync.isLoading || !unitsAsync.hasValue) {
        return const AsyncLoading();
      }

      final unitsByProperty = ref.watch(adminUnitsByPropertyProvider);

      final filtered = properties.where((property) {
        final propertyUnits = unitsByProperty[property.id] ?? [];

        return switch (filter) {
          'Vacant' => propertyUnits.any(
            (u) => u.unitStatus == UnitStatus.available,
          ),

          'Fully Occupied' =>
            propertyUnits.isNotEmpty &&
                propertyUnits.every((u) => u.unitStatus == UnitStatus.occupied),

          'Maintenance' => propertyUnits.any(
            (u) => u.unitStatus == UnitStatus.maintenance,
          ),

          _ => true,
        };
      }).toList();
      return AsyncData(filtered);
    });

// Extracted grouped units so AdminPropertyCard can read it synchronously
final adminUnitsByPropertyProvider =
    Provider.autoDispose<Map<String, List<UnitModel>>>((ref) {
      final unitsAsync = ref.watch(allUnitsProvider);
      final units = unitsAsync.value ?? [];

      final unitsByProperty = <String, List<UnitModel>>{};
      for (final unit in units) {
        unitsByProperty.putIfAbsent(unit.propertyId, () => []).add(unit);
      }
      return unitsByProperty;
    });

// provider for unit filter
final selectedUnitProvider = StateProvider<String>((ref) => 'All');

// filtered units for property provider
final filteredUnitsForPropertyProvider = Provider.autoDispose
    .family<AsyncValue<List<UnitModel>>, String>((ref, propertyId) {
      final filter = ref.watch(selectedUnitProvider);
      final unitAsync = ref.watch(unitsForPropertyProvider(propertyId));

      // filter method
      final units = unitAsync.value!;
      if (filter == 'all') {
        return AsyncData(units);
      }

      // filtered units
      final filtered = units.where((unit) {
        return switch (filter) {
          'Ocuupied' => unit.unitStatus == UnitStatus.occupied,
          'Vacant' => unit.unitStatus == UnitStatus.available,
          'Maintenance' => unit.unitStatus == UnitStatus.maintenance,
          'Reserved' => unit.unitStatus == UnitStatus.reserved,

          _ => true,
        };
      }).toList();
      return AsyncData(filtered);
    });
