import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/service_provider.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/status_badge.dart';
import '../../widgets/tables/data_table_wrapper.dart';
import '../../core/utils/responsive_helper.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServiceProvider>().loadData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ServiceProvider>();

    return Padding(
      padding: ResponsiveHelper.contentPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Services',
            subtitle: 'Manage available services and pricing',
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search services...',
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
              emptyMessage: 'No services found',
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Description')),
                DataColumn(label: Text('Price'), numeric: true),
                DataColumn(label: Text('Duration')),
                DataColumn(label: Text('Barber Shop')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: provider.services.map((service) {
                return DataRow(cells: [
                  DataCell(Text(service.name, style: const TextStyle(fontWeight: FontWeight.w500))),
                  DataCell(SizedBox(
                    width: 200,
                    child: Text(service.description, overflow: TextOverflow.ellipsis),
                  )),
                  DataCell(Text('\$${service.price.toStringAsFixed(2)}')),
                  DataCell(Text('${service.durationMinutes} min')),
                  DataCell(Text(service.barberShop)),
                  DataCell(ActiveBadge(isActive: service.isActive)),
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
