import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'onboarding/onboarding_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const LanguageAdventureApp());
}

class LanguageAdventureApp extends StatelessWidget {
  const LanguageAdventureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Language Adventure',
      theme: buildAppTheme(),
      home: const OnboardingScreen(),
    );
  }
}
