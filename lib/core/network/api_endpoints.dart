/// Hugging Face API ve harici ağ uç noktaları tanımları.
abstract final class ApiEndpoints {
  static const String huggingFaceBaseUrl =
      'https://api-inference.huggingface.co/models/';

  // Hafif ve hızlı AI koçluk modelleri (SKILL.md Bölüm 5)
  static const String defaultModel = 'mistralai/Mistral-7B-Instruct-v0.2';
  static const String llamaModel = 'meta-llama/Meta-Llama-3-8B-Instruct';

  static String modelInferenceUrl([String model = defaultModel]) =>
      '$huggingFaceBaseUrl$model';

  // İstek Zaman Aşımı Süresi
  static const Duration requestTimeout = Duration(seconds: 8);
}
