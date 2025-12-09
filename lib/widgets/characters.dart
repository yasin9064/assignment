import 'package:flutter/material.dart';

/// Character widgets now backed by provided asset images.
Widget buildFrogPirate(double t) {
  return _AnimatedCharacter(
    t: t,
    asset: 'assets/piratefrog.png',
    height: 240,
  );
}

Widget buildMeditatingMonk(double t) {
  return _AnimatedCharacter(
    t: t,
    asset: 'assets/monk.png',
    height: 240,
  );
}

Widget buildSeaCaptain(double t) {
  return _AnimatedCharacter(
    t: t,
    asset: 'assets/pirate.png',
    height: 240,
  );
}

class _AnimatedCharacter extends StatelessWidget {
  const _AnimatedCharacter({
    required this.t,
    required this.asset,
    required this.height,
  });

  final double t;
  final String asset;
  final double height;

  @override
  Widget build(BuildContext context) {
    final curve = Curves.easeOutBack.transform(t.clamp(0, 1));
    return AnimatedScale(
      duration: const Duration(milliseconds: 450),
      scale: 0.9 + 0.1 * curve,
      curve: Curves.easeOut,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 380),
        opacity: (0.6 + 0.4 * curve).clamp(0.0, 1.0),
        child: SizedBox(
          height: height,
          child: Image.asset(
            asset,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}

