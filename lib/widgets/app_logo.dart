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
        Text('🌿', style: TextStyle(fontSize: size * 0.75)),
        if (showText) ...[
          const SizedBox(width: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(text: 'Mood', style: TextStyle(fontSize: size * 0.5, fontWeight: FontWeight.w800, color: AppTheme.primary)),
                TextSpan(text: 'Leaf', style: TextStyle(fontSize: size * 0.5, fontWeight: FontWeight.w800, color: AppTheme.secondary)),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
