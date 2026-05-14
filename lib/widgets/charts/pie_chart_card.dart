import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../models/report_data_model.dart';

class PieChartCard extends StatelessWidget {
  final List<PieChartItem> data;

  const PieChartCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Appointment Status Distribution', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Breakdown by appointment status',
              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 30,
                  sections: data.map((d) {
                    return PieChartSectionData(
                      color: d.color,
                      value: d.value,
                      title: d.value > 0 ? '${d.value.toInt()}' : '',
                      titleStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                      radius: 50,
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 6,
              children: data.map((d) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(width: 10, height: 10, decoration: BoxDecoration(color: d.color, borderRadius: BorderRadius.circular(2))),
                    const SizedBox(width: 4),
                    Text(
                      '${d.label}: ${d.value.toInt()}',
                      style: TextStyle(fontSize: 11, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.7)),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
