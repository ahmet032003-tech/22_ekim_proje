import 'package:flutter/material.dart';

/// WeAreTogether uygulamasının renk paleti ve tasarım belirteçleri.
/// Material 3 Tam Koyu Tema (Dark Theme First) kurallarına uygundur.
abstract final class AppColors {
  // Marka & Maskot Vurgu Renkleri
  static const Color flameOrange = Color(0xFFFF5722);
  static const Color flameOrangeLight = Color(0xFFFF7043);
  static const Color flameOrangeDark = Color(0xFFE64A19);

  static const Color duckYellow = Color(0xFFFFD54F);
  static const Color duckYellowLight = Color(0xFFFFE082);
  static const Color duckYellowDark = Color(0xFFFFB300);

  // Koyu Arayüz Zeminleri
  static const Color background = Color(0xFF0B0E14);
  static const Color surface = Color(0xFF131822);
  static const Color card = Color(0xFF1A2130);
  static const Color surfaceSecondary = Color(0xFF222B3E);
  static const Color border = Color(0xFF2C374D);

  // Durum & Semantik Renkler
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Metin Renkleri
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Neon Alev ve Ördek Parlama (Glow) Gölgeleri
  static List<BoxShadow> get flameGlow => [
        BoxShadow(
          color: flameOrange.withValues(alpha: 0.45),
          blurRadius: 20,
          spreadRadius: 2,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get duckGlow => [
        BoxShadow(
          color: duckYellow.withValues(alpha: 0.35),
          blurRadius: 18,
          spreadRadius: 1,
          offset: const Offset(0, 4),
        ),
      ];

  // Dinamik Buton ve Kart Gradyanları
  static const LinearGradient flameGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [flameOrangeLight, flameOrange, flameOrangeDark],
  );

  static const LinearGradient duckGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [duckYellowLight, duckYellow, duckYellowDark],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [surface, card],
  );
}
