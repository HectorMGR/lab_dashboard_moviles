import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/barber_shop_provider.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/status_badge.dart';
import '../../widgets/tables/data_table_wrapper.dart';
import '../../core/utils/responsive_helper.dart';

class BarberShopsScreen extends StatefulWidget {
  const BarberShopsScreen({super.key});

  @override
  State<BarberShopsScreen> createState() => _BarberShopsScreenState();
}

class _BarberShopsScreenState extends State<BarberShopsScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BarberShopProvider>().loadData();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BarberShopProvider>();

    return Padding(
      padding: ResponsiveHelper.contentPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Barber Shops',
            subtitle: 'Manage registered barber shops',
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: 300,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search barber shops...',
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
              emptyMessage: 'No barber shops found',
              columns: const [
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Owner')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Phone')),
                DataColumn(label: Text('Barbers'), numeric: true),
                DataColumn(label: Text('Appointments'), numeric: true),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('Actions')),
              ],
              rows: provider.shops.map((shop) {
                return DataRow(cells: [
                  DataCell(Text(shop.name, style: const TextStyle(fontWeight: FontWeight.w500))),
                  DataCell(Text(shop.owner)),
                  DataCell(Text(shop.location)),
                  DataCell(Text(shop.phone)),
                  DataCell(Text(shop.barberCount.toString())),
                  DataCell(Text(shop.appointmentCount.toString())),
                  DataCell(ActiveBadge(isActive: shop.isActive)),
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
