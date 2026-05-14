import 'package:flutter/material.dart';

class BarChartItem {
  final String label;
  final double value;
  final Color color;

  const BarChartItem({
    required this.label,
    required this.value,
    required this.color,
  });
}

class PieChartItem {
  final String label;
  final double value;
  final Color color;

  const PieChartItem({
    required this.label,
    required this.value,
    required this.color,
  });
}

class LineChartPoint {
  final double x;
  final double y;

  const LineChartPoint({required this.x, required this.y});
}

class LineChartSeries {
  final String label;
  final List<LineChartPoint> points;
  final Color color;

  const LineChartSeries({
    required this.label,
    required this.points,
    required this.color,
  });
}

class ReportSummaryModel {
  final String totalRevenue;
  final String totalAppointments;
  final String completionRate;
  final String avgRating;

  const ReportSummaryModel({
    required this.totalRevenue,
    required this.totalAppointments,
    required this.completionRate,
    required this.avgRating,
  });
}
