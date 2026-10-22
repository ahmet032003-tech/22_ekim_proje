import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

/// Arkadaş Ekle ve Ortak Seri Takibi Ekranı.
class FriendsView extends StatelessWidget {
  const FriendsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppDimensions.paddingScreen,
      children: [
        _buildHeader(),
        const SizedBox(height: AppDimensions.spaceLarge),
        _buildSearchBar(),
        const SizedBox(height: AppDimensions.spaceLarge),
        _buildFriendTile('Zeynep K.', '🔥 14 Günlük Seri', 'Kitap Okuma'),
        _buildFriendTile('Emre Ç.', '🔥 28 Günlük Seri', 'Sabah Koşusu'),
        _buildFriendTile('Burak T.', '🔥 7 Günlük Seri', 'Su Hedefi'),
      ],
    );
  }

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Birlikte Seri Yapacağın Dostlar',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Arkadaşlarını davet et, birbirinizin alevini canlı tutun!',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Kullanıcı adı veya e-posta ile ara...',
        prefixIcon: Icon(Icons.search_rounded, size: 20),
      ),
    );
  }

  Widget _buildFriendTile(String name, String streak, String habit) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceSmall + 4),
      padding: AppDimensions.paddingCard,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppDimensions.borderRadiusMedium,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.surfaceSecondary,
            child: Text(
              name.substring(0, 1),
              style: const TextStyle(
                color: AppColors.duckYellow,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.spaceMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  habit,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.flameOrange.withValues(alpha: 0.15),
              borderRadius: AppDimensions.borderRadiusPill,
            ),
            child: Text(
              streak,
              style: const TextStyle(
                color: AppColors.flameOrangeLight,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
