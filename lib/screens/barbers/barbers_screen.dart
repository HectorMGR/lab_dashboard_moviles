import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/barber_provider.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/status_badge.dart';
import '../../widgets/tables/data_table_wrapper.dart';
import '../../core/utils/responsive_helper.dart';

class BarbersScreen extends StatefulWidget {
  const BarbersScreen({super.key});

  @override
  State<BarbersScreen> createState() => _BarbersScreenState();
}

class _BarbersScreenState extends State<BarbersScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BarberProvider>().loadData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BarberProvider>();

    return Padding(
      padding: ResponsiveHelper.contentPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Barbers',
            subtitle: 'Manage barbers and their assignments',
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search barbers...',
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
              emptyMessage: 'No barbers found',
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Barber Shop')),
                DataColumn(label: Text('Specialty')),
                DataColumn(label: Text('Availability')),
                DataColumn(label: Text('Rating'), numeric: true),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: provider.barbers.map((barber) {
                return DataRow(cells: [
                  DataCell(Text(barber.name, style: const TextStyle(fontWeight: FontWeight.w500))),
                  DataCell(Text(barber.barberShop)),
                  DataCell(Text(barber.specialty)),
                  DataCell(Text(barber.availability)),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(barber.rating.toStringAsFixed(1)),
                    ],
                  )),
                  DataCell(ActiveBadge(isActive: barber.isActive)),
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
