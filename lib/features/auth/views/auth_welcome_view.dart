import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/widgets/duck_mascot_widget.dart';
import '../../onboarding/views/onboarding_motivation_view.dart';
import '../controllers/auth_controller.dart';
import '../widgets/animated_greeting_text.dart';
import '../widgets/auth_action_buttons.dart';
import '../widgets/auth_login_modal.dart';

/// Karşılama ve Giriş Ekranı (SKILL.md Bölüm 1).
/// Sabit başlık, selam veren yavru ördek, sıralı metin animasyonu ve aksiyon butonları içerir.
class AuthWelcomeView extends StatefulWidget {
  final AuthController? controller;

  const AuthWelcomeView({
    super.key,
    this.controller,
  });

  @override
  State<AuthWelcomeView> createState() => _AuthWelcomeViewState();
}

class _AuthWelcomeViewState extends State<AuthWelcomeView> {
  late final AuthController _controller;
  late final bool _ownsController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AuthController();
    _ownsController = widget.controller == null;
  }

  @override
  void dispose() {
    if (_ownsController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _navigateToOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => const OnboardingMotivationView(),
      ),
    );
  }

  void _showAuthModal({required bool isRegister}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      builder: (_) => AuthLoginModal(
        controller: _controller,
        isRegisterMode: isRegister,
        onSuccess: _navigateToOnboarding,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceLarge,
            vertical: AppDimensions.spaceMedium,
          ),
          child: Column(
            children: [
              _buildBrandHeader(),
              const Spacer(),
              const DuckMascotWidget(
                size: AppDimensions.mascotWelcomeSize,
                animate: true,
                showFlameCrown: true,
              ),
              const SizedBox(height: AppDimensions.spaceLarge),
              const AnimatedGreetingText(),
              const SizedBox(height: AppDimensions.spaceMedium),
              _buildDescriptionText(),
              const Spacer(),
              AuthActionButtons(
                onSignIn: () => _showAuthModal(isRegister: false),
                onRegister: () => _showAuthModal(isRegister: true),
                onGuest: () {
                  _controller.signInAsGuest();
                  _navigateToOnboarding();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColors.flameOrange,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppDimensions.spaceSmall),
        const Text(
          AppStrings.appName,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionText() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        AppStrings.welcomeDescription,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
          height: 1.45,
        ),
      ),
    );
  }
}
