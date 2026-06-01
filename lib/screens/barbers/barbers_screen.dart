import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/barber_provider.dart';
import '../../widgets/common/section_header.dart';
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
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Barbershop')),
                DataColumn(label: Text('Active')),
              ],
              rows: provider.barbers.map((barber) {
                return DataRow(cells: [
                  DataCell(Text(barber.fullName, style: const TextStyle(fontWeight: FontWeight.w500))),
                  DataCell(Text(barber.email)),
                  DataCell(Text(barber.barbershopId ?? 'Not assigned')),
                  DataCell(Switch(
                    value: barber.isActive,
                    onChanged: null,
                  )),
                ]);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}