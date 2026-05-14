import 'package:flutter/material.dart';
import '../models/dashboard_metric_model.dart';
import '../services/mock/mock_dashboard.dart';

class DashboardProvider extends ChangeNotifier {
  List<DashboardMetricModel> _metrics = [];
  bool _isLoading = false;

  List<DashboardMetricModel> get metrics => _metrics;
  bool get isLoading => _isLoading;

  void loadData() {
    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 400), () {
      _metrics = MockDashboard.getMetrics();
      _isLoading = false;
      notifyListeners();
    });
  }
}
