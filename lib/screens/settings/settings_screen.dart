import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../controllers/theme_provider.dart';
import '../../widgets/common/section_header.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_helper.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Padding(
      padding: ResponsiveHelper.contentPadding(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Settings',
              subtitle: 'Manage your account and application preferences',
            ),
            _buildProfileCard(context).animate().fadeIn(duration: 300.ms),
            const SizedBox(height: 16),
            _buildAppearanceCard(context, themeProvider).animate().fadeIn(duration: 300.ms, delay: 100.ms),
            const SizedBox(height: 16),
            _buildNotificationsCard(context).animate().fadeIn(duration: 300.ms, delay: 200.ms),
            const SizedBox(height: 16),
            _buildRoleInfoCard(context).animate().fadeIn(duration: 300.ms, delay: 300.ms),
            const SizedBox(height: 16),
            _buildDangerZoneCard(context).animate().fadeIn(duration: 300.ms, delay: 400.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Admin Profile', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Your personal account information',
              style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.primary,
                  child: Text('A', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600)),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Admin User', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 4),
                      Text('admin@barberly.com', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6), fontSize: 14)),
                      const SizedBox(height: 4),
                      Text('Role: Administrator', style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6), fontSize: 14)),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceCard(BuildContext context, ThemeProvider themeProvider) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Appearance', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Customize the application look and feel',
              style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Icon(
                  themeProvider.isDark ? Icons.dark_mode : Icons.light_mode,
                  color: themeProvider.isDark ? Colors.amber : AppColors.accent,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Dark Mode', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      Text(
                        themeProvider.isDark ? 'Dark theme is enabled' : 'Light theme is enabled',
                        style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: themeProvider.isDark,
                  onChanged: (_) => themeProvider.toggleTheme(),
                  activeColor: AppColors.primary,
                ),
              ],
            ),
            const Divider(height: 32),
            Row(
              children: [
                const Icon(Icons.palette_outlined, size: 22, color: AppColors.secondary),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Primary Color', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                      Text(
                        'Indigo (#6366F1)',
                        style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Notification Preferences', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Choose which notifications you want to receive',
              style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
            ),
            const SizedBox(height: 20),
            _buildSwitchRow(context, 'Appointment Reminders', 'Get notified of upcoming appointments', true),
            const Divider(height: 24),
            _buildSwitchRow(context, 'New Bookings', 'Receive alerts for new appointment bookings', true),
            const Divider(height: 24),
            _buildSwitchRow(context, 'Cancellations', 'Get notified when appointments are cancelled', true),
            const Divider(height: 24),
            _buildSwitchRow(context, 'Weekly Reports', 'Receive weekly performance summaries', false),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchRow(BuildContext context, String title, String subtitle, bool value) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              Text(subtitle, style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5))),
            ],
          ),
        ),
        Switch(value: value, onChanged: (_) {}, activeColor: AppColors.primary),
      ],
    );
  }

  Widget _buildRoleInfoCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Role & Permissions', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Your current access level and permissions',
              style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
            ),
            const SizedBox(height: 20),
            _buildPermissionRow('Dashboard', true),
            _buildPermissionRow('Appointments Management', true),
            _buildPermissionRow('Barber Shop Management', true),
            _buildPermissionRow('Barber Management', true),
            _buildPermissionRow('Client Management', true),
            _buildPermissionRow('Services Management', true),
            _buildPermissionRow('Reports & Analytics', true),
            _buildPermissionRow('Settings', true),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionRow(String label, bool granted) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(
            granted ? Icons.check_circle : Icons.cancel,
            color: granted ? AppColors.success : AppColors.error,
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(label, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildDangerZoneCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Danger Zone', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.error)),
            const SizedBox(height: 4),
            Text(
              'Irreversible account actions',
              style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, size: 18),
                label: const Text('Sign Out'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: BorderSide(color: AppColors.error.withValues(alpha: 0.3)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
