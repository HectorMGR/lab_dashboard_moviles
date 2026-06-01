import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../repositories/firestore_service_repository.dart';

class ServiceProvider extends ChangeNotifier {
  final FirestoreServiceRepository _repo = FirestoreServiceRepository();

  List<ServiceModel> _services = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<ServiceModel> get services {
    if (_searchQuery.isEmpty) return _services;
    return _services.where((s) =>
      s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      s.category.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _services = await _repo.getAllServices();
      _services.sort((a, b) => a.name.compareTo(b.name));
    } catch (e) {
      debugPrint('Error loading services: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> createService(String shopId, ServiceModel service) async {
    try {
      await _repo.createService(shopId, service);
      _services.add(service);
      notifyListeners();
    } catch (e) {
      debugPrint('Error creating service: $e');
    }
  }

  Future<void> updateService(String shopId, String serviceId, Map<String, dynamic> data) async {
    try {
      await _repo.updateService(shopId, serviceId, data);
      final index = _services.indexWhere((s) => s.id == serviceId);
      if (index != -1) {
        _services[index] = _services[index].copyWith(
          name: data['name'] as String? ?? _services[index].name,
          price: data['price'] as double? ?? _services[index].price,
          durationMinutes: data['durationMinutes'] as int? ?? _services[index].durationMinutes,
          isActive: data['isActive'] as bool? ?? _services[index].isActive,
        );
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating service: $e');
    }
  }

  Future<void> deleteService(String shopId, String serviceId) async {
    try {
      await _repo.deleteService(shopId, serviceId);
      _services.removeWhere((s) => s.id == serviceId);
      notifyListeners();
    } catch (e) {
      debugPrint('Error deleting service: $e');
    }
  }
}