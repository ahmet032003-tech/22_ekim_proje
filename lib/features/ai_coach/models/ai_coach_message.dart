import 'package:flutter/foundation.dart';

/// AI Koç mesajı ve yanıt modeli (SKILL.md Bölüm 5).
@immutable
class AiCoachMessage {
  final String id;
  final String content;
  final DateTime timestamp;
  final bool isFromUser;
  final bool isFallback;
  final String category;

  const AiCoachMessage({
    required this.id,
    required this.content,
    required this.timestamp,
    this.isFromUser = false,
    this.isFallback = false,
    this.category = 'motivation',
  });

  AiCoachMessage copyWith({
    String? id,
    String? content,
    DateTime? timestamp,
    bool? isFromUser,
    bool? isFallback,
    String? category,
  }) {
    return AiCoachMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      isFromUser: isFromUser ?? this.isFromUser,
      isFallback: isFallback ?? this.isFallback,
      category: category ?? this.category,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AiCoachMessage &&
        other.id == id &&
        other.content == content &&
        other.timestamp == timestamp &&
        other.isFromUser == isFromUser &&
        other.isFallback == isFallback &&
        other.category == category;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      content,
      timestamp,
      isFromUser,
      isFallback,
      category,
    );
  }
}
