import 'package:flutter/material.dart';

/// Proje genelinde kullanılan sabit ölçü, boşluk ve köşe yuvarlama değerleri.
abstract final class AppDimensions {
  // Köşe Yuvarlama (Radius)
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 14.0;
  static const double radiusLarge = 20.0;
  static const double radiusXLarge = 28.0;
  static const double radiusPill = 999.0;

  static const BorderRadius borderRadiusSmall =
      BorderRadius.all(Radius.circular(radiusSmall));
  static const BorderRadius borderRadiusMedium =
      BorderRadius.all(Radius.circular(radiusMedium));
  static const BorderRadius borderRadiusLarge =
      BorderRadius.all(Radius.circular(radiusLarge));
  static const BorderRadius borderRadiusXLarge =
      BorderRadius.all(Radius.circular(radiusXLarge));
  static const BorderRadius borderRadiusPill =
      BorderRadius.all(Radius.circular(radiusPill));

  // İç ve Dış Boşluklar (Padding / Margin)
  static const double spaceXSmall = 4.0;
  static const double spaceSmall = 8.0;
  static const double spaceMedium = 16.0;
  static const double spaceLarge = 24.0;
  static const double spaceXLarge = 32.0;

  static const EdgeInsets paddingScreen = EdgeInsets.symmetric(
    horizontal: spaceMedium,
    vertical: spaceMedium,
  );

  static const EdgeInsets paddingCard = EdgeInsets.all(spaceMedium);

  // Buton ve İkon Ölçüleri
  static const double buttonHeight = 52.0;
  static const double centralFloatingButtonSize = 64.0;
  static const double iconSmall = 18.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;

  // Maskot Ölçüleri
  static const double mascotHeaderSize = 42.0;
  static const double mascotWelcomeSize = 130.0;
}
