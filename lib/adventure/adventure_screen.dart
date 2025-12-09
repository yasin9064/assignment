import 'package:flutter/material.dart';

import '../language/language_selection_screen.dart';
import '../onboarding/onboarding_models.dart';
import '../theme/app_theme.dart';
import '../widgets/curved_footer.dart';

class AdventureScreen extends StatelessWidget {
  const AdventureScreen({
    super.key,
    required this.slide,
  });

  final OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0E365E),
                    AppColors.navy,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      Text('Adventure Deck', style: theme.textTheme.headlineMedium),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      // Hero handoff from onboarding character into the quest deck.
                      Hero(
                        tag: slide.heroTag,
                        child: slide.characterBuilder(1),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'You are ready to set sail!',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        slide.description,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 24),
                      _InfoCard(
                        title: 'Progressive difficulty',
                        subtitle: 'Unlock tougher islands as you master words.',
                        icon: Icons.bar_chart_rounded,
                        accent: slide.accentColor,
                      ),
                      _InfoCard(
                        title: 'Treasure rewards',
                        subtitle: 'Collect streak chests, badges and rare loot.',
                        icon: Icons.emoji_events_outlined,
                        accent: slide.accentColor,
                      ),
                      _InfoCard(
                        title: 'Mindful sessions',
                        subtitle: 'Short, focused sprints keep momentum high.',
                        icon: Icons.spa_rounded,
                        accent: slide.accentColor,
                      ),
                      const SizedBox(height: 110),
                    ],
                  ),
                ),
                CurvedFooter(
                  color: AppColors.lime,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                    child: Column(
                      children: [
                        Text(
                          'Launch your quest',
                          style: theme.textTheme.headlineMedium!
                              .copyWith(color: AppColors.navy, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.navy,
                            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                          label: const Text(
                            'Start Lesson',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => LanguageSelectionScreen(slide: slide),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 420),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(offset: Offset(0, 20 * (1 - value)), child: child),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: accent.withOpacity(.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: accent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.white70)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

