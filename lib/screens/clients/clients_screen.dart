import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../controllers/client_provider.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/status_badge.dart';
import '../../widgets/tables/data_table_wrapper.dart';
import '../../core/utils/responsive_helper.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ClientProvider>().loadData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ClientProvider>();

    return Padding(
      padding: ResponsiveHelper.contentPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Clients',
            subtitle: 'Manage client accounts and history',
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search clients...',
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
              emptyMessage: 'No clients found',
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Phone')),
                DataColumn(label: Text('Appointments'), numeric: true),
                DataColumn(label: Text('Last Appointment')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: provider.clients.map((client) {
                final dateStr = DateFormat('MMM dd, yyyy').format(client.lastAppointment);
                return DataRow(cells: [
                  DataCell(Text(client.name, style: const TextStyle(fontWeight: FontWeight.w500))),
                  DataCell(Text(client.email)),
                  DataCell(Text(client.phone)),
                  DataCell(Text(client.totalAppointments.toString())),
                  DataCell(Text(dateStr)),
                  DataCell(ActiveBadge(isActive: client.isActive)),
                  DataCell(
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert, size: 18),
                      itemBuilder: (ctx) => const [
                        PopupMenuItem(value: 'view', child: Text('View')),
                        PopupMenuItem(value: 'edit', child: Text('Edit')),
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
