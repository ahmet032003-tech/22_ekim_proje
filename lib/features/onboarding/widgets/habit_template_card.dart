import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../models/habit_template.dart';

/// Onboarding şablon seçim kartı widget'ı.
class HabitTemplateCard extends StatelessWidget {
  final HabitTemplate template;
  final bool isSelected;
  final VoidCallback onTap;

  const HabitTemplateCard({
    super.key,
    required this.template,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.spaceMedium),
      decoration: _buildDecoration(),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDimensions.borderRadiusMedium,
        child: Padding(
          padding: AppDimensions.paddingCard,
          child: Row(
            children: [
              _buildIconContainer(),
              const SizedBox(width: AppDimensions.spaceMedium),
              _buildTextContent(),
              const SizedBox(width: AppDimensions.spaceSmall),
              _buildSelectionIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildDecoration() {
    return BoxDecoration(
      color: isSelected
          ? AppColors.flameOrange.withValues(alpha: 0.12)
          : AppColors.card,
      borderRadius: AppDimensions.borderRadiusMedium,
      border: Border.all(
        color: isSelected ? AppColors.flameOrange : AppColors.border,
        width: isSelected ? 1.8 : 1.0,
      ),
      boxShadow: isSelected ? AppColors.flameGlow : null,
    );
  }

  Widget _buildIconContainer() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.flameOrange
            : AppColors.surfaceSecondary,
        borderRadius: AppDimensions.borderRadiusMedium,
      ),
      child: Icon(
        template.icon,
        color: isSelected ? Colors.white : AppColors.duckYellow,
        size: 24,
      ),
    );
  }

  Widget _buildTextContent() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            template.title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            template.description,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionIndicator() {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? AppColors.flameOrange : Colors.transparent,
        border: Border.all(
          color: isSelected ? AppColors.flameOrange : AppColors.border,
          width: 2,
        ),
      ),
      child: isSelected
          ? const Icon(
              Icons.check_rounded,
              size: 14,
              color: Colors.white,
            )
          : null,
    );
  }
}
