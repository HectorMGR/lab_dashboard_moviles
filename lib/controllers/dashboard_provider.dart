import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../repositories/firestore_booking_repository.dart';

class DashboardProvider extends ChangeNotifier {
  final FirestoreBookingRepository _bookingRepo = FirestoreBookingRepository();

  double incomeToday = 0;
  double incomePreviousDay = 0;
  int completedAppointmentsToday = 0;
  int totalAppointmentsToday = 0;
  List<double> weeklyPerformance = List.filled(7, 0);
  int todayWeekdayIndex = DateTime.now().weekday - 1;
  List<BookingModel> todayAppointments = [];
  bool _isLoading = false;

  double get incomeChange {
    if (incomePreviousDay == 0) return incomeToday > 0 ? 100 : 0;
    return ((incomeToday - incomePreviousDay) / incomePreviousDay) * 100;
  }

  bool get isLoading => _isLoading;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final allBookings = await _bookingRepo.getAllBookings();
      final now = DateTime.now();
      final todayStart = DateTime(now.year, now.month, now.day);
      final todayEnd = todayStart.add(const Duration(days: 1));
      final yesterdayStart = todayStart.subtract(const Duration(days: 1));

      final todayBookings = allBookings.where((b) =>
        b.slotStart.isAfter(todayStart) && b.slotStart.isBefore(todayEnd)
      ).toList();

      incomeToday = todayBookings
          .where((b) => b.status == BookingStatus.completed)
          .fold(0.0, (sum, b) => sum + b.price);
      completedAppointmentsToday = todayBookings
          .where((b) => b.status == BookingStatus.completed)
          .length;
      totalAppointmentsToday = todayBookings.length;
      todayAppointments = List<BookingModel>.from(todayBookings)
        ..sort((a, b) => a.slotStart.compareTo(b.slotStart));

      final yesterdayBookings = allBookings.where((b) =>
        b.slotStart.isAfter(yesterdayStart) && b.slotStart.isBefore(todayStart)
      ).toList();

      incomePreviousDay = yesterdayBookings
          .where((b) => b.status == BookingStatus.completed)
          .fold(0.0, (sum, b) => sum + b.price);

      final weekStart = todayStart.subtract(Duration(days: now.weekday - 1));
      final weekEnd = weekStart.add(const Duration(days: 7));
      final weekBookings = allBookings.where((b) =>
        b.slotStart.isAfter(weekStart) && b.slotStart.isBefore(weekEnd)
      ).toList();

      final countsPerDay = List.filled(7, 0);
      for (final booking in weekBookings) {
        final dayIndex = (booking.slotStart.weekday - 1) % 7;
        countsPerDay[dayIndex]++;
      }

      final maxCount = countsPerDay.reduce((a, b) => a > b ? a : b);
      weeklyPerformance = maxCount > 0
          ? countsPerDay.map((c) => c / maxCount).toList()
          : List.filled(7, 0.0);

    } catch (e) {
      debugPrint('Error loading dashboard data: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}