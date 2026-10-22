import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../habit_management/models/habit_model.dart';

/// Gelişim İstatistikleri ve Başarı Çubuğu Kartı (SKILL.md Bölüm 3.2).
class ProgressStatsCard extends StatelessWidget {
  final List<HabitModel> habits;

  const ProgressStatsCard({
    super.key,
    required this.habits,
  });

  @override
  Widget build(BuildContext context) {
    final completedCount = habits.where((h) => h.isCompletedToday).length;
    final total = habits.isEmpty ? 1 : habits.length;
    final progress = (completedCount / total).clamp(0.0, 1.0);
    final percentage = (progress * 100).toInt();

    return Container(
      width: double.infinity,
      padding: AppDimensions.paddingCard,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppDimensions.borderRadiusLarge,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardHeader(percentage),
          const SizedBox(height: AppDimensions.spaceMedium),
          _buildProgressBar(progress),
          const SizedBox(height: AppDimensions.spaceMedium),
          _buildMetricChips(completedCount, habits.length),
        ],
      ),
    );
  }

  Widget _buildCardHeader(int percentage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            Icon(Icons.insights_rounded, color: AppColors.duckYellow, size: 20),
            SizedBox(width: 8),
            Text(
              AppStrings.progressStatsHeader,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.flameOrange.withValues(alpha: 0.15),
            borderRadius: AppDimensions.borderRadiusPill,
            border: Border.all(
              color: AppColors.flameOrange.withValues(alpha: 0.4),
            ),
          ),
          child: Text(
            '%$percentage Başarı',
            style: const TextStyle(
              color: AppColors.flameOrangeLight,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(double progress) {
    return ClipRRect(
      borderRadius: AppDimensions.borderRadiusPill,
      child: LinearProgressIndicator(
        value: progress == 0 ? 0.05 : progress,
        minHeight: 10,
        backgroundColor: AppColors.surfaceSecondary,
        valueColor: const AlwaysStoppedAnimation<Color>(AppColors.flameOrange),
      ),
    );
  }

  Widget _buildMetricChips(int completed, int total) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Bugün Tamamlanan: $completed / $total',
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Row(
          children: [
            Text('🔥', style: TextStyle(fontSize: 12)),
            SizedBox(width: 4),
            Text(
              'Seri Sönmesin',
              style: TextStyle(
                color: AppColors.duckYellow,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
