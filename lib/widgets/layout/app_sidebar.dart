import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/auth_provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

class AppSidebar extends StatelessWidget {
  final bool isExpanded;
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onToggle;

  const AppSidebar({
    super.key,
    required this.isExpanded,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.onToggle,
  });

  static const _navItems = [
    _NavItem('Dashboard', Icons.dashboard_outlined, Icons.dashboard),
    _NavItem('Appointments', Icons.calendar_today_outlined, Icons.calendar_today),
    _NavItem('Barber Shops', Icons.store_outlined, Icons.store),
    _NavItem('Barbers', Icons.people_outline, Icons.people),
    _NavItem('Clients', Icons.person_outline, Icons.person),
    _NavItem('Services', Icons.content_cut, Icons.content_cut),
    _NavItem('Reports', Icons.bar_chart_outlined, Icons.bar_chart),
    _NavItem('Settings', Icons.settings_outlined, Icons.settings),
  ];

  @override
  Widget build(BuildContext context) {
    final width = isExpanded
        ? AppConstants.sidebarExpandedWidth
        : AppConstants.sidebarCollapsedWidth;
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.userModel;

    return AnimatedContainer(
      duration: AppConstants.animationDuration,
      curve: Curves.easeInOut,
      width: width,
      color: AppColors.sidebarBg,
      child: Column(
        children: [
          _buildHeader(),
          const Divider(color: AppColors.darkBorder, height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: _navItems.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;
                return _SidebarItem(
                  item: item,
                  isSelected: selectedIndex == index,
                  isExpanded: isExpanded,
                  onTap: () => onItemSelected(index),
                );
              }).toList(),
            ),
          ),
          const Divider(color: AppColors.darkBorder, height: 1),
          _buildFooter(context, authProvider, user),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: AppConstants.topbarHeight,
      padding: EdgeInsets.symmetric(horizontal: isExpanded ? 16 : 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final showText = constraints.maxWidth > 80;
          final logo = Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.gradientEnd],
              ),
            ),
            child: const Icon(Icons.content_cut, color: Colors.white, size: 20),
          );

          if (!showText) return Center(child: logo);

          return Row(
            children: [
              logo,
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Barberly',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFooter(BuildContext context, AuthProvider authProvider, user) {
    final displayName = user?.fullName ?? 'Admin User';
    final role = user?.role ?? 'Administrator';

    return Container(
      height: AppConstants.topbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: isExpanded
          ? Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.primary,
                  child: Text(
                    displayName.isNotEmpty ? displayName[0].toUpperCase() : 'A',
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayName,
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        role,
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.chevron_left, color: Colors.white.withValues(alpha: 0.6), size: 20),
                  onPressed: onToggle,
                  tooltip: 'Collapse sidebar',
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                ),
              ],
            )
          : Center(
              child: IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.white, size: 20),
                onPressed: onToggle,
                tooltip: 'Expand sidebar',
                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              ),
            ),
    );
  }
}

class _SidebarItem extends StatefulWidget {
  final _NavItem item;
  final bool isSelected;
  final bool isExpanded;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.item,
    required this.isSelected,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  State<_SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<_SidebarItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: Material(
          color: _isHovered || widget.isSelected ? AppColors.sidebarHover : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(8),
            child: AnimatedContainer(
              duration: AppConstants.animationDuration,
              height: 44,
              padding: EdgeInsets.symmetric(
                horizontal: widget.isExpanded ? 16 : 12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: widget.isSelected
                    ? const Border(left: BorderSide(color: AppColors.primary, width: 3))
                    : null,
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final showText = constraints.maxWidth > 120;
                  return Row(
                    children: [
                      Icon(
                        widget.isSelected ? widget.item.activeIcon : widget.item.icon,
                        color: widget.isSelected ? Colors.white : Colors.white.withValues(alpha: 0.6),
                        size: 22,
                      ),
                      if (showText) ...[
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            widget.item.label,
                            style: TextStyle(
                              color: widget.isSelected ? Colors.white : Colors.white.withValues(alpha: 0.6),
                              fontSize: 14,
                              fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  const _NavItem(this.label, this.icon, this.activeIcon);
}