import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../services/mock/mock_services.dart';

class ServiceProvider extends ChangeNotifier {
  List<ServiceModel> _services = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<ServiceModel> get services {
    if (_searchQuery.isEmpty) return _services;
    return _services.where((s) =>
      s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      s.barberShop.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  void loadData() {
    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 300), () {
      _services = MockServices.getAll();
      _isLoading = false;
      notifyListeners();
    });
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
