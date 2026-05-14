import 'package:flutter/material.dart';
import '../models/appointment_model.dart';
import '../services/mock/mock_appointments.dart';

class AppointmentProvider extends ChangeNotifier {
  List<AppointmentModel> _appointments = [];
  bool _isLoading = false;
  String _searchQuery = '';
  String _statusFilter = 'All';

  List<AppointmentModel> get appointments {
    var result = _appointments;
    if (_statusFilter != 'All') {
      final status = AppointmentStatus.values.firstWhere(
        (s) => s.label == _statusFilter,
      );
      result = result.where((a) => a.status == status).toList();
    }
    if (_searchQuery.isNotEmpty) {
      result = result.where((a) =>
        a.clientName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        a.barberName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        a.barberShop.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        a.service.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }
    return result;
  }

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;
  String get statusFilter => _statusFilter;

  List<String> get statusOptions => ['All', 'Pending', 'Confirmed', 'Completed', 'Cancelled'];

  void loadData() {
    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 300), () {
      _appointments = MockAppointments.getAll();
      _isLoading = false;
      notifyListeners();
    });
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setStatusFilter(String filter) {
    _statusFilter = filter;
    notifyListeners();
  }
}
