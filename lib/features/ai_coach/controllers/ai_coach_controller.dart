import 'package:flutter/foundation.dart';
import '../models/ai_coach_state.dart';
import '../services/hugging_face_service.dart';

/// AI Koç ekran durumunu ve API akışını yöneten ValueNotifier kontrolcüsü.
class AiCoachController extends ValueNotifier<AiCoachState> {
  final HuggingFaceService _service;
  final bool _ownsService;

  AiCoachController({
    AiCoachState? initialState,
    HuggingFaceService? service,
  })  : _service = service ?? HuggingFaceService(),
        _ownsService = service == null,
        super(initialState ?? const AiCoachState());

  /// Günlük motivasyon tavsiyesini getirir.
  Future<void> fetchDailyMotivation({
    required int streakCount,
    required String habitTitle,
  }) async {
    value = value.copyWith(isLoading: true, clearError: true);

    try {
      final message = await _service.getDailyMotivation(
        streakCount: streakCount,
        habitTitle: habitTitle,
      );

      final updatedList = [...value.messages, message];
      value = value.copyWith(
        isLoading: false,
        currentMotivation: message,
        messages: updatedList,
        clearError: true,
      );
    } catch (e) {
      value = value.copyWith(
        isLoading: false,
        errorMessage: 'Motivasyon alınamadı. Lütfen tekrar deneyin.',
      );
    }
  }

  /// Kullanıcının girdiği büyük hedefi parçalar.
  Future<void> breakDownGoal(String bigGoal) async {
    if (bigGoal.trim().isEmpty) return;

    value = value.copyWith(isLoading: true, clearError: true);

    try {
      final message = await _service.breakDownGoal(bigGoal);
      value = value.copyWith(
        isLoading: false,
        messages: [...value.messages, message],
        clearError: true,
      );
    } catch (_) {
      value = value.copyWith(
        isLoading: false,
        errorMessage: 'Hedef parçalama önerisi üretilemedi.',
      );
    }
  }

  /// Kriz anı tavsiyesi ister.
  Future<void> requestRescueAdvice({
    required String habitTitle,
    required int currentStreak,
  }) async {
    value = value.copyWith(isLoading: true, clearError: true);

    try {
      final message = await _service.rescueStreak(
        habitTitle: habitTitle,
        currentStreak: currentStreak,
      );
      value = value.copyWith(
        isLoading: false,
        messages: [...value.messages, message],
        clearError: true,
      );
    } catch (_) {
      value = value.copyWith(
        isLoading: false,
        errorMessage: 'Destek tavsiyesi alınamadı.',
      );
    }
  }

  @override
  void dispose() {
    if (_ownsService) {
      _service.dispose();
    }
    super.dispose();
  }
}
