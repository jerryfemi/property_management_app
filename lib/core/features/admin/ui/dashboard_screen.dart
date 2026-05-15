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
    final stats = ref.watch(dashboardStatsProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: isMobile
          ? AppBar(
              title: Text(
                'Property Portfolio',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: .bold),
              ),
              centerTitle: false,
            )
          : null,
      backgroundColor: appColors.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // --- Stats Section ---
            if (isMobile)
              // Horizontal Swiper for Mobile (More compact & no overflow)
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: stats.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                  itemBuilder: (context, index) => SizedBox(
                    width: 180,
                    child: AdminStatCard(model: stats[index]),
                  ),
                ),
              )
            else
              // Adaptive Grid for Tablet/Desktop
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    mainAxisExtent: 180,
                  ),
                  itemCount: stats.length,
                  itemBuilder: (context, index) =>
                      AdminStatCard(model: stats[index]),
                ),
              ),

            const SizedBox(height: 40),

            // --- Placeholder for Charts/Tables ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent Activity',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: appColors.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: appColors.border.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Charts & Activity Feed Coming Soon',
                        style: TextStyle(color: appColors.muted),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
