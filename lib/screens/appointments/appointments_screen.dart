import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../controllers/appointment_provider.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/status_badge.dart';
import '../../widgets/tables/data_table_wrapper.dart';
import '../../core/utils/responsive_helper.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppointmentProvider>().loadData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppointmentProvider>();

    return Padding(
      padding: ResponsiveHelper.contentPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Appointments',
            subtitle: 'Manage and monitor all appointments',
            trailing: SizedBox(
              width: 200,
              child: DropdownButtonFormField<String>(
                value: provider.statusFilter,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  isDense: true,
                ),
                items: provider.statusOptions.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (val) => provider.setStatusFilter(val!),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search appointments...',
                  prefixIcon: const Icon(Icons.search, size: 20),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  isDense: true,
                ),
                onChanged: provider.setSearchQuery,
              ),
            ),
          ),
          Expanded(
            child: DataTableWrapper(
              sortColumnIndex: 3,
              sortAscending: false,
              emptyMessage: 'No appointments found',
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Client')),
                DataColumn(label: Text('Barber')),
                DataColumn(label: Text('Barber Shop')),
                DataColumn(label: Text('Service')),
                DataColumn(label: Text('Date & Time')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Price'), numeric: true),
                DataColumn(label: Text('Actions')),
              ],
              rows: provider.appointments.map((apt) {
                final dateStr = DateFormat('MMM dd, HH:mm').format(apt.dateTime);
                return DataRow(cells: [
                  DataCell(Text(apt.id, style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5), fontSize: 12))),
                  DataCell(Text(apt.clientName, style: const TextStyle(fontWeight: FontWeight.w500))),
                  DataCell(Text(apt.barberName)),
                  DataCell(Text(apt.barberShop)),
                  DataCell(Text(apt.service)),
                  DataCell(Text(dateStr)),
                  DataCell(StatusBadge(status: apt.status)),
                  DataCell(Text('\$${apt.price.toStringAsFixed(2)}')),
                  DataCell(
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, size: 18),
                      itemBuilder: (ctx) => const [
                        PopupMenuItem(value: 'view', child: Text('View')),
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(value: 'cancel', child: Text('Cancel')),
                      ],
                    ),
                  ),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
