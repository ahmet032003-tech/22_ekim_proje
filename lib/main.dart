import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/views/auth_welcome_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WeAreTogetherApp());
}

/// WeAreTogether Ana Uygulaması (project.md Kurallarına uygundur).
class WeAreTogetherApp extends StatelessWidget {
  const WeAreTogetherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeAreTogether',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
      theme: AppTheme.darkTheme,
      home: const AuthWelcomeView(),
    );
  }
}
