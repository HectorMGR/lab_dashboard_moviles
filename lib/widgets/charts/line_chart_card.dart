import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../models/report_data_model.dart';

class LineChartCard extends StatelessWidget {
  final LineChartSeries series;

  const LineChartCard({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final maxY = series.points.isEmpty
        ? 10000.0
        : series.points.map((p) => p.y).reduce((a, b) => a > b ? a : b) + 1000.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Monthly Revenue', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Revenue trend over the last 12 months',
              style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 280,
              child: LineChart(
                LineChartData(
                  minY: 0,
                  maxY: maxY,
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          return LineTooltipItem(
                            '\$${spot.y.toInt()}',
                            const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: maxY / 4,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
                      strokeWidth: 0.5,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 28,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 && value.toInt() < months.length) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                months[value.toInt()],
                                style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6)),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 48,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '\$${(value ~/ 1000)}k',
                            style: TextStyle(fontSize: 10, color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.5)),
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: series.points.map((p) => FlSpot(p.x, p.y)).toList(),
                      isCurved: true,
                      color: series.color,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 2,
                            strokeColor: series.color,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        color: series.color.withValues(alpha: 0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
