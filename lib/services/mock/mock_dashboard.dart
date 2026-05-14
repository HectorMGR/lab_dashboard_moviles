import 'package:flutter/material.dart';
import '../../models/appointment_model.dart';
import '../../models/dashboard_metric_model.dart';
import '../../core/theme/app_colors.dart';
import 'mock_appointments.dart';
import 'mock_clients.dart';
import 'mock_barbers.dart';
import 'mock_barber_shops.dart';

class MockDashboard {
  MockDashboard._();

  static List<DashboardMetricModel> getMetrics() {
    final appointments = MockAppointments.getAll();
    final todayAppointments = MockAppointments.getToday();
    final clients = MockClients.getAll();
    final barbers = MockBarbers.getAll();
    final shops = MockBarberShops.getAll();

    final confirmed = appointments.where((a) => a.status == AppointmentStatus.confirmed).length;
    final cancelled = appointments.where((a) => a.status == AppointmentStatus.cancelled).length;
    final bookingRate = appointments.isNotEmpty ? (confirmed / appointments.length * 100).toStringAsFixed(0) : '0';

    final totalRevenue = appointments
        .where((a) => a.status == AppointmentStatus.completed)
        .fold<double>(0, (sum, a) => sum + a.price);

    return [
      DashboardMetricModel(
        title: 'Today\'s Appointments',
        value: todayAppointments.length.toString(),
        icon: Icons.calendar_today,
        trend: TrendDirection.up,
        percentageChange: 12.5,
        color: AppColors.primary,
      ),
      DashboardMetricModel(
        title: 'Total Clients',
        value: clients.length.toString(),
        icon: Icons.people,
        trend: TrendDirection.up,
        percentageChange: 8.3,
        color: AppColors.info,
      ),
      DashboardMetricModel(
        title: 'Total Barbers',
        value: barbers.length.toString(),
        icon: Icons.people_outline,
        trend: TrendDirection.neutral,
        percentageChange: 0,
        color: AppColors.secondary,
      ),
      DashboardMetricModel(
        title: 'Barber Shops',
        value: shops.length.toString(),
        icon: Icons.store,
        trend: TrendDirection.up,
        percentageChange: 16.7,
        color: AppColors.accent,
      ),
      DashboardMetricModel(
        title: 'Monthly Revenue',
        value: '\$${totalRevenue.toStringAsFixed(0)}',
        icon: Icons.attach_money,
        trend: TrendDirection.up,
        percentageChange: 9.2,
        color: AppColors.success,
      ),
      DashboardMetricModel(
        title: 'Cancelled',
        value: cancelled.toString(),
        icon: Icons.cancel_outlined,
        trend: TrendDirection.down,
        percentageChange: 5.1,
        color: AppColors.error,
      ),
      DashboardMetricModel(
        title: 'Upcoming',
        value: (appointments.where((a) => a.status == AppointmentStatus.pending || a.status == AppointmentStatus.confirmed).length).toString(),
        icon: Icons.upcoming,
        trend: TrendDirection.up,
        percentageChange: 15.3,
        color: AppColors.warning,
      ),
      DashboardMetricModel(
        title: 'Booking Rate',
        value: '$bookingRate%',
        icon: Icons.trending_up,
        trend: TrendDirection.up,
        percentageChange: 3.8,
        color: Colors.purple,
      ),
    ];
  }
}
