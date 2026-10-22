import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

/// Karşılama ekranında 2 aşamalı yumuşak metin animasyonu (SKILL.md Bölüm 1).
/// 1. Aşama: "Yalnız değilsin. Birlikte başaracağız"
/// 2. Aşama (~2 sn sonra): "Sen de Aramıza Katıl"
class AnimatedGreetingText extends StatefulWidget {
  final VoidCallback? onTransitionComplete;

  const AnimatedGreetingText({
    super.key,
    this.onTransitionComplete,
  });

  @override
  State<AnimatedGreetingText> createState() => _AnimatedGreetingTextState();
}

class _AnimatedGreetingTextState extends State<AnimatedGreetingText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  int _step = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _startSequence();
  }

  Future<void> _startSequence() async {
    // 1. Aşamayı başlat
    await _controller.forward();

    // 2 saniye bekle
    await Future<void>.delayed(const Duration(milliseconds: 1800));

    if (!mounted) return;

    // 1. Aşamadan çıkış yap
    await _controller.reverse();

    if (!mounted) return;

    // 2. Aşamaya geçiş
    setState(() {
      _step = 2;
    });

    await _controller.forward();
    widget.onTransitionComplete?.call();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = _step == 1
        ? AppStrings.welcomeGreetingStep1
        : AppStrings.welcomeGreetingStep2;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
              height: 1.35,
              letterSpacing: -0.3,
            ),
          ),
        ),
      ),
    );
  }
}
