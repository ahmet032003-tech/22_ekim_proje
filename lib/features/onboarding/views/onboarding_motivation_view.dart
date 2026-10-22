import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/duck_mascot_widget.dart';
import 'habit_selection_view.dart';

/// Giriş sonrası 2-3 saniye süren pozitif motivasyon geçiş ekranı (SKILL.md Bölüm 2).
class OnboardingMotivationView extends StatefulWidget {
  final Duration displayDuration;

  const OnboardingMotivationView({
    super.key,
    this.displayDuration = const Duration(milliseconds: 2600),
  });

  @override
  State<OnboardingMotivationView> createState() =>
      _OnboardingMotivationViewState();
}

class _OnboardingMotivationViewState extends State<OnboardingMotivationView> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.displayDuration, _proceedToHabitSelection);
  }

  void _proceedToHabitSelection() {
    if (!mounted) return;
    _timer?.cancel();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const HabitSelectionView(),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceLarge,
            vertical: AppDimensions.spaceLarge,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const DuckMascotWidget(
                size: 140,
                animate: true,
                showFlameCrown: true,
              ),
              const SizedBox(height: AppDimensions.spaceXLarge),
              _buildTitle(),
              const SizedBox(height: AppDimensions.spaceMedium),
              _buildSubtitle(),
              const Spacer(),
              _buildSkipButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      AppStrings.onboardingMotivationTitle,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildSubtitle() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        AppStrings.onboardingMotivationSubtitle,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
          height: 1.5,
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return TextButton.icon(
      onPressed: _proceedToHabitSelection,
      icon: const Icon(Icons.arrow_forward_rounded, size: 18),
      label: const Text('Alışkanlık Seçimine Geç'),
      style: TextButton.styleFrom(
        foregroundColor: AppColors.duckYellow,
      ),
    );
  }
}
