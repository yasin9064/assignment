import 'package:flutter/material.dart';

class CurvedFooter extends StatelessWidget {
  const CurvedFooter({super.key, required this.color, this.child});

  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _ArcClipper(),
      child: Container(
        height: 220,
        color: color,
        alignment: Alignment.topCenter,
        child: child,
      ),
    );
  }
}

class _ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 60,
      size.width,
      size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
