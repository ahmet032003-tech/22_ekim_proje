import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/duck_mascot_widget.dart';

/// Sabit Üst Header (Sticky Header - SKILL.md Bölüm 3).
class HomeHeader extends StatelessWidget {
  final int totalStreak;

  const HomeHeader({
    super.key,
    required this.totalStreak,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceLarge,
        vertical: AppDimensions.spaceSmall + 4,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBrandSection(),
            _buildStreakBadge(),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandSection() {
    return const Row(
      children: [
        DuckMascotWidget(
          size: AppDimensions.mascotHeaderSize,
          animate: true,
          showFlameCrown: true,
        ),
        SizedBox(width: AppDimensions.spaceSmall + 2),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.appName,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
            Text(
              AppStrings.appTagline,
              style: TextStyle(
                color: AppColors.duckYellow,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStreakBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceMedium,
        vertical: AppDimensions.spaceSmall - 2,
      ),
      decoration: BoxDecoration(
        gradient: AppColors.flameGradient,
        borderRadius: AppDimensions.borderRadiusPill,
        boxShadow: AppColors.flameGlow,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '🔥',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(width: 4),
          Text(
            '$totalStreak Gün',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
