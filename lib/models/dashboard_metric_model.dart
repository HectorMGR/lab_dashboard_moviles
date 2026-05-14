import 'package:flutter/material.dart';

enum TrendDirection { up, down, neutral }

class DashboardMetricModel {
  final String title;
  final String value;
  final IconData icon;
  final TrendDirection trend;
  final double percentageChange;
  final Color color;

  const DashboardMetricModel({
    required this.title,
    required this.value,
    required this.icon,
    required this.trend,
    required this.percentageChange,
    required this.color,
  });
}
