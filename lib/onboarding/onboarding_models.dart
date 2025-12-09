import 'package:flutter/material.dart';

class OnboardingSlide {
  OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.characterName,
    required this.heroTag,
    required this.characterBuilder,
    required this.accentColor,
  });

  final String title;
  final String subtitle;
  final String description;
  final String characterName;
  final String heroTag;
  final Widget Function(double t) characterBuilder;
  final Color accentColor;
}

