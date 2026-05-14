import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class DataTableWrapper extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final String? emptyMessage;
  final int? sortColumnIndex;
  final bool sortAscending;

  const DataTableWrapper({
    super.key,
    required this.columns,
    required this.rows,
    this.emptyMessage,
    this.sortColumnIndex,
    this.sortAscending = true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: rows.isEmpty
            ? SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    emptyMessage ?? 'No data available',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  final tableHeight = constraints.maxHeight.isInfinite
                      ? 500.0
                      : constraints.maxHeight;
                  return SizedBox(
                    height: tableHeight,
                    child: DataTable2(
                      sortColumnIndex: sortColumnIndex,
                      sortAscending: sortAscending,
                      columnSpacing: 20,
                      horizontalMargin: 12,
                      minWidth: 600,
                      dataRowHeight: 52,
                      headingRowHeight: 44,
                      headingRowColor: WidgetStateProperty.all(
                        Theme.of(context).scaffoldBackgroundColor,
                      ),
                      columns: columns,
                      rows: rows,
                      headingTextStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
