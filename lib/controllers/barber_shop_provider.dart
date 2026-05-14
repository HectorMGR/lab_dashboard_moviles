import 'package:flutter/material.dart';
import '../models/barber_shop_model.dart';
import '../services/mock/mock_barber_shops.dart';

class BarberShopProvider extends ChangeNotifier {
  List<BarberShopModel> _shops = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<BarberShopModel> get shops {
    if (_searchQuery.isEmpty) return _shops;
    return _shops.where((s) =>
      s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      s.owner.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      s.location.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  void loadData() {
    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 300), () {
      _shops = MockBarberShops.getAll();
      _isLoading = false;
      notifyListeners();
    });
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
