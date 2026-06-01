import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../widgets/charts/bar_chart_card.dart';
import '../../widgets/charts/pie_chart_card.dart';
import '../../widgets/charts/line_chart_card.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/common/export_button.dart';
import '../../widgets/cards/metric_card.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/responsive_helper.dart';
import '../../models/report_data_model.dart';
import '../../models/dashboard_metric_model.dart';
import '../../controllers/report_provider.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportProvider>().loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReportProvider>();
    final summary = provider.summary;
    final isDesktop = ResponsiveHelper.isDesktop(context);

    return Padding(
      padding: ResponsiveHelper.contentPadding(context),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Reports & Analytics',
              subtitle: 'Business intelligence and performance metrics',
              trailing: ExportButton(
                onPdfExport: () => _showExportSnackBar(context, 'PDF'),
                onExcelExport: () => _showExportSnackBar(context, 'Excel'),
              ),
            ),
            _buildSummaryCards(summary),
            const SizedBox(height: 24),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isDesktop ? 3 : 2,
                  child: BarChartCard(data: provider.barData),
                ),
                SizedBox(width: isDesktop ? 16 : 0),
                if (isDesktop)
                  Expanded(
                    flex: 2,
                    child: PieChartCard(data: provider.pieData),
                  ),
              ],
            ),
            if (!isDesktop) ...[
              const SizedBox(height: 16),
              PieChartCard(data: provider.pieData),
            ],
            const SizedBox(height: 16),
            LineChartCard(series: provider.lineData),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCards(ReportSummaryModel summary) {
    final crossAxisCount = ResponsiveHelper.cardGridColumns(context);

    final metrics = [
      DashboardMetricModel(
        title: 'Total Revenue',
        value: summary.totalRevenue,
        icon: Icons.attach_money,
        trend: TrendDirection.up,
        percentageChange: 9.2,
        color: AppColors.success,
      ),
      DashboardMetricModel(
        title: 'Total Appointments',
        value: summary.totalAppointments,
        icon: Icons.calendar_today,
        trend: TrendDirection.up,
        percentageChange: 12.5,
        color: AppColors.primary,
      ),
      DashboardMetricModel(
        title: 'Completion Rate',
        value: summary.completionRate,
        icon: Icons.check_circle,
        trend: TrendDirection.up,
        percentageChange: 5.3,
        color: AppColors.info,
      ),
      DashboardMetricModel(
        title: 'Avg. Rating',
        value: summary.avgRating,
        icon: Icons.star,
        trend: TrendDirection.neutral,
        percentageChange: 0,
        color: AppColors.accent,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.8,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        return MetricCard(metric: metrics[index])
            .animate()
            .fadeIn(duration: 300.ms, delay: (50 * index).ms);
      },
    );
  }

  void _showExportSnackBar(BuildContext context, String type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$type export placeholder — coming soon'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}