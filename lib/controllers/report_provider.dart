import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/report_data_model.dart';
import '../models/booking_model.dart';
import '../repositories/firestore_booking_repository.dart';
import '../repositories/firestore_barbershop_repository.dart';
import '../repositories/firestore_user_repository.dart';

class ReportProvider extends ChangeNotifier {
  final FirestoreBookingRepository _bookingRepo = FirestoreBookingRepository();
  final FirestoreBarbershopRepository _shopRepo = FirestoreBarbershopRepository();
  final FirestoreUserRepository _userRepo = FirestoreUserRepository();

  List<BarChartItem> _barData = [];
  List<PieChartItem> _pieData = [];
  LineChartSeries _lineData = LineChartSeries(label: '', points: [], color: Colors.blue);
  ReportSummaryModel _summary = const ReportSummaryModel(
    totalRevenue: '\$0',
    totalAppointments: '0',
    completionRate: '0%',
    avgRating: '0',
  );
  bool _isLoading = false;

  List<BarChartItem> get barData => _barData;
  List<PieChartItem> get pieData => _pieData;
  LineChartSeries get lineData => _lineData;
  ReportSummaryModel get summary => _summary;
  bool get isLoading => _isLoading;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      final allBookings = await _bookingRepo.getAllBookings();
      final allBarbers = await _userRepo.getUsersByRole('barber');
      final allShops = await _shopRepo.getAllBarbershops();

      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
      final recentBookings = allBookings.where((b) => b.slotStart.isAfter(thirtyDaysAgo)).toList();

      final barberCounts = <String, int>{};
      for (final b in recentBookings) {
        barberCounts[b.barberId] = (barberCounts[b.barberId] ?? 0) + 1;
      }
      _barData = allBarbers.map((barber) {
        final count = barberCounts[barber.uid] ?? 0;
        return BarChartItem(
          label: barber.fullName,
          value: count.toDouble(),
          color: Colors.blue,
        );
      }).where((item) => item.value > 0).toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      final statusCounts = <BookingStatus, int>{};
      for (final b in allBookings) {
        statusCounts[b.status] = (statusCounts[b.status] ?? 0) + 1;
      }
      _pieData = statusCounts.entries.map((e) => PieChartItem(
        label: e.key.label,
        value: e.value.toDouble(),
        color: e.key.color,
      )).toList();

      final sixMonthsAgo = DateTime.now().subtract(const Duration(days: 180));
      final monthlyRevenue = <String, double>{};
      for (final b in allBookings.where((b) =>
        b.slotStart.isAfter(sixMonthsAgo) && b.status == BookingStatus.completed
      )) {
        final monthKey = DateFormat('MMM').format(b.slotStart);
        monthlyRevenue[monthKey] = (monthlyRevenue[monthKey] ?? 0) + b.price;
      }
      _lineData = LineChartSeries(
        label: 'Revenue',
        points: monthlyRevenue.entries.map((e) => LineChartPoint(
          x: monthlyRevenue.keys.toList().indexOf(e.key).toDouble(),
          y: e.value,
        )).toList(),
        color: Colors.blue,
      );

      final totalRevenue = allBookings
          .where((b) => b.status == BookingStatus.completed)
          .fold(0.0, (sum, b) => sum + b.price);
      final completed = allBookings.where((b) => b.status == BookingStatus.completed).length;
      final completionRate = allBookings.isNotEmpty ? (completed / allBookings.length * 100) : 0.0;
      final avgRating = allShops.isNotEmpty
          ? allShops.map((s) => s.rating).reduce((a, b) => a + b) / allShops.length
          : 0.0;

      _summary = ReportSummaryModel(
        totalRevenue: '\$${totalRevenue.toStringAsFixed(0)}',
        totalAppointments: allBookings.length.toString(),
        completionRate: '${completionRate.toStringAsFixed(1)}%',
        avgRating: avgRating.toStringAsFixed(1),
      );

    } catch (e) {
      debugPrint('Error loading reports: $e');
    }

    _isLoading = false;
    notifyListeners();
  }
}