import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';

/// 5 sekmeli ve ortasında parlayan (+) merkez butonlu alt navigasyon çubuğu (SKILL.md Bölüm 4).
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  final VoidCallback onAddHabit;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.onAddHabit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border, width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                icon: Icons.group_add_rounded,
                label: AppStrings.navFriends,
              ),
              _buildNavItem(
                index: 1,
                icon: Icons.emoji_events_rounded,
                label: AppStrings.navAchievements,
              ),
              _buildCentralAddButton(),
              _buildNavItem(
                index: 3,
                icon: Icons.public_rounded,
                label: AppStrings.navCommunity,
              ),
              _buildNavItem(
                index: 4,
                icon: Icons.person_rounded,
                label: AppStrings.navProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = currentIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onTabSelected(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? AppColors.flameOrange : AppColors.textMuted,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppColors.flameOrange : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCentralAddButton() {
    return Expanded(
      child: Center(
        child: GestureDetector(
          onTap: onAddHabit,
          child: Container(
            width: AppDimensions.centralFloatingButtonSize,
            height: AppDimensions.centralFloatingButtonSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.flameGradient,
              boxShadow: AppColors.flameGlow,
              border: Border.all(color: AppColors.duckYellow, width: 2),
            ),
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 34,
            ),
          ),
        ),
      ),
    );
  }
}
