import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

/// Topluluk Etkinlikleri ve Ortak Meydan Okuma Ekranı.
class CommunityView extends StatelessWidget {
  const CommunityView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppDimensions.paddingScreen,
      children: [
        _buildHeader(),
        const SizedBox(height: AppDimensions.spaceLarge),
        _buildChallengeCard(
          title: '30 Günlük Su & Canlılık Meydan Okuması',
          participants: '4.890 Katılımcı',
          daysLeft: '18 Gün Kaldı',
          icon: Icons.water_drop_rounded,
        ),
        _buildChallengeCard(
          title: 'Kasım Kitap Kurdu Hareketi',
          participants: '9.120 Katılımcı',
          daysLeft: '22 Gün Kaldı',
          icon: Icons.menu_book_rounded,
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Topluluk Meydan Okumaları',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Binlerce kişiyle aynı anda alevi yak, ortak hedefe koş!',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required String participants,
    required String daysLeft,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceMedium),
      padding: AppDimensions.paddingCard,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppDimensions.borderRadiusLarge,
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.flameOrange.withValues(alpha: 0.15),
                  borderRadius: AppDimensions.borderRadiusMedium,
                ),
                child: Icon(icon, color: AppColors.flameOrange, size: 22),
              ),
              const SizedBox(width: AppDimensions.spaceSmall + 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 14.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$participants • $daysLeft',
                      style: const TextStyle(
                        color: AppColors.duckYellow,
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceMedium),
          SizedBox(
            width: double.infinity,
            height: 38,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Meydan Okumaya Katıl 🔥'),
            ),
          ),
        ],
      ),
    );
  }
}
