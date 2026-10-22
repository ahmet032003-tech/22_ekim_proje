import 'package:flutter/foundation.dart';
import '../../habit_management/models/habit_model.dart';

/// Ana Kontrol Paneli Durum Modeli (SKILL.md Bölüm 3).
@immutable
class HomeDashboardState {
  final int currentTabIndex;
  final int communityStreakCount;
  final List<HabitModel> habits;

  const HomeDashboardState({
    this.currentTabIndex = 2, // Merkez Alışkanlıklar sekmesi varsayılan
    this.communityStreakCount = 14820,
    this.habits = const [],
  });

  /// Toplam aktif alev sayısı
  int get totalActiveStreaks =>
      habits.where((h) => h.isStreakActive).length;

  /// En yüksek alevli seri
  int get highestStreak => habits.isEmpty
      ? 0
      : habits.map((h) => h.streakDays).reduce((a, b) => a > b ? a : b);

  HomeDashboardState copyWith({
    int? currentTabIndex,
    int? communityStreakCount,
    List<HabitModel>? habits,
  }) {
    return HomeDashboardState(
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      communityStreakCount:
          communityStreakCount ?? this.communityStreakCount,
      habits: habits ?? this.habits,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HomeDashboardState &&
        other.currentTabIndex == currentTabIndex &&
        other.communityStreakCount == communityStreakCount &&
        listEquals(other.habits, habits);
  }

  @override
  int get hashCode {
    return Object.hash(
      currentTabIndex,
      communityStreakCount,
      Object.hashAll(habits),
    );
  }
}
