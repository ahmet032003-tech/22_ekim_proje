import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:we_are_together/core/constants/app_strings.dart';
import 'package:we_are_together/core/utils/streak_helper.dart';
import 'package:we_are_together/features/ai_coach/controllers/ai_coach_controller.dart';
import 'package:we_are_together/features/auth/controllers/auth_controller.dart';
import 'package:we_are_together/features/habit_management/models/habit_model.dart';
import 'package:we_are_together/features/home_dashboard/controllers/home_dashboard_controller.dart';
import 'package:we_are_together/features/home_dashboard/models/home_dashboard_state.dart';
import 'package:we_are_together/features/home_dashboard/views/home_dashboard_view.dart';
import 'package:we_are_together/main.dart';

void main() {
  group('WeAreTogether Unit & State Management Tests', () {
    test('StreakHelper calculates next streaks and badge titles correctly', () {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));
      final threeDaysAgo = now.subtract(const Duration(days: 3));

      // Dün tamamlanmışsa seri büyür
      expect(
        StreakHelper.calculateNextStreak(
          currentStreak: 5,
          lastCompletedDate: yesterday,
        ),
        6,
      );

      // Bugün zaten tamamlanmışsa aynı kalır
      expect(
        StreakHelper.calculateNextStreak(
          currentStreak: 6,
          lastCompletedDate: now,
        ),
        6,
      );

      // Seri kırılmışsa 1'e döner
      expect(
        StreakHelper.calculateNextStreak(
          currentStreak: 12,
          lastCompletedDate: threeDaysAgo,
        ),
        1,
      );

      expect(StreakHelper.getStreakBadgeTitle(1), 'Kıvılcım');
      expect(StreakHelper.getStreakBadgeTitle(7), 'Parlayan Alev');
      expect(StreakHelper.getStreakBadgeTitle(14), 'Sönmeyen Ateş');
      expect(StreakHelper.getStreakBadgeTitle(35), 'Efsanevi Seri');
    });

    test('AuthController handles login, registration, and guest mode', () async {
      final controller = AuthController();

      expect(controller.value.isAuthenticated, isFalse);

      // Boş giriş hata verir
      final emptyResult = await controller.signIn(email: '', password: '');
      expect(emptyResult, isFalse);
      expect(controller.value.errorMessage, isNotNull);

      // Misafir girişi
      controller.signInAsGuest();
      expect(controller.value.isAuthenticated, isTrue);
      expect(controller.value.isGuest, isTrue);

      controller.signOut();
      expect(controller.value.isAuthenticated, isFalse);

      controller.dispose();
    });

    test('AiCoachController fetches fallback motivation on offline or delayed state',
        () async {
      final controller = AiCoachController();

      await controller.fetchDailyMotivation(
        streakCount: 7,
        habitTitle: 'Kitap Okuma',
      );

      expect(controller.value.isLoading, isFalse);
      expect(controller.value.currentMotivation, isNotNull);
      expect(controller.value.currentMotivation!.content, isNotEmpty);

      controller.dispose();
    });

    test('HomeDashboardController completes habit and increments streaks', () {
      const initialHabit = HabitModel(
        id: 'test_habit_1',
        title: 'Su İçme',
        category: 'Sağlık',
        streakDays: 3,
        lastCompletedDate: null,
      );

      final controller = HomeDashboardController(
        initialState: const HomeDashboardState(
          habits: [initialHabit],
          communityStreakCount: 100,
        ),
      );

      expect(controller.value.habits.first.streakDays, 3);
      expect(controller.value.habits.first.isCompletedToday, isFalse);

      // Alışkanlığı tamamla
      controller.toggleCompleteHabit('test_habit_1');

      expect(controller.value.habits.first.isCompletedToday, isTrue);
      expect(controller.value.habits.first.streakDays, 4);
      expect(controller.value.communityStreakCount, 101);

      controller.dispose();
    });
  });

  group('WeAreTogether Widget Smoke Tests', () {
    testWidgets('WeAreTogetherApp renders welcome view with duck and buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(const WeAreTogetherApp());

      expect(find.text(AppStrings.appName), findsOneWidget);
      expect(find.text(AppStrings.signIn), findsOneWidget);
      expect(find.text(AppStrings.register), findsOneWidget);
      expect(find.text(AppStrings.guestMode), findsOneWidget);
    });

    testWidgets('HomeDashboardView renders header, community streak, and 5-tab bar',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeDashboardView(),
        ),
      );

      expect(find.text(AppStrings.appName), findsOneWidget);
      expect(find.text(AppStrings.progressStatsHeader), findsOneWidget);
      expect(find.text(AppStrings.myActiveHabits), findsOneWidget);
      expect(find.text(AppStrings.navFriends), findsOneWidget);
      expect(find.text(AppStrings.navAchievements), findsOneWidget);
      expect(find.text(AppStrings.navCommunity), findsOneWidget);
      expect(find.text(AppStrings.navProfile), findsOneWidget);
    });
  });
}
