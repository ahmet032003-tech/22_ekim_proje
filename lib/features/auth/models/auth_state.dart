import 'package:flutter/foundation.dart';

/// Kullanıcı kimlik doğrulama durumu.
@immutable
class AuthState {
  final bool isLoading;
  final bool isAuthenticated;
  final String? username;
  final String? email;
  final String? errorMessage;
  final bool isGuest;

  const AuthState({
    this.isLoading = false,
    this.isAuthenticated = false,
    this.username,
    this.email,
    this.errorMessage,
    this.isGuest = false,
  });

  AuthState copyWith({
    bool? isLoading,
    bool? isAuthenticated,
    String? username,
    String? email,
    String? errorMessage,
    bool clearError = false,
    bool? isGuest,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      username: username ?? this.username,
      email: email ?? this.email,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isGuest: isGuest ?? this.isGuest,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthState &&
        other.isLoading == isLoading &&
        other.isAuthenticated == isAuthenticated &&
        other.username == username &&
        other.email == email &&
        other.errorMessage == errorMessage &&
        other.isGuest == isGuest;
  }

  @override
  int get hashCode {
    return Object.hash(
      isLoading,
      isAuthenticated,
      username,
      email,
      errorMessage,
      isGuest,
    );
  }
}
