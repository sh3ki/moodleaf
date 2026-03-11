import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  final double size;
  final bool showText;
  const AppLogo({super.key, this.size = 48, this.showText = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.14),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(size * 0.08),
          child: Image.asset(
            'assets/images/moodleaf logo.png',
            fit: BoxFit.contain,
          ),
        ),
        if (showText) ...[
          const SizedBox(width: 10),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Mood',
                style: TextStyle(
                  fontSize: size * 0.44,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary,
                ),
              ),
              TextSpan(
                text: 'Leaf',
                style: TextStyle(
                  fontSize: size * 0.44,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.secondary,
                ),
              ),
            ]),
          ),
        ],
      ],
    );
  }
}
