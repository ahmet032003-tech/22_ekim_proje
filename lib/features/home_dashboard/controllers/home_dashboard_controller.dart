import 'package:flutter/foundation.dart';
import '../../../core/utils/streak_helper.dart';
import '../../habit_management/models/habit_model.dart';
import '../models/home_dashboard_state.dart';

/// Ana ekran ve sekme durumlarını yöneten ValueNotifier kontrolcüsü.
class HomeDashboardController extends ValueNotifier<HomeDashboardState> {
  HomeDashboardController({HomeDashboardState? initialState})
      : super(initialState ?? const HomeDashboardState());

  /// Alt navigasyon sekmesini değiştirir.
  void setTabIndex(int index) {
    if (index >= 0 && index <= 4 && value.currentTabIndex != index) {
      value = value.copyWith(currentTabIndex: index);
    }
  }

  /// Alışkanlığı bugün için tamamlar ve alevi büyütür (SKILL.md Bölüm 6).
  void toggleCompleteHabit(String habitId) {
    final updatedHabits = value.habits.map((habit) {
      if (habit.id == habitId) {
        if (habit.isCompletedToday) {
          // Zaten tamamlanmışsa işlem yapma
          return habit;
        }

        final nextStreak = StreakHelper.calculateNextStreak(
          currentStreak: habit.streakDays,
          lastCompletedDate: habit.lastCompletedDate,
        );

        return habit.copyWith(
          streakDays: nextStreak,
          lastCompletedDate: DateTime.now(),
        );
      }
      return habit;
    }).toList();

    value = value.copyWith(
      habits: updatedHabits,
      communityStreakCount: value.communityStreakCount + 1,
    );
  }

  /// Yeni alışkanlık ekler.
  void addHabit(HabitModel newHabit) {
    value = value.copyWith(
      habits: [...value.habits, newHabit],
    );
  }
}
