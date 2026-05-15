import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/core/features/admin/models/dashboard_stat_model.dart';
import 'package:pro_app/core/features/maintenance/providers/ticket_provider.dart';
import 'package:pro_app/core/features/payments/providers/payments_provider.dart';
import 'package:pro_app/core/features/properties/providers/property_provider.dart';

final dashboardStatsProvider = Provider<List<DashboardStatModel>>((ref) {
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
  const occupancyRate = 94; // Placeholder for now

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
    DashboardStatModel(
      title: 'Active Tickets',
      value: '$activeTickets',
      icon: CupertinoIcons.doc_text_fill,
      color: const Color(0xFFF59E0B), // Warning/Orange
      badgeText: '3 Pending',
    ),
  ];
});
