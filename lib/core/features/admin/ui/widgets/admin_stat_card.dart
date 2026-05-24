import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pro_app/core/features/admin/models/dashboard_stat_model.dart';
import 'package:pro_app/core/theme/app_theme.dart';

class AdminStatCard extends StatelessWidget {
  final DashboardStatModel model;

  const AdminStatCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appColors = context.appColors;

    final isMobile = MediaQuery.of(context).size.width < 900;

    return Container(
      padding: EdgeInsets.all(isMobile ? 10 : 24),
      decoration: BoxDecoration(
        color: appColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: appColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon Container
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: model.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(model.icon, color: model.color, size: 24),
              ),
              // Trend or Status Badge
              if (model.trend != null)
                _TrendBadge(
                  trend: model.trend!,
                  isPositive: model.isPositive ?? true,
                )
              else if (model.badgeText != null)
                _StatusBadge(text: model.badgeText!, color: model.color),
            ],
          ),
          const SizedBox(height: 14),
          // Title Label
          Text(
            model.title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: appColors.muted,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: isMobile ? 4 : 8),
          // Statistics Value
          Text(
            model.value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              fontSize: isMobile ? 20 : 28,
              letterSpacing: -0.5,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ],
      ),
    );
  }
}

class _TrendBadge extends StatelessWidget {
  final String trend;
  final bool isPositive;

  const _TrendBadge({required this.trend, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    final color = isPositive
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.error;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            trend,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          Icon(
            isPositive ? CupertinoIcons.arrow_up : CupertinoIcons.arrow_down,
            color: color,
            size: 12,
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String text;
  final Color color;

  const _StatusBadge({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
