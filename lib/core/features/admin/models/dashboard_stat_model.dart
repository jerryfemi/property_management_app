import 'package:flutter/widgets.dart';

class DashboardStatModel {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String? trend;
  final bool? isPositive;
  final String? badgeText;

  const DashboardStatModel({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.trend,
    this.isPositive,
    this.badgeText,
  });
}
