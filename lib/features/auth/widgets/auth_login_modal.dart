import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../controllers/auth_controller.dart';
import '../models/auth_state.dart';

/// Oturum açma ve kayıt olma alt modal penceresi.
class AuthLoginModal extends StatefulWidget {
  final AuthController controller;
  final bool isRegisterMode;
  final VoidCallback onSuccess;

  const AuthLoginModal({
    super.key,
    required this.controller,
    this.isRegisterMode = false,
    required this.onSuccess,
  });

  @override
  State<AuthLoginModal> createState() => _AuthLoginModalState();
}

class _AuthLoginModalState extends State<AuthLoginModal> {
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late bool _isRegister;

  @override
  void initState() {
    super.initState();
    _isRegister = widget.isRegisterMode;
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final success = _isRegister
        ? await widget.controller.register(
            username: _usernameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          )
        : await widget.controller.signIn(
            email: _emailController.text,
            password: _passwordController.text,
          );

    if (mounted && success) {
      Navigator.of(context).pop();
      widget.onSuccess();
    }
  }

  void _fillDemoCredentials() {
    _emailController.text = 'alev@wearetogether.app';
    _passwordController.text = '123456';
    if (_isRegister) {
      _usernameController.text = 'AlevliOrdek';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.spaceLarge,
        right: AppDimensions.spaceLarge,
        top: AppDimensions.spaceLarge,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            AppDimensions.spaceLarge,
      ),
      child: ValueListenableBuilder<AuthState>(
        valueListenable: widget.controller,
        builder: (context, state, _) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(),
                if (state.errorMessage != null) ...[
                  const SizedBox(height: AppDimensions.spaceSmall),
                  _buildErrorMessage(state.errorMessage!),
                ],
                const SizedBox(height: AppDimensions.spaceMedium),
                _buildFormFields(),
                const SizedBox(height: AppDimensions.spaceMedium),
                _buildActionButtons(state.isLoading),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _isRegister ? AppStrings.register : AppStrings.signIn,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: _fillDemoCredentials,
          child: const Text(
            'Demo Doldur',
            style: TextStyle(
              color: AppColors.duckYellow,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(String msg) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceSmall),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.15),
        borderRadius: AppDimensions.borderRadiusSmall,
        border: Border.all(color: AppColors.error),
      ),
      child: Text(
        msg,
        style: const TextStyle(color: AppColors.error, fontSize: 12),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        if (_isRegister) ...[
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Kullanıcı Adı',
              prefixIcon: Icon(Icons.person_outline, size: 20),
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSmall + 4),
        ],
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'E-posta',
            prefixIcon: Icon(Icons.email_outlined, size: 20),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceSmall + 4),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Şifre',
            prefixIcon: Icon(Icons.lock_outline, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(bool isLoading) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: isLoading ? null : _handleSubmit,
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(_isRegister ? AppStrings.register : AppStrings.signIn),
        ),
        const SizedBox(height: AppDimensions.spaceSmall),
        TextButton(
          onPressed: () {
            setState(() {
              _isRegister = !_isRegister;
            });
          },
          child: Text(
            _isRegister
                ? 'Zaten hesabın var mı? Oturum Aç'
                : 'Hesabın yok mu? Kayıt Ol',
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
