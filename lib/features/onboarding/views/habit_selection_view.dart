import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../habit_management/models/habit_model.dart';
import '../../home_dashboard/views/home_dashboard_view.dart';
import '../models/habit_template.dart';
import '../widgets/habit_template_card.dart';

/// İlk Alışkanlık Seçimi Ekranı (SKILL.md Bölüm 2).
/// Durum yönetimi `ValueNotifier<String>` ile sayfa düzeyinde setState olmaksızın yürütülür.
class HabitSelectionView extends StatefulWidget {
  const HabitSelectionView({super.key});

  @override
  State<HabitSelectionView> createState() => _HabitSelectionViewState();
}

class _HabitSelectionViewState extends State<HabitSelectionView> {
  late final ValueNotifier<String> _selectedTemplateIdNotifier;
  late final List<HabitTemplate> _templates;

  @override
  void initState() {
    super.initState();
    _templates = HabitTemplate.defaultTemplates;
    _selectedTemplateIdNotifier = ValueNotifier<String>(_templates.first.id);
  }

  @override
  void dispose() {
    _selectedTemplateIdNotifier.dispose();
    super.dispose();
  }

  void _confirmSelection() {
    final selectedId = _selectedTemplateIdNotifier.value;
    final selectedTemplate = _templates.firstWhere((t) => t.id == selectedId);

    final initialHabit = HabitModel(
      id: 'habit_${DateTime.now().millisecondsSinceEpoch}',
      title: selectedTemplate.title,
      category: selectedTemplate.category,
      streakDays: 1,
      lastCompletedDate: DateTime.now(),
    );

    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => HomeDashboardView(initialHabit: initialHabit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.habitSelectionHeader),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildSubHeader(),
            Expanded(
              child: _buildTemplateList(),
            ),
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubHeader() {
    return const Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.spaceLarge,
        vertical: AppDimensions.spaceSmall,
      ),
      child: Text(
        AppStrings.habitSelectionSubHeader,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildTemplateList() {
    return ValueListenableBuilder<String>(
      valueListenable: _selectedTemplateIdNotifier,
      builder: (context, selectedId, _) {
        return ListView.builder(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.spaceLarge,
            vertical: AppDimensions.spaceSmall,
          ),
          itemCount: _templates.length,
          itemBuilder: (context, index) {
            final template = _templates[index];
            return HabitTemplateCard(
              template: template,
              isSelected: template.id == selectedId,
              onTap: () {
                _selectedTemplateIdNotifier.value = template.id;
              },
            );
          },
        );
      },
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.spaceLarge),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: AppDimensions.borderRadiusMedium,
          boxShadow: AppColors.flameGlow,
        ),
        child: ElevatedButton(
          onPressed: _confirmSelection,
          child: const Text(AppStrings.confirmHabit),
        ),
      ),
    );
  }
}
