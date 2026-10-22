import 'dart:math';
import '../../../core/constants/app_strings.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/http_client.dart';
import '../models/ai_coach_message.dart';

/// Hugging Face Inference API ile konuşan ve arayüzü kilitlemeyen AI Koç Servisi.
/// Ağ kesintisinde veya API gecikmesinde yerel yedek (fallback) devreye girer.
class HuggingFaceService {
  final AppHttpClient _httpClient;
  final String? apiToken;
  final Random _random = Random();

  HuggingFaceService({
    AppHttpClient? httpClient,
    this.apiToken,
  }) : _httpClient = httpClient ?? AppHttpClient();

  /// Günlük dinamik motivasyon tavsiyesi üretir.
  Future<AiCoachMessage> getDailyMotivation({
    required int streakCount,
    required String habitTitle,
  }) async {
    final prompt =
        'Sen WeAreTogether uygulamasının sevimli Yavru Ördek AI Koçusun. '
        'Kullanıcının "$habitTitle" alışkanlığında $streakCount günlük alevli serisi (streak) var. '
        'Ona samimi, enerjik, pozitif ve motive edici Türkçe 2 cümlelik bir koçluk tavsiyesi yaz:';

    try {
      final headers = <String, String>{};
      if (apiToken != null && apiToken!.isNotEmpty) {
        headers['Authorization'] = 'Bearer $apiToken';
      }

      final response = await _httpClient.postJson(
        url: ApiEndpoints.modelInferenceUrl(),
        headers: headers,
        body: {
          'inputs': prompt,
          'parameters': {
            'max_new_tokens': 90,
            'temperature': 0.7,
            'return_full_text': false,
          },
        },
      );

      final generatedText = _extractGeneratedText(response);
      if (generatedText != null && generatedText.trim().isNotEmpty) {
        return AiCoachMessage(
          id: 'hf_${DateTime.now().millisecondsSinceEpoch}',
          content: generatedText.trim(),
          timestamp: DateTime.now(),
          isFallback: false,
          category: 'motivation',
        );
      }
    } catch (_) {
      // Ağ hatası, zaman aşımı veya yetkilendirme yokluğunda sessizce yedeğe geçilir.
    }

    return _generateFallbackMotivation(
      streakCount: streakCount,
      habitTitle: habitTitle,
    );
  }

  /// Kullanıcının serbest metin olarak girdiği büyük hedefi mikro adımlara böler.
  Future<AiCoachMessage> breakDownGoal(String bigGoal) async {
    final prompt =
        'Sen Yavru Ördek AI Koçusun. Kullanıcı şu büyük hedefi gerçekleştirmek istiyor: "$bigGoal". '
        'Bunu her gün kolayca yapabileceği 3 maddelik mikro alışkanlığa böl. Maddeli ve kısa yaz:';

    try {
      final headers = <String, String>{};
      if (apiToken != null && apiToken!.isNotEmpty) {
        headers['Authorization'] = 'Bearer $apiToken';
      }

      final response = await _httpClient.postJson(
        url: ApiEndpoints.modelInferenceUrl(),
        headers: headers,
        body: {
          'inputs': prompt,
          'parameters': {
            'max_new_tokens': 120,
            'temperature': 0.6,
          },
        },
      );

      final generatedText = _extractGeneratedText(response);
      if (generatedText != null && generatedText.trim().isNotEmpty) {
        return AiCoachMessage(
          id: 'goal_${DateTime.now().millisecondsSinceEpoch}',
          content: generatedText.trim(),
          timestamp: DateTime.now(),
          isFallback: false,
          category: 'goal_breakdown',
        );
      }
    } catch (_) {
      // Yedek mekanizması
    }

    return AiCoachMessage(
      id: 'fallback_goal_${DateTime.now().millisecondsSinceEpoch}',
      content:
          '1. Adım: Günde sadece 10 dakika ile başla ve seriyi yak.\n'
          '2. Adım: Su ve uyku düzenini bu hedefe göre ayarla.\n'
          '3. Adım: Her günkü küçük zaferini toplulukla paylaşarak kutla!',
      timestamp: DateTime.now(),
      isFallback: true,
      category: 'goal_breakdown',
    );
  }

  /// Kriz Anı Desteği (Streak Rescue)
  Future<AiCoachMessage> rescueStreak({
    required String habitTitle,
    required int currentStreak,
  }) async {
    final rescueQuotes = [
      'Vazgeçmek kolay, ama $currentStreak gündür yaktığın o güzel alev çok kıymetli! Bugün sadece 5 dakikanı ver, seriyi koru!',
      'Yavru Ördek seninle! Yorgun olsan bile mikro bir adım atarak bugünü kurtarabilirsin. Hadi, alev sönmesin!',
      'Unutma: Zor günlerde korunan seriler, en kalıcı alışkanlıkları inşa eder. Topluluk senin arkanda!',
    ];

    final picked = rescueQuotes[_random.nextInt(rescueQuotes.length)];
    return AiCoachMessage(
      id: 'rescue_${DateTime.now().millisecondsSinceEpoch}',
      content: picked,
      timestamp: DateTime.now(),
      isFallback: true,
      category: 'streak_rescue',
    );
  }

  /// Yerel motivasyon söz havuzundan bağlama uygun seçim yapar.
  AiCoachMessage _generateFallbackMotivation({
    required int streakCount,
    required String habitTitle,
  }) {
    final pool = AppStrings.fallbackAiQuotes;
    final index = _random.nextInt(pool.length);
    final baseText = pool[index];
    final personalizedText =
        '$habitTitle yolculuğunda $streakCount. günün! $baseText';

    return AiCoachMessage(
      id: 'fb_${DateTime.now().millisecondsSinceEpoch}',
      content: personalizedText,
      timestamp: DateTime.now(),
      isFallback: true,
      category: 'motivation',
    );
  }

  /// Hugging Face yanıtından üretilen metni ayrıştırır.
  String? _extractGeneratedText(dynamic jsonResponse) {
    if (jsonResponse is List && jsonResponse.isNotEmpty) {
      final first = jsonResponse.first;
      if (first is Map && first.containsKey('generated_text')) {
        return first['generated_text']?.toString();
      }
    } else if (jsonResponse is Map && jsonResponse.containsKey('generated_text')) {
      return jsonResponse['generated_text']?.toString();
    }
    return null;
  }

  void dispose() {
    _httpClient.dispose();
  }
}
