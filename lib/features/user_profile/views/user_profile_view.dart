import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/widgets/duck_mascot_widget.dart';

/// Kullanıcı Profil ve Seri İstatistikleri Ekranı.
class UserProfileView extends StatelessWidget {
  const UserProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppDimensions.paddingScreen,
      children: [
        _buildProfileHeader(),
        const SizedBox(height: AppDimensions.spaceLarge),
        _buildStatsOverview(),
        const SizedBox(height: AppDimensions.spaceLarge),
        _buildSettingsSection(),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return const Center(
      child: Column(
        children: [
          DuckMascotWidget(size: 80, animate: true),
          SizedBox(height: AppDimensions.spaceSmall + 4),
          Text(
            'Alevli Serici',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Alev Muhafızı Seviyesi • ash@wearetogether.app',
            style: TextStyle(color: AppColors.duckYellow, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsOverview() {
    return Container(
      padding: AppDimensions.paddingCard,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppDimensions.borderRadiusLarge,
        border: Border.all(color: AppColors.border),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _StatColumn(label: 'Aktif Seri', value: '14 Gün'),
          _StatColumn(label: 'En Uzun Seri', value: '28 Gün'),
          _StatColumn(label: 'Toplam Alev', value: '42 🔥'),
        ],
      ),
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.notifications_active_outlined,
              color: AppColors.duckYellow),
          title: const Text('Seri Hatırlatıcıları',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
          subtitle: const Text('Günde 1 kez alev sönmesin uyarısı al',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          trailing: Switch(
            value: true,
            activeThumbColor: AppColors.flameOrange,
            activeTrackColor: AppColors.flameOrangeDark,
            onChanged: (_) {},
          ),
        ),
        const Divider(color: AppColors.border),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.psychology_outlined,
              color: AppColors.flameOrange),
          title: const Text('Hugging Face AI Koç',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 14)),
          subtitle: const Text('Kişiselleştirilmiş günlük mikro tavsiyeler',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
          trailing: const Icon(Icons.chevron_right_rounded,
              color: AppColors.textMuted),
          onTap: () {},
        ),
      ],
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
