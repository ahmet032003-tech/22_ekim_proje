import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';

/// İlk kurulum ve hazır alışkanlık şablonu veri modeli (SKILL.md Bölüm 2).
@immutable
class HabitTemplate {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final String category;
  final int initialStreakGoal;

  const HabitTemplate({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
    this.initialStreakGoal = 21,
  });

  /// Şartnamedeki 5 hazır alışkanlık şablonu listesi
  static List<HabitTemplate> get defaultTemplates => const [
        HabitTemplate(
          id: 'template_running',
          title: AppStrings.templateRunningTitle,
          description: AppStrings.templateRunningDesc,
          icon: Icons.directions_run_rounded,
          category: 'Spor & Sağlık',
        ),
        HabitTemplate(
          id: 'template_smoking',
          title: AppStrings.templateSmokingTitle,
          description: AppStrings.templateSmokingDesc,
          icon: Icons.smoke_free_rounded,
          category: 'Sağlıklı Yaşam',
        ),
        HabitTemplate(
          id: 'template_knitting',
          title: AppStrings.templateKnittingTitle,
          description: AppStrings.templateKnittingDesc,
          icon: Icons.cut_rounded,
          category: 'Hobi & Terapi',
        ),
        HabitTemplate(
          id: 'template_reading',
          title: AppStrings.templateReadingTitle,
          description: AppStrings.templateReadingDesc,
          icon: Icons.menu_book_rounded,
          category: 'Kişisel Gelişim',
        ),
        HabitTemplate(
          id: 'template_water',
          title: AppStrings.templateWaterTitle,
          description: AppStrings.templateWaterDesc,
          icon: Icons.water_drop_rounded,
          category: 'Sağlık & Canlılık',
        ),
      ];

  HabitTemplate copyWith({
    String? id,
    String? title,
    String? description,
    IconData? icon,
    String? category,
    int? initialStreakGoal,
  }) {
    return HabitTemplate(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      category: category ?? this.category,
      initialStreakGoal: initialStreakGoal ?? this.initialStreakGoal,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is HabitTemplate &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.icon == icon &&
        other.category == category &&
        other.initialStreakGoal == initialStreakGoal;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      title,
      description,
      icon,
      category,
      initialStreakGoal,
    );
  }
}
