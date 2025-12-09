import 'package:flutter/material.dart';

import '../adventure/adventure_screen.dart';
import '../theme/app_theme.dart';
import '../widgets/characters.dart';
import '../widgets/curved_footer.dart';
import 'onboarding_models.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;
  double _pageOffset = 0;

  late final List<OnboardingSlide> slides = [
    OnboardingSlide(
      title: 'AHOY!',
      subtitle: 'Welcome aboard!',
      description: 'Learn language as you sail through islands of adventure!',
      characterName: 'HOPPIE',
      heroTag: 'HOPPIE',
      accentColor: AppColors.lime,
      characterBuilder: buildFrogPirate,
    ),
    OnboardingSlide(
      title: 'FOCUS!',
      subtitle: 'Your Mind!',
      description: 'Master words, unlock treasures and level up your journey.',
      characterName: 'MOKSH',
      heroTag: 'MOKSH-FOCUS',
      accentColor: AppColors.amber,
      characterBuilder: buildMeditatingMonk,
    ),
    OnboardingSlide(
      title: 'PREPARE!',
      subtitle: 'For the Quest!',
      description:
          'Face tougher challenges, earn rare rewards & rise as a true language warrior.',
      characterName: 'MOKSH',
      heroTag: 'MOKSH-QUEST',
      accentColor: Colors.black,
      characterBuilder: buildSeaCaptain,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _pageOffset = _controller.page ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF0A2D53), AppColors.navy],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    physics: const BouncingScrollPhysics(),
                    itemCount: slides.length,
                    onPageChanged: (index) => setState(() => _page = index),
                    itemBuilder: (context, index) {
                      final slide = slides[index];
                      final t = (1 - (_pageOffset - index).abs()).clamp(
                        0.0,
                        1.0,
                      );
                      return _OnboardingCard(slide: slide, t: t);
                    },
                  ),
                ),
                _Footer(
                  slides: slides,
                  page: _page,
                  onNext: _handleNext,
                  pageOffset: _pageOffset,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleNext() {
    if (_page < slides.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    final selected = slides[_page];
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 650),
        pageBuilder: (_, animation, __) => FadeTransition(
          opacity: animation,
          child: AdventureScreen(slide: selected),
        ),
      ),
    );
  }
}

class _OnboardingCard extends StatelessWidget {
  const _OnboardingCard({required this.slide, required this.t});

  final OnboardingSlide slide;
  final double t;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          const SizedBox(height: 18),
          _AnimatedText(
            text: slide.title,
            style: theme.textTheme.displayLarge!,
            delay: 0,
            t: t,
          ),
          const SizedBox(height: 8),
          _AnimatedText(
            text: slide.subtitle,
            style: theme.textTheme.headlineMedium!,
            delay: 0.08,
            t: t,
          ),
          const SizedBox(height: 24),
          _AnimatedText(
            text: slide.description,
            style: theme.textTheme.bodyLarge!,
            delay: 0.12,
            textAlign: TextAlign.center,
            t: t,
          ),
          const SizedBox(height: 28),
          Hero(tag: slide.heroTag, child: slide.characterBuilder(t)),
          const SizedBox(height: 4),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: t),
            duration: const Duration(milliseconds: 420),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, 16 * (1 - value)),
                  child: child,
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  width: 90,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  slide.characterName,
                  style: theme.textTheme.headlineMedium!.copyWith(
                    letterSpacing: 2,
                    color: Colors.white,
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

class _AnimatedText extends StatelessWidget {
  const _AnimatedText({
    required this.text,
    required this.style,
    required this.t,
    this.delay = 0,
    this.textAlign,
  });

  final String text;
  final TextStyle style;
  final double delay;
  final double t;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final double visible = (t - delay).clamp(0, 1).toDouble();
    final ease = Curves.easeOutCubic.transform(visible);
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 380),
      opacity: ease,
      child: Transform.translate(
        offset: Offset(0, 24 * (1 - ease)),
        child: Text(text, textAlign: textAlign, style: style),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.slides,
    required this.page,
    required this.onNext,
    required this.pageOffset,
  });

  final List<OnboardingSlide> slides;
  final int page;
  final double pageOffset;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final slide = slides[page];
    return CurvedFooter(
      color: AppColors.lime,
      child: Padding(
        padding: const EdgeInsets.only(top: 28.0, bottom: 24.0),
        child: Column(
          children: [
            _Dots(
              count: slides.length,
              currentPage: pageOffset,
              activeColor: slide.accentColor,
            ),
            const SizedBox(height: 18),
            _FloatingButton(color: slide.accentColor, onPressed: onNext),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({
    required this.count,
    required this.currentPage,
    required this.activeColor,
  });

  final int count;
  final double currentPage;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final distance = (currentPage - index).abs().clamp(0.0, 1.0);
        final double active = 1 - distance.toDouble();
        return AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          height: 10,
          width: 10 + 10 * active,
          decoration: BoxDecoration(
            color: Color.lerp(Colors.white54, activeColor, active),
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }
}

class _FloatingButton extends StatefulWidget {
  const _FloatingButton({required this.color, required this.onPressed});

  final Color color;
  final VoidCallback onPressed;

  @override
  State<_FloatingButton> createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<_FloatingButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650),
    lowerBound: 0.0,
    upperBound: 1.0,
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bg = Color.lerp(widget.color, widget.color.withOpacity(.2), 0.6);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 280),
      width: 88,
      height: 88,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: widget.color.withOpacity(.45),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ScaleTransition(
        scale: Tween(begin: 0.96, end: 1.03).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: Material(
          color: widget.color,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: widget.onPressed,
            child: const Icon(
              Icons.arrow_forward_rounded,
              size: 36,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
