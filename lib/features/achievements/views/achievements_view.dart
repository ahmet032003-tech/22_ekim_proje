import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

/// Alevli Seri Rozetleri ve Başarımlar Ekranı.
class AchievementsView extends StatelessWidget {
  const AchievementsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppDimensions.paddingScreen,
      children: [
        _buildHeader(),
        const SizedBox(height: AppDimensions.spaceLarge),
        _buildBadgeGrid(),
      ],
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Alev Rozetleri & Başarımlar',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Serilerini büyüt, alev rozetlerini koleksiyonuna ekle!',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildBadgeGrid() {
    return Column(
      children: [
        _buildBadgeCard('🌱 İlk Kıvılcım', 'İlk serini başarıyla başlattın', true),
        _buildBadgeCard('🔥 Alev Muhafızı', '7 günlük kesintisiz seriye ulaştın', true),
        _buildBadgeCard('⚡ Sönmeyen Ateş', '14 gün boyunca alevi diri tuttun', false),
        _buildBadgeCard('👑 Efsanevi Ördek', '30 gün kesintisiz alışkanlık şampiyonu', false),
      ],
    );
  }

  Widget _buildBadgeCard(String title, String desc, bool isUnlocked) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceMedium),
      padding: AppDimensions.paddingCard,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppDimensions.borderRadiusLarge,
        border: Border.all(
          color: isUnlocked
              ? AppColors.duckYellow.withValues(alpha: 0.5)
              : AppColors.border,
          width: isUnlocked ? 1.5 : 1.0,
        ),
        boxShadow: isUnlocked ? AppColors.duckGlow : null,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isUnlocked
                  ? AppColors.duckYellow.withValues(alpha: 0.15)
                  : AppColors.surfaceSecondary,
            ),
            child: Icon(
              isUnlocked ? Icons.verified_rounded : Icons.lock_outline_rounded,
              color: isUnlocked ? AppColors.duckYellow : AppColors.textMuted,
              size: 24,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isUnlocked
                        ? AppColors.textPrimary
                        : AppColors.textSecondary,
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  desc,
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
