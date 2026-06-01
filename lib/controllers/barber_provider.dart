import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repositories/firestore_user_repository.dart';

class BarberProvider extends ChangeNotifier {
  final FirestoreUserRepository _repo = FirestoreUserRepository();

  List<UserModel> _barbers = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<UserModel> get barbers {
    if (_searchQuery.isEmpty) return _barbers;
    return _barbers.where((b) =>
      b.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      b.email.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _barbers = await _repo.getUsersByRole('barber');
      _barbers.sort((a, b) => a.fullName.compareTo(b.fullName));
    } catch (e) {
      debugPrint('Error loading barbers: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> updateBarberRole(String barberId, String newRole) async {
    try {
      await _repo.updateUserRole(barberId, newRole);
      final index = _barbers.indexWhere((b) => b.uid == barberId);
      if (index != -1) {
        _barbers[index] = _barbers[index].copyWith(role: newRole);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating barber role: $e');
    }
  }
}