import 'package:flutter/foundation.dart';
import 'ai_coach_message.dart';

/// AI Koç ekran durum modeli.
@immutable
class AiCoachState {
  final bool isLoading;
  final String? errorMessage;
  final AiCoachMessage? currentMotivation;
  final List<AiCoachMessage> messages;

  const AiCoachState({
    this.isLoading = false,
    this.errorMessage,
    this.currentMotivation,
    this.messages = const [],
  });

  AiCoachState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
    AiCoachMessage? currentMotivation,
    List<AiCoachMessage>? messages,
  }) {
    return AiCoachState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      currentMotivation: currentMotivation ?? this.currentMotivation,
      messages: messages ?? this.messages,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AiCoachState &&
        other.isLoading == isLoading &&
        other.errorMessage == errorMessage &&
        other.currentMotivation == currentMotivation &&
        listEquals(other.messages, messages);
  }

  @override
  int get hashCode {
    return Object.hash(
      isLoading,
      errorMessage,
      currentMotivation,
      Object.hashAll(messages),
    );
  }
}
