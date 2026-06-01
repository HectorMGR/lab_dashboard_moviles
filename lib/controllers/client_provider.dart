import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../repositories/firestore_user_repository.dart';

class ClientProvider extends ChangeNotifier {
  final FirestoreUserRepository _repo = FirestoreUserRepository();

  List<UserModel> _clients = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<UserModel> get clients {
    if (_searchQuery.isEmpty) return _clients;
    return _clients.where((c) =>
      c.fullName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      c.email.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _clients = await _repo.getUsersByRole('client');
      _clients.sort((a, b) => a.fullName.compareTo(b.fullName));
    } catch (e) {
      debugPrint('Error loading clients: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  Future<void> updateClientRole(String clientId, String newRole) async {
    try {
      await _repo.updateUserRole(clientId, newRole);
      final index = _clients.indexWhere((c) => c.uid == clientId);
      if (index != -1) {
        _clients[index] = _clients[index].copyWith(role: newRole);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error updating client role: $e');
    }
  }
}