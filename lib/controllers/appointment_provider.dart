import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../repositories/firestore_booking_repository.dart';

class AppointmentProvider extends ChangeNotifier {
  final FirestoreBookingRepository _repo = FirestoreBookingRepository();

  List<BookingModel> _appointments = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String _statusFilter = 'All';

  List<BookingModel> get appointments {
    var result = _appointments;
    if (_statusFilter != 'All') {
      final status = BookingStatus.values.firstWhere(
        (s) => s.label == _statusFilter,
        orElse: () => BookingStatus.pending,
      );
      result = result.where((a) => a.status == status).toList();
    }
    if (_searchQuery.isNotEmpty) {
      result = result.where((a) =>
        a.clientName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        a.barberName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        a.shopName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        a.serviceName.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    return result;
  }

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String get statusFilter => _statusFilter;

  List<String> get statusOptions => ['All', 'Pending', 'Confirmed', 'In Progress', 'Completed', 'Cancelled'];

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _appointments = await _repo.getAllBookings();
      _appointments.sort((a, b) => b.slotStart.compareTo(a.slotStart));
    } catch (e) {
      debugPrint('Error loading appointments: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setStatusFilter(String filter) {
    _statusFilter = filter;
    notifyListeners();
  }

  Future<void> updateStatus(String bookingId, BookingStatus status) async {
    try {
      await _repo.updateBookingStatus(bookingId, status);
      final index = _appointments.indexWhere((a) => a.id == bookingId);
      if (index != -1) {
        _appointments[index] = _appointments[index].copyWith(status: status);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating booking status: $e');
    }
  }

  Future<void> cancelBooking(String bookingId) async {
    try {
      await _repo.cancelBooking(bookingId);
      final index = _appointments.indexWhere((a) => a.id == bookingId);
      if (index != -1) {
        _appointments[index] = _appointments[index].copyWith(status: BookingStatus.cancelled);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error cancelling booking: $e');
    }
  }
}