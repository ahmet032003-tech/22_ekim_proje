import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../habit_management/models/habit_model.dart';

/// Ana ekranda kullanıcının aktif alışkanlığını ve tamamlama aksiyonunu gösteren kart.
class ActiveHabitTile extends StatelessWidget {
  final HabitModel habit;
  final VoidCallback onComplete;

  const ActiveHabitTile({
    super.key,
    required this.habit,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final isDone = habit.isCompletedToday;

    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceMedium),
      padding: AppDimensions.paddingCard,
      decoration: _buildDecoration(isDone),
      child: Row(
        children: [
          _buildStreakBadge(),
          const SizedBox(width: AppDimensions.spaceMedium),
          _buildHabitInfo(),
          const SizedBox(width: AppDimensions.spaceSmall),
          _buildActionButton(isDone),
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration(bool isDone) {
    return BoxDecoration(
      color: AppColors.card,
      borderRadius: AppDimensions.borderRadiusLarge,
      border: Border.all(
        color: isDone
            ? AppColors.success.withValues(alpha: 0.5)
            : AppColors.flameOrange.withValues(alpha: 0.3),
        width: 1.2,
      ),
      boxShadow: isDone
          ? [
              BoxShadow(
                color: AppColors.success.withValues(alpha: 0.1),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ]
          : null,
    );
  }

  Widget _buildStreakBadge() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: AppDimensions.borderRadiusMedium,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(habit.streakEmoji, style: const TextStyle(fontSize: 16)),
            Text(
              '${habit.streakDays}g',
              style: const TextStyle(
                color: AppColors.duckYellow,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            habit.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            '${habit.category} • ${habit.streakBadgeTitle}',
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(bool isDone) {
    if (isDone) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.success.withValues(alpha: 0.15),
          borderRadius: AppDimensions.borderRadiusPill,
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle_rounded,
                color: AppColors.success, size: 16),
            SizedBox(width: 4),
            Text(
              'Bugün Tamam',
              style: TextStyle(
                color: AppColors.success,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 38,
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadiusMedium,
        boxShadow: AppColors.flameGlow,
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.flameOrange,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          minimumSize: const Size(0, 38),
        ),
        onPressed: onComplete,
        icon: const Text('🔥', style: TextStyle(fontSize: 13)),
        label: const Text(
          'Yak',
          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
