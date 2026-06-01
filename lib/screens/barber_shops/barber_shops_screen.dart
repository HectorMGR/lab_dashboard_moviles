import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/barber_shop_provider.dart';
import '../../widgets/common/section_header.dart';
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
          SectionHeader(
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
                DataColumn(label: Text('Address')),
                DataColumn(label: Text('Phone')),
                DataColumn(label: Text('Rating')),
                DataColumn(label: Text('Active')),
              ],
              rows: provider.shops.map((shop) {
                return DataRow(cells: [
                  DataCell(Text(shop.name, style: const TextStyle(fontWeight: FontWeight.w500))),
                  DataCell(Text(shop.ownerName)),
                  DataCell(Text(shop.address, overflow: TextOverflow.ellipsis)),
                  DataCell(Text(shop.phone)),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(shop.rating.toStringAsFixed(1)),
                    ],
                  )),
                  DataCell(Switch(
                    value: shop.isActive,
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