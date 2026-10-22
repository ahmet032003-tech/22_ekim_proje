import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';

/// Karşılama ekranı oturum ve kayıt aksiyon butonları.
class AuthActionButtons extends StatelessWidget {
  final VoidCallback onSignIn;
  final VoidCallback onRegister;
  final VoidCallback onGuest;

  const AuthActionButtons({
    super.key,
    required this.onSignIn,
    required this.onRegister,
    required this.onGuest,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildSignInButton(),
        const SizedBox(height: AppDimensions.spaceSmall + 4),
        _buildRegisterButton(),
        const SizedBox(height: AppDimensions.spaceSmall),
        _buildGuestButton(),
      ],
    );
  }

  Widget _buildSignInButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadiusMedium,
        boxShadow: AppColors.flameGlow,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.flameOrange,
          foregroundColor: Colors.white,
        ),
        onPressed: onSignIn,
        child: const Text(AppStrings.signIn),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.duckYellow,
        side: const BorderSide(color: AppColors.duckYellow, width: 1.2),
      ),
      onPressed: onRegister,
      child: const Text(AppStrings.register),
    );
  }

  Widget _buildGuestButton() {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.textSecondary,
      ),
      onPressed: onGuest,
      child: const Text(
        AppStrings.guestMode,
        style: TextStyle(
          decoration: TextDecoration.underline,
          fontSize: 13,
        ),
      ),
    );
  }
}
