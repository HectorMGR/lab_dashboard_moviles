import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _isSidebarExpanded = true;

  int get selectedIndex => _selectedIndex;
  bool get isSidebarExpanded => _isSidebarExpanded;

  void setSelectedIndex(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  void toggleSidebar() {
    _isSidebarExpanded = !_isSidebarExpanded;
    notifyListeners();
  }

  void setSidebarExpanded(bool expanded) {
    if (_isSidebarExpanded != expanded) {
      _isSidebarExpanded = expanded;
      notifyListeners();
    }
  }
}
