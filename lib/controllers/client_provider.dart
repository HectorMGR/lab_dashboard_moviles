import 'package:flutter/material.dart';
import '../models/client_model.dart';
import '../services/mock/mock_clients.dart';

class ClientProvider extends ChangeNotifier {
  List<ClientModel> _clients = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<ClientModel> get clients {
    if (_searchQuery.isEmpty) return _clients;
    return _clients.where((c) =>
      c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      c.email.toLowerCase().contains(_searchQuery.toLowerCase()) ||
      c.phone.contains(_searchQuery)
    ).toList();
  }

  bool get isLoading => _isLoading;
  String get searchQuery => _searchQuery;

  void loadData() {
    _isLoading = true;
    notifyListeners();
    Future.delayed(const Duration(milliseconds: 300), () {
      _clients = MockClients.getAll();
      _isLoading = false;
      notifyListeners();
    });
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
