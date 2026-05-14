import 'package:flutter/material.dart';
import '../models/report_data_model.dart';
import '../services/mock/mock_reports.dart';

class ReportProvider extends ChangeNotifier {
  List<BarChartItem> _barData = [];
  List<PieChartItem> _pieData = [];
  LineChartSeries _lineData = LineChartSeries(label: '', points: [], color: Colors.blue);
  ReportSummaryModel _summary = const ReportSummaryModel(totalRevenue: '', totalAppointments: '', completionRate: '', avgRating: '');
  bool _isLoading = false;

  List<BarChartItem> get barData => _barData;
  List<PieChartItem> get pieData => _pieData;
  LineChartSeries get lineData => _lineData;
  ReportSummaryModel get summary => _summary;
  bool get isLoading => _isLoading;

  void loadData() {
    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 500), () {
      _barData = MockReports.getAppointmentsPerBarber();
      _pieData = MockReports.getStatusDistribution();
      _lineData = MockReports.getMonthlyRevenue();
      _summary = MockReports.getSummary();
      _isLoading = false;
      notifyListeners();
    });
  }
}
