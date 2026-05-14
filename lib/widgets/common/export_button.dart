import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class ExportButton extends StatelessWidget {
  final VoidCallback? onPdfExport;
  final VoidCallback? onExcelExport;

  const ExportButton({
    super.key,
    this.onPdfExport,
    this.onExcelExport,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildButton(
          icon: Icons.picture_as_pdf,
          label: 'PDF',
          color: AppColors.error,
          onPressed: onPdfExport ?? () {},
        ),
        const SizedBox(width: 8),
        _buildButton(
          icon: Icons.table_chart,
          label: 'Excel',
          color: AppColors.success,
          onPressed: onExcelExport ?? () {},
        ),
      ],
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 16, color: color),
      label: Text(label, style: TextStyle(color: color, fontSize: 12)),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        side: BorderSide(color: color.withValues(alpha: 0.4)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
