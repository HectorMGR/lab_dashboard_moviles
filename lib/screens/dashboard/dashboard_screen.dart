import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../controllers/dashboard_provider.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/cards/metric_card.dart';
import '../../widgets/tables/data_table_wrapper.dart';
import '../../widgets/common/status_badge.dart';
import '../../services/mock/mock_appointments.dart';
import '../../core/utils/responsive_helper.dart';

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
    final metrics = provider.metrics;
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
              itemCount: metrics.length,
              itemBuilder: (context, index) {
                return MetricCard(metric: metrics[index])
                    .animate()
                    .fadeIn(duration: 300.ms, delay: (50 * index).ms)
                    .slideY(begin: 0.1, end: 0, duration: 300.ms, delay: (50 * index).ms);
              },
            ),
            const SizedBox(height: 32),
            const SectionHeader(
              title: 'Recent Appointments',
              subtitle: 'Latest appointments across all barber shops',
            ),
            _buildRecentAppointmentsTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentAppointmentsTable() {
    final appointments = MockAppointments.getAll().take(8).toList();

    return DataTableWrapper(
      columns: const [
        DataColumn(label: Text('Client')),
        DataColumn(label: Text('Barber')),
        DataColumn(label: Text('Service')),
        DataColumn(label: Text('Date')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Price'), numeric: true),
      ],
      rows: appointments.map((apt) {
        return DataRow(cells: [
          DataCell(Text(apt.clientName, style: const TextStyle(fontWeight: FontWeight.w500))),
          DataCell(Text(apt.barberName)),
          DataCell(Text(apt.service)),
          DataCell(Text('${apt.dateTime.hour}:${apt.dateTime.minute.toString().padLeft(2, '0')}')),
          DataCell(StatusBadge(status: apt.status)),
          DataCell(Text('\$${apt.price.toStringAsFixed(2)}')),
        ]);
      }).toList(),
    );
  }
}
