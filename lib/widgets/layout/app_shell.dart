import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../controllers/navigation_provider.dart';
import 'app_sidebar.dart';
import 'app_topbar.dart';

class AppShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    final isExpanded = navProvider.isSidebarExpanded;

    return Scaffold(
      body: Row(
        children: [
          AppSidebar(
            isExpanded: isExpanded,
            selectedIndex: navigationShell.currentIndex,
            onItemSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            onToggle: () => navProvider.toggleSidebar(),
          ),
          Expanded(
            child: Column(
              children: [
                AppTopbar(
                  onMenuTap: () => navProvider.toggleSidebar(),
                ),
                Expanded(
                  child: navigationShell,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
