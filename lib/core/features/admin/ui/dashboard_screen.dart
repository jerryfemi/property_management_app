import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pro_app/core/features/admin/providers/dashboard_providers.dart';
import 'package:pro_app/core/features/admin/ui/widgets/admin_stat_card.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appColors = context.appColors;

    // Now the UI only watches one provider for all the stats!
    final stats = ref.watch(dashboardStatsProvider);

    return Scaffold(
      backgroundColor: appColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                mainAxisExtent: 180,
              ),
              itemCount: stats.length,
              itemBuilder: (context, index) =>
                  AdminStatCard(model: stats[index]),
            ),

            const SizedBox(height: 40),
            // More dashboard content can go here
          ],
        ),
      ),
    );
  }
}
