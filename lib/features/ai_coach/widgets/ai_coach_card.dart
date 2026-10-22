import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/widgets/duck_mascot_widget.dart';
import '../models/ai_coach_message.dart';

/// Ana ekranda gösterilen Günün AI İlhamı & Motivasyonu Kartı.
class AiCoachCard extends StatelessWidget {
  final AiCoachMessage? message;
  final bool isLoading;
  final VoidCallback onRefresh;

  const AiCoachCard({
    super.key,
    required this.message,
    required this.isLoading,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      padding: AppDimensions.paddingCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AiCoachCardHeader(
            isLoading: isLoading,
            onRefresh: onRefresh,
          ),
          const SizedBox(height: AppDimensions.spaceMedium),
          _AiCoachCardBody(
            message: message,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return BoxDecoration(
      color: AppColors.card,
      borderRadius: AppDimensions.borderRadiusLarge,
      border: Border.all(
        color: AppColors.flameOrange.withValues(alpha: 0.35),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.flameOrange.withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}

class _AiCoachCardHeader extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onRefresh;

  const _AiCoachCardHeader({
    required this.isLoading,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const DuckMascotWidget(
          size: 38,
          animate: false,
        ),
        const SizedBox(width: AppDimensions.spaceSmall),
        _buildTitleColumn(),
        _buildRefreshButton(),
      ],
    );
  }

  Widget _buildTitleColumn() {
    return const Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Yavru Ördek AI Koç',
            style: TextStyle(
              color: AppColors.duckYellow,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 2),
          Text(
            'Günün AI İlhamı & Motivasyonu',
            style: TextStyle(
              color: AppColors.textMuted,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRefreshButton() {
    return IconButton(
      icon: isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.duckYellow),
              ),
            )
          : const Icon(
              Icons.refresh_rounded,
              color: AppColors.textSecondary,
              size: 20,
            ),
      tooltip: 'Yeni Tavsiye Al',
      onPressed: isLoading ? null : onRefresh,
    );
  }
}

class _AiCoachCardBody extends StatelessWidget {
  final AiCoachMessage? message;
  final bool isLoading;

  const _AiCoachCardBody({
    required this.message,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          'Yavru Ördek senin için alevli bir koçluk tavsiyesi hazırlıyor...',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
      );
    }

    final text = message?.content ??
        'Her gün yakılan bir kıvılcım, geleceğini aydınlatan bir ateşe dönüşür. Birlikte başaracağız!';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.spaceSmall + 4),
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: AppDimensions.borderRadiusMedium,
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: 13.5,
          height: 1.45,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
