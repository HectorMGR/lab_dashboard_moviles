import 'package:flutter/material.dart';
import '../../../models/dashboard_metric_model.dart';
import '../../../core/theme/app_colors.dart';

class MetricCard extends StatelessWidget {
  final DashboardMetricModel metric;

  const MetricCard({super.key, required this.metric});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: metric.color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(metric.icon, color: metric.color, size: 20),
                ),
                _buildTrendBadge(context),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              metric.title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color?.withValues(alpha: 0.6),
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              metric.value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendBadge(BuildContext context) {
    final icon = switch (metric.trend) {
      TrendDirection.up => Icons.trending_up,
      TrendDirection.down => Icons.trending_down,
      TrendDirection.neutral => Icons.trending_flat,
    };

    if (metric.trend == TrendDirection.neutral) {
      return const SizedBox.shrink();
    }

    final color = switch (metric.trend) {
      TrendDirection.up => AppColors.success,
      TrendDirection.down => AppColors.error,
      TrendDirection.neutral => AppColors.success,
    };

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 2),
        Text(
          '${metric.percentageChange.toStringAsFixed(1)}%',
          style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
