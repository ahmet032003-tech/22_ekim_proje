import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../models/habit_model.dart';

/// Parlayan (+) butonuna basıldığında açılan yeni alışkanlık ekleme modalı.
class AddHabitModal extends StatefulWidget {
  final ValueChanged<HabitModel> onHabitCreated;

  const AddHabitModal({
    super.key,
    required this.onHabitCreated,
  });

  @override
  State<AddHabitModal> createState() => _AddHabitModalState();
}

class _AddHabitModalState extends State<AddHabitModal> {
  late final TextEditingController _titleController;
  late final TextEditingController _categoryController;
  late final ValueNotifier<bool> _isPrivateNotifier;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _categoryController = TextEditingController(text: 'Kişisel Gelişim');
    _isPrivateNotifier = ValueNotifier<bool>(false);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    _isPrivateNotifier.dispose();
    super.dispose();
  }

  void _submit() {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final newHabit = HabitModel(
      id: 'custom_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      category: _categoryController.text.trim().isEmpty
          ? 'Genel'
          : _categoryController.text.trim(),
      streakDays: 1,
      lastCompletedDate: DateTime.now(),
      isPrivate: _isPrivateNotifier.value,
    );

    widget.onHabitCreated(newHabit);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppDimensions.spaceLarge,
        right: AppDimensions.spaceLarge,
        top: AppDimensions.spaceLarge,
        bottom: MediaQuery.of(context).viewInsets.bottom +
            AppDimensions.spaceLarge,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            const SizedBox(height: AppDimensions.spaceMedium),
            _buildFields(),
            const SizedBox(height: AppDimensions.spaceMedium),
            _buildPrivacyToggle(),
            const SizedBox(height: AppDimensions.spaceLarge),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        Text('🔥', style: TextStyle(fontSize: 22)),
        SizedBox(width: 8),
        Text(
          'Yeni Alışkanlık & Seri Başlat',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildFields() {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Alışkanlık Adı (Örn: Günde 15 Dk Meditasyon)',
            prefixIcon: Icon(Icons.flash_on_rounded, size: 20),
          ),
        ),
        const SizedBox(height: AppDimensions.spaceSmall + 4),
        TextField(
          controller: _categoryController,
          decoration: const InputDecoration(
            labelText: 'Kategori (Örn: Sağlık, Spor, Hobi)',
            prefixIcon: Icon(Icons.category_outlined, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacyToggle() {
    return ValueListenableBuilder<bool>(
      valueListenable: _isPrivateNotifier,
      builder: (context, isPrivate, _) {
        return SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Gizli Seri (Toplulukta görünmesin)',
            style: TextStyle(color: AppColors.textPrimary, fontSize: 13.5),
          ),
          value: isPrivate,
          activeThumbColor: AppColors.flameOrange,
          activeTrackColor: AppColors.flameOrangeDark,
          onChanged: (val) => _isPrivateNotifier.value = val,
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppDimensions.borderRadiusMedium,
        boxShadow: AppColors.flameGlow,
      ),
      child: ElevatedButton.icon(
        icon: const Text('🔥', style: TextStyle(fontSize: 16)),
        label: const Text('Seriyi Başlat & Alevi Yak'),
        onPressed: _submit,
      ),
    );
  }
}
