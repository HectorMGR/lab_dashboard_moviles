import 'package:flutter/material.dart';
import '../models/barbershop_model.dart';
import '../repositories/firestore_barbershop_repository.dart';

class BarberShopProvider extends ChangeNotifier {
  final FirestoreBarbershopRepository _repo = FirestoreBarbershopRepository();

  List<BarbershopModel> _shops = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<BarbershopModel> get shops {
    if (_searchQuery.isEmpty) return _shops;
    return _shops.where((s) =>
      s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      s.ownerName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      s.address.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _shops = await _repo.getAllBarbershops();
      _shops.sort((a, b) => a.name.compareTo(b.name));
    } catch (e) {
      debugPrint('Error loading barbershops: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> createShop(BarbershopModel shop) async {
    try {
      await _repo.createBarbershop(shop);
      _shops.add(shop);
      notifyListeners();
    } catch (e) {
      debugPrint('Error creating barbershop: $e');
    }
  }

  Future<void> updateShop(String shopId, Map<String, dynamic> data) async {
    try {
      await _repo.updateBarbershop(shopId, data);
      final index = _shops.indexWhere((s) => s.id == shopId);
      if (index != -1) {
        _shops[index] = _shops[index].copyWith(
          name: data['name'] as String? ?? _shops[index].name,
          phone: data['phone'] as String? ?? _shops[index].phone,
          address: data['address'] as String? ?? _shops[index].address,
          isActive: data['isActive'] as bool? ?? _shops[index].isActive,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating barbershop: $e');
    }
  }

  Future<void> deleteShop(String shopId) async {
    try {
      await _repo.deleteBarbershop(shopId);
      _shops.removeWhere((s) => s.id == shopId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting barbershop: $e');
    }
  }
}