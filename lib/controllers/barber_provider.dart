import 'package:flutter/material.dart';
import '../models/barber_model.dart';
import '../services/mock/mock_barbers.dart';

class BarberProvider extends ChangeNotifier {
  List<BarberModel> _barbers = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<BarberModel> get barbers {
    if (_searchQuery.isEmpty) return _barbers;
    return _barbers.where((b) =>
      b.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      b.barberShop.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      b.specialty.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  void loadData() {
    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 300), () {
      _barbers = MockBarbers.getAll();
      _isLoading = false;
      notifyListeners();
    });
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
