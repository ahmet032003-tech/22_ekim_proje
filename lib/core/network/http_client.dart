import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'api_endpoints.dart';

/// Güvenli, zaman aşımı korumalı ve UI'dan yalıtılmış ağ istemcisi.
class AppHttpClient {
  final http.Client _client;

  AppHttpClient({http.Client? client}) : _client = client ?? http.Client();

  /// JSON gövdeli POST isteği gönderir ve yanıtı ayrıştırır.
  Future<dynamic> postJson({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    Duration? timeout,
  }) async {
    final uri = Uri.parse(url);
    final effectiveHeaders = {
      'Content-Type': 'application/json',
      ...?headers,
    };

    try {
      final response = await _client
          .post(
            uri,
            headers: effectiveHeaders,
            body: jsonEncode(body),
          )
          .timeout(timeout ?? ApiEndpoints.requestTimeout);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        throw HttpException(
          'HTTP ${response.statusCode}: ${response.reasonPhrase ?? "Sunucu Hatası"}',
          uri: uri,
        );
      }
    } on SocketException {
      throw const SocketException('İnternet bağlantısı kurulamadı.');
    } on TimeoutException {
      throw TimeoutException('İstek zaman aşımına uğradı.');
    } catch (e) {
      rethrow;
    }
  }

  void dispose() {
    _client.close();
  }
}
