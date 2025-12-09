import 'package:flutter/material.dart';

import '../onboarding/onboarding_models.dart';
import '../theme/app_theme.dart';
import '../widgets/curved_footer.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key, required this.slide});

  final OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    final languages = [
      'हिन्दी',
      'English',
      'मराठी',
      'தமிழ்',
      'اردو',
      'తెలుగు',
      'ಕನ್ನಡ',
      'മലയാളം',
      'English'
    ];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0B2847), AppColors.navy],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Wrap(
                    spacing: 28,
                    runSpacing: 18,
                    alignment: WrapAlignment.center,
                    children: [
                      for (final lang in languages)
                        Text(
                          lang,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                _SpeechBubble(),
                const SizedBox(height: 12),
                SizedBox(
                  height: 230,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      const _Waves(),
                      Positioned(
                        bottom: 34,
                        child: _Boat(),
                      ),
                      Positioned(
                        bottom: 72,
                        child: Hero(
                          tag: slide.heroTag,
                          child: SizedBox(
                            height: 160,
                            child: slide.characterBuilder(1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CurvedFooter(
                  color: const Color(0xFF04B6C7),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.navy,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                          elevation: 0,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
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

class _SpeechBubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 48),
          height: 96,
          decoration: BoxDecoration(
            color: const Color(0xFFE3E4E8),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        CustomPaint(
          size: const Size(32, 28),
          painter: _BubbleTailPainter(),
        )
      ],
    );
  }
}

class _BubbleTailPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFE3E4E8);
    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Boat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 90,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: 180,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8C5B32), Color(0xFF623A1C)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 14,
            child: Container(
              width: 200,
              height: 34,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFA66B3F), Color(0xFF7A4A29)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Waves extends StatelessWidget {
  const _Waves();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _waveStrip(0.9, 0.45),
          _waveStrip(1.1, 0.3),
          _waveStrip(0.8, 0.2),
        ],
      ),
    );
  }

  Widget _waveStrip(double widthFactor, double opacity) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(opacity),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(opacity * 0.5),
              blurRadius: 18,
              spreadRadius: -6,
            ),
          ],
        ),
        width: double.infinity,
        constraints: BoxConstraints(
          maxWidth: 320 * widthFactor,
          minWidth: 180 * widthFactor,
        ),
      ),
    );
  }
}

