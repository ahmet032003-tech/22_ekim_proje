import 'package:flutter/foundation.dart';
import '../models/auth_state.dart';

/// Oturum açma, kayıt ve misafir giriş akışlarını yöneten kontrolcü.
/// Proje kuralları gereği harici state paketleri yerine ValueNotifier kullanılır.
class AuthController extends ValueNotifier<AuthState> {
  AuthController({AuthState? initialState})
      : super(initialState ?? const AuthState());

  /// E-posta ve şifre ile oturum açma
  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      value = value.copyWith(
        errorMessage: 'Lütfen e-posta ve şifrenizi eksiksiz girin.',
      );
      return false;
    }

    value = value.copyWith(isLoading: true, clearError: true);

    await Future<void>.delayed(const Duration(milliseconds: 600));

    // Demo hesap doğrulama
    final username = email.split('@').first;
    value = value.copyWith(
      isLoading: false,
      isAuthenticated: true,
      username: username.isEmpty ? 'AlevliSerici' : username,
      email: email,
      isGuest: false,
      clearError: true,
    );
    return true;
  }

  /// Yeni hesap oluşturma
  Future<bool> register({
    required String username,
    required String email,
    required String password,
  }) async {
    if (username.trim().isEmpty || email.trim().isEmpty || password.length < 6) {
      value = value.copyWith(
        errorMessage:
            'Lütfen geçerli bir kullanıcı adı ve en az 6 haneli şifre girin.',
      );
      return false;
    }

    value = value.copyWith(isLoading: true, clearError: true);

    await Future<void>.delayed(const Duration(milliseconds: 600));

    value = value.copyWith(
      isLoading: false,
      isAuthenticated: true,
      username: username,
      email: email,
      isGuest: false,
      clearError: true,
    );
    return true;
  }

  /// Misafir Girişi (Hızlı Keşif)
  void signInAsGuest() {
    value = const AuthState(
      isAuthenticated: true,
      username: 'Misafir Ördek',
      email: 'guest@wearetogether.app',
      isGuest: true,
    );
  }

  /// Oturumu Kapat
  void signOut() {
    value = const AuthState();
  }
}
