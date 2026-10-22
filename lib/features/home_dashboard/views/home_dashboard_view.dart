import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../achievements/views/achievements_view.dart';
import '../../ai_coach/controllers/ai_coach_controller.dart';
import '../../ai_coach/models/ai_coach_state.dart';
import '../../ai_coach/widgets/ai_coach_card.dart';
import '../../community/views/community_view.dart';
import '../../friends/views/friends_view.dart';
import '../../habit_management/models/habit_model.dart';
import '../../habit_management/widgets/add_habit_modal.dart';
import '../../user_profile/views/user_profile_view.dart';
import '../controllers/home_dashboard_controller.dart';
import '../models/home_dashboard_state.dart';
import '../widgets/active_habit_tile.dart';
import '../widgets/community_streak_card.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/home_header.dart';
import '../widgets/progress_stats_card.dart';

/// Ana Kontrol Paneli ve 5 Sekmeli Ana Ekran (SKILL.md Bölüm 3 & 4).
class HomeDashboardView extends StatefulWidget {
  final HabitModel? initialHabit;
  final HomeDashboardController? controller;
  final AiCoachController? aiCoachController;

  const HomeDashboardView({
    super.key,
    this.initialHabit,
    this.controller,
    this.aiCoachController,
  });

  @override
  State<HomeDashboardView> createState() => _HomeDashboardViewState();
}

class _HomeDashboardViewState extends State<HomeDashboardView> {
  late final HomeDashboardController _controller;
  late final AiCoachController _aiCoachController;
  late final bool _ownsController;
  late final bool _ownsAiCoachController;

  @override
  void initState() {
    super.initState();
    final defaultHabit = widget.initialHabit ??
        const HabitModel(
          id: 'default_running',
          title: AppStrings.templateRunningTitle,
          category: 'Spor & Sağlık',
          streakDays: 7,
          lastCompletedDate: null,
        );

    _controller = widget.controller ??
        HomeDashboardController(
          initialState: HomeDashboardState(
            habits: [defaultHabit],
          ),
        );
    _ownsController = widget.controller == null;

    _aiCoachController = widget.aiCoachController ?? AiCoachController();
    _ownsAiCoachController = widget.aiCoachController == null;

    _fetchInitialMotivation(defaultHabit);
  }

  void _fetchInitialMotivation(HabitModel habit) {
    _aiCoachController.fetchDailyMotivation(
      streakCount: habit.streakDays,
      habitTitle: habit.title,
    );
  }

  @override
  void dispose() {
    if (_ownsController) _controller.dispose();
    if (_ownsAiCoachController) _aiCoachController.dispose();
    super.dispose();
  }

  void _openAddHabitModal() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusLarge),
        ),
      ),
      builder: (_) => AddHabitModal(
        onHabitCreated: (newHabit) {
          _controller.addHabit(newHabit);
          _controller.setTabIndex(2);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<HomeDashboardState>(
      valueListenable: _controller,
      builder: (context, state, _) {
        return Scaffold(
          body: Column(
            children: [
              HomeHeader(totalStreak: state.highestStreak),
              Expanded(
                child: IndexedStack(
                  index: state.currentTabIndex,
                  children: [
                    const FriendsView(),
                    const AchievementsView(),
                    _buildHabitsTab(state),
                    const CommunityView(),
                    const UserProfileView(),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: state.currentTabIndex,
            onTabSelected: _controller.setTabIndex,
            onAddHabit: _openAddHabitModal,
          ),
        );
      },
    );
  }

  Widget _buildHabitsTab(HomeDashboardState state) {
    return SingleChildScrollView(
      padding: AppDimensions.paddingScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommunityStreakCard(count: state.communityStreakCount),
          const SizedBox(height: AppDimensions.spaceMedium),
          ProgressStatsCard(habits: state.habits),
          const SizedBox(height: AppDimensions.spaceMedium),
          _buildAiCoachSection(state),
          const SizedBox(height: AppDimensions.spaceLarge),
          _buildHabitsSectionHeader(),
          const SizedBox(height: AppDimensions.spaceMedium),
          ...state.habits.map((habit) => ActiveHabitTile(
                habit: habit,
                onComplete: () => _controller.toggleCompleteHabit(habit.id),
              )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildAiCoachSection(HomeDashboardState state) {
    return ValueListenableBuilder<AiCoachState>(
      valueListenable: _aiCoachController,
      builder: (context, aiState, _) {
        final activeHabit =
            state.habits.isNotEmpty ? state.habits.first : null;

        return AiCoachCard(
          message: aiState.currentMotivation,
          isLoading: aiState.isLoading,
          onRefresh: () {
            if (activeHabit != null) {
              _aiCoachController.fetchDailyMotivation(
                streakCount: activeHabit.streakDays,
                habitTitle: activeHabit.title,
              );
            }
          },
        );
      },
    );
  }

  Widget _buildHabitsSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          AppStrings.myActiveHabits,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: _openAddHabitModal,
          borderRadius: AppDimensions.borderRadiusSmall,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: [
                Icon(Icons.add_circle_outline_rounded,
                    color: AppColors.duckYellow, size: 16),
                SizedBox(width: 4),
                Text(
                  'Yeni Alışkanlık',
                  style: TextStyle(
                    color: AppColors.duckYellow,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
