import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../controllers/dashboard_provider.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/cards/metric_card.dart';
import '../../widgets/tables/data_table_wrapper.dart';
import '../../widgets/common/status_badge.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_helper.dart';
import '../../models/dashboard_metric_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    final crossAxisCount = ResponsiveHelper.cardGridColumns(context);

    return Padding(
      padding: ResponsiveHelper.contentPadding(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SectionHeader(
              title: 'Dashboard',
              subtitle: 'Welcome back! Here\'s your business overview.',
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.3,
              ),
              itemCount: _buildMetrics(provider).length,
              itemBuilder: (context, index) {
                return MetricCard(metric: _buildMetrics(provider)[index])
                    .animate()
                    .fadeIn(duration: 300.ms, delay: (50 * index).ms)
                    .slideY(begin: 0.1, end: 0, duration: 300.ms, delay: (50 * index).ms);
              },
            ),
            const SizedBox(height: 32),
            const SectionHeader(
              title: 'Today\'s Appointments',
              subtitle: 'Upcoming appointments for today',
            ),
            _buildTodayAppointmentsTable(provider),
          ],
        ),
      ),
    );
  }

  List<DashboardMetricModel> _buildMetrics(DashboardProvider provider) {
    return [
      DashboardMetricModel(
        title: 'Today\'s Appointments',
        value: provider.totalAppointmentsToday.toString(),
        icon: Icons.calendar_today,
        trend: TrendDirection.up,
        percentageChange: 12.5,
        color: AppColors.primary,
      ),
      DashboardMetricModel(
        title: 'Income Today',
        value: '\$${provider.incomeToday.toStringAsFixed(0)}',
        icon: Icons.attach_money,
        trend: provider.incomeChange >= 0 ? TrendDirection.up : TrendDirection.down,
        percentageChange: provider.incomeChange.abs(),
        color: AppColors.success,
      ),
      DashboardMetricModel(
        title: 'Completed Today',
        value: provider.completedAppointmentsToday.toString(),
        icon: Icons.check_circle,
        trend: TrendDirection.up,
        percentageChange: 5.2,
        color: AppColors.info,
      ),
      DashboardMetricModel(
        title: 'Pending',
        value: (provider.totalAppointmentsToday - provider.completedAppointmentsToday).toString(),
        icon: Icons.pending_actions,
        trend: TrendDirection.neutral,
        percentageChange: 0,
        color: AppColors.warning,
      ),
    ];
  }

  Widget _buildTodayAppointmentsTable(DashboardProvider provider) {
    if (provider.todayAppointments.isEmpty) {
      return const DataTableWrapper(
        emptyMessage: 'No appointments today',
        columns: [],
        rows: [],
      );
    }

    return DataTableWrapper(
      columns: const [
        DataColumn(label: Text('Client')),
        DataColumn(label: Text('Barber')),
        DataColumn(label: Text('Service')),
        DataColumn(label: Text('Time')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Price'), numeric: true),
      ],
      rows: provider.todayAppointments.map((apt) {
        final timeStr = DateFormat('HH:mm').format(apt.slotStart);
        return DataRow(cells: [
          DataCell(Text(apt.clientName, style: const TextStyle(fontWeight: FontWeight.w500))),
          DataCell(Text(apt.barberName)),
          DataCell(Text(apt.serviceName)),
          DataCell(Text(timeStr)),
          DataCell(StatusBadge(status: apt.status)),
          DataCell(Text('\$${apt.price.toStringAsFixed(2)}')),
        ]);
      }).toList(),
    );
  }
}