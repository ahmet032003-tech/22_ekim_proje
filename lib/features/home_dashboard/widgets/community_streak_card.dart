import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

/// Topluluk Alevli Seri Sayacı Kartı (SKILL.md Bölüm 3.1).
class CommunityStreakCard extends StatelessWidget {
  final int count;

  const CommunityStreakCard({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppDimensions.paddingCard,
      decoration: _buildDecoration(),
      child: Row(
        children: [
          _buildFlameIcon(),
          const SizedBox(width: AppDimensions.spaceMedium),
          _buildTextContent(),
        ],
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF201614),
          Color(0xFF161B26),
        ],
      ),
      borderRadius: AppDimensions.borderRadiusLarge,
      border: Border.all(
        color: AppColors.flameOrange.withValues(alpha: 0.45),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.flameOrange.withValues(alpha: 0.12),
          blurRadius: 18,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }

  Widget _buildFlameIcon() {
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.flameGradient,
        boxShadow: AppColors.flameGlow,
      ),
      child: const Center(
        child: Text(
          '🔥',
          style: TextStyle(fontSize: 26),
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    final formatted = _formatCount(count);

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bugün seninle beraber $formatted kişi seri yaptı!',
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14.5,
              fontWeight: FontWeight.bold,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Alevler hiç sönmesin! Topluluğun gücü seninle.',
            style: TextStyle(
              color: AppColors.duckYellow,
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int number) {
    // 14820 -> 14.820
    final str = number.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write('.');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}
