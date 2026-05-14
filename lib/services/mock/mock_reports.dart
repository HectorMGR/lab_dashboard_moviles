import 'package:flutter/material.dart';
import '../../models/appointment_model.dart';
import '../../models/report_data_model.dart';
import '../../core/theme/app_colors.dart';
import 'mock_appointments.dart';
import 'mock_barbers.dart';

class MockReports {
  MockReports._();

  static List<BarChartItem> getAppointmentsPerBarber() {
    final barbers = MockBarbers.getAll();
    final appointments = MockAppointments.getAll();
    final colors = [
      AppColors.primary, AppColors.secondary, AppColors.success,
      AppColors.warning, AppColors.info, AppColors.error,
      Colors.purple, Colors.teal, Colors.orange, Colors.indigo,
    ];

    return barbers.asMap().entries.map((entry) {
      final barber = entry.value;
      final count = appointments.where((a) => a.barberName == barber.name).length;
      return BarChartItem(
        label: barber.name.split(' ').last,
        value: count.toDouble(),
        color: colors[entry.key % colors.length],
      );
    }).toList();
  }

  static List<PieChartItem> getStatusDistribution() {
    final appointments = MockAppointments.getAll();
    final pending = appointments.where((a) => a.status == AppointmentStatus.pending).length;
    final confirmed = appointments.where((a) => a.status == AppointmentStatus.confirmed).length;
    final completed = appointments.where((a) => a.status == AppointmentStatus.completed).length;
    final cancelled = appointments.where((a) => a.status == AppointmentStatus.cancelled).length;

    return [
      PieChartItem(label: 'Pending', value: pending.toDouble(), color: AppColors.statusPending),
      PieChartItem(label: 'Confirmed', value: confirmed.toDouble(), color: AppColors.statusConfirmed),
      PieChartItem(label: 'Completed', value: completed.toDouble(), color: AppColors.statusCompleted),
      PieChartItem(label: 'Cancelled', value: cancelled.toDouble(), color: AppColors.statusCancelled),
    ];
  }

  static LineChartSeries getMonthlyRevenue() {
    return LineChartSeries(
      label: 'Revenue',
      color: AppColors.primary,
      points: const [
        LineChartPoint(x: 0, y: 3200),
        LineChartPoint(x: 1, y: 3800),
        LineChartPoint(x: 2, y: 2900),
        LineChartPoint(x: 3, y: 4500),
        LineChartPoint(x: 4, y: 4100),
        LineChartPoint(x: 5, y: 5200),
        LineChartPoint(x: 6, y: 4800),
        LineChartPoint(x: 7, y: 5600),
        LineChartPoint(x: 8, y: 5100),
        LineChartPoint(x: 9, y: 5900),
        LineChartPoint(x: 10, y: 6300),
        LineChartPoint(x: 11, y: 7200),
      ],
    );
  }

  static ReportSummaryModel getSummary() {
    final appointments = MockAppointments.getAll();
    final completed = appointments.where((a) => a.status == AppointmentStatus.completed).length;
    final totalRevenue = appointments
        .where((a) => a.status == AppointmentStatus.completed)
        .fold<double>(0, (sum, a) => sum + a.price);

    final barbers = MockBarbers.getAll();
    final activeBarbers = barbers.where((b) => b.isActive);
    final avgRating = activeBarbers.isEmpty
        ? 0.0
        : activeBarbers.map((b) => b.rating).reduce((a, b) => a + b) / activeBarbers.length;

    return ReportSummaryModel(
      totalRevenue: '\$${totalRevenue.toStringAsFixed(0)}',
      totalAppointments: appointments.length.toString(),
      completionRate: '${(completed / appointments.length * 100).toStringAsFixed(1)}%',
      avgRating: avgRating.toStringAsFixed(1),
    );
  }
}
