import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// WeAreTogether uygulamasının sevimli Yavru Ördek maskotu.
/// Canvas tabanlıdır; harici asset gerektirmez ve çözünürlükten bağımsız çalışır.
class DuckMascotWidget extends StatefulWidget {
  final double size;
  final bool animate;
  final bool showFlameCrown;

  const DuckMascotWidget({
    super.key,
    this.size = 110.0,
    this.animate = true,
    this.showFlameCrown = true,
  });

  @override
  State<DuckMascotWidget> createState() => _DuckMascotWidgetState();
}

class _DuckMascotWidgetState extends State<DuckMascotWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    if (widget.animate) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.animate) {
      return _buildStaticMascot(0.0);
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        final waveAngle = math.sin(_controller.value * math.pi) * 0.18;
        return _buildStaticMascot(waveAngle);
      },
    );
  }

  Widget _buildStaticMascot(double waveAngle) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: _DuckPainter(
          waveAngle: waveAngle,
          showFlameCrown: widget.showFlameCrown,
        ),
      ),
    );
  }
}

class _DuckPainter extends CustomPainter {
  final double waveAngle;
  final bool showFlameCrown;

  _DuckPainter({
    required this.waveAngle,
    required this.showFlameCrown,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Dış Parlama Halkası
    final glowPaint = Paint()
      ..color = AppColors.duckYellow.withValues(alpha: 0.15)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);
    canvas.drawCircle(Offset(w * 0.5, h * 0.52), w * 0.44, glowPaint);

    // 2. Gövde
    final bodyPaint = Paint()..color = AppColors.duckYellow;
    final bodyRect = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.58),
      width: w * 0.72,
      height: h * 0.62,
    );
    canvas.drawOval(bodyRect, bodyPaint);

    // 3. Baş
    final headRect = Rect.fromCenter(
      center: Offset(w * 0.5, h * 0.38),
      width: w * 0.60,
      height: h * 0.54,
    );
    canvas.drawOval(headRect, bodyPaint);

    // 4. Alev Tacı (Tüy / Alev Detayı)
    if (showFlameCrown) {
      _drawFlameCrown(canvas, w, h);
    }

    // 5. Gözler
    _drawEyes(canvas, w, h);

    // 6. Yanaklar (Pembe tatlılık)
    _drawCheeks(canvas, w, h);

    // 7. Gaga (Turuncu)
    _drawBeak(canvas, w, h);

    // 8. Selam Veren Sağ Kanat
    _drawWavingWing(canvas, w, h);

    // 9. Sol Kanat
    final leftWingPaint = Paint()..color = AppColors.duckYellowDark;
    final leftWingRect = Rect.fromCenter(
      center: Offset(w * 0.20, h * 0.58),
      width: w * 0.16,
      height: h * 0.28,
    );
    canvas.drawOval(leftWingRect, leftWingPaint);
  }

  void _drawFlameCrown(Canvas canvas, double w, double h) {
    final flamePaint = Paint()
      ..shader = AppColors.flameGradient.createShader(
        Rect.fromLTWH(w * 0.4, h * 0.05, w * 0.2, h * 0.2),
      );

    final path = Path()
      ..moveTo(w * 0.5, h * 0.08)
      ..quadraticBezierTo(w * 0.62, h * 0.18, w * 0.55, h * 0.26)
      ..quadraticBezierTo(w * 0.5, h * 0.24, w * 0.45, h * 0.26)
      ..quadraticBezierTo(w * 0.38, h * 0.18, w * 0.5, h * 0.08);

    canvas.drawPath(path, flamePaint);
  }

  void _drawEyes(Canvas canvas, double w, double h) {
    final eyePaint = Paint()..color = const Color(0xFF1E293B);
    final shinePaint = Paint()..color = Colors.white;

    // Sol Göz
    canvas.drawCircle(Offset(w * 0.38, h * 0.35), w * 0.055, eyePaint);
    canvas.drawCircle(Offset(w * 0.365, h * 0.335), w * 0.02, shinePaint);

    // Sağ Göz
    canvas.drawCircle(Offset(w * 0.62, h * 0.35), w * 0.055, eyePaint);
    canvas.drawCircle(Offset(w * 0.605, h * 0.335), w * 0.02, shinePaint);
  }

  void _drawCheeks(Canvas canvas, double w, double h) {
    final cheekPaint = Paint()
      ..color = const Color(0xFFFF8A80).withValues(alpha: 0.55);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.29, h * 0.42),
        width: w * 0.09,
        height: h * 0.05,
      ),
      cheekPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(w * 0.71, h * 0.42),
        width: w * 0.09,
        height: h * 0.05,
      ),
      cheekPaint,
    );
  }

  void _drawBeak(Canvas canvas, double w, double h) {
    final beakPaint = Paint()..color = AppColors.flameOrange;
    final beakPath = Path()
      ..moveTo(w * 0.41, h * 0.40)
      ..quadraticBezierTo(w * 0.5, h * 0.37, w * 0.59, h * 0.40)
      ..quadraticBezierTo(w * 0.5, h * 0.49, w * 0.41, h * 0.40);
    canvas.drawPath(beakPath, beakPaint);
  }

  void _drawWavingWing(Canvas canvas, double w, double h) {
    canvas.save();
    // Sağ kanat pivot noktası
    final pivotX = w * 0.78;
    final pivotY = h * 0.54;
    canvas.translate(pivotX, pivotY);
    canvas.rotate(-0.35 + waveAngle);

    final wingPaint = Paint()..color = AppColors.duckYellowDark;
    final wingRect = Rect.fromCenter(
      center: Offset(w * 0.08, -h * 0.04),
      width: w * 0.18,
      height: h * 0.32,
    );
    canvas.drawOval(wingRect, wingPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _DuckPainter oldDelegate) {
    return oldDelegate.waveAngle != waveAngle ||
        oldDelegate.showFlameCrown != showFlameCrown;
  }
}
