import 'package:flutter/foundation.dart';
import '../../../core/utils/streak_helper.dart';

/// Alışkanlık ve Alevli Seri Veri Modeli (SKILL.md Bölüm 6).
@immutable
class HabitModel {
  final String id;
  final String title;
  final String category;
  final int streakDays;
  final DateTime? lastCompletedDate;
  final bool isPrivate;
  final String iconName;

  const HabitModel({
    required this.id,
    required this.title,
    required this.category,
    this.streakDays = 1,
    this.lastCompletedDate,
    this.isPrivate = false,
    this.iconName = 'flame',
  });

  /// Bugün tamamlandı mı?
  bool get isCompletedToday =>
      StreakHelper.isCompletedToday(lastCompletedDate);

  /// Seri aktif mi?
  bool get isStreakActive =>
      StreakHelper.isStreakActive(lastCompletedDate);

  /// Alev seviyesi unvanı
  String get streakBadgeTitle =>
      StreakHelper.getStreakBadgeTitle(streakDays);

  /// Alev emojisi
  String get streakEmoji => StreakHelper.getStreakEmoji(streakDays);

  HabitModel copyWith({
    String? id,
    String? title,
    String? category,
    int? streakDays,
    DateTime? lastCompletedDate,
    bool? isPrivate,
    String? iconName,
  }) {
    return HabitModel(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      streakDays: streakDays ?? this.streakDays,
      lastCompletedDate: lastCompletedDate ?? this.lastCompletedDate,
      isPrivate: isPrivate ?? this.isPrivate,
      iconName: iconName ?? this.iconName,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HabitModel &&
        other.id == id &&
        other.title == title &&
        other.category == category &&
        other.streakDays == streakDays &&
        other.lastCompletedDate == lastCompletedDate &&
        other.isPrivate == isPrivate &&
        other.iconName == iconName;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      category,
      streakDays,
      lastCompletedDate,
      isPrivate,
      iconName,
    );
  }
}
