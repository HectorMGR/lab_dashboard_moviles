import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../controllers/theme_provider.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';

class AppTopbar extends StatelessWidget {
  final VoidCallback onMenuTap;

  const AppTopbar({super.key, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final now = DateTime.now();
    final dateString = DateFormat('EEEE, MMMM d, yyyy').format(now);

    return Container(
      height: AppConstants.topbarHeight,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu, size: 22),
            onPressed: onMenuTap,
            tooltip: 'Toggle sidebar',
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              dateString,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                fontSize: 13,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search, size: 20),
            onPressed: () {},
            tooltip: 'Search',
          ),
          const SizedBox(width: 4),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 20),
                onPressed: () {},
                tooltip: 'Notifications',
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            width: 1,
            height: 24,
            color: Theme.of(context).dividerColor,
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              const CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.primary,
                child: Text('A', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
              ),
              const SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Admin User',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                  Text(
                    'Administrator',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
