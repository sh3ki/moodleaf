import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'main_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scale;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1400));
    _scale = Tween<double>(begin: 0.7, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut));
    _fade = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _ctrl, curve: const Interval(0.0, 0.6)));
    _slide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero).animate(CurvedAnimation(parent: _ctrl, curve: const Interval(0.3, 1.0, curve: Curves.easeOut)));
    _ctrl.forward();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const MainNavigation()));
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppTheme.primary, AppTheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ScaleTransition(
            scale: _scale,
            child: FadeTransition(
              opacity: _fade,
              child: Container(
                width: 110, height: 110,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 24, offset: Offset(0, 8))],
                ),
                padding: const EdgeInsets.all(10),
                child: Image.asset('assets/images/moodleaf logo.png', fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 24),
          SlideTransition(position: _slide, child: FadeTransition(opacity: _fade, child: Column(children: [
            RichText(text: const TextSpan(children: [
              TextSpan(text: 'Mood', style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800, color: Colors.white)),
              TextSpan(text: 'Leaf', style: TextStyle(fontSize: 38, fontWeight: FontWeight.w800, color: AppTheme.accent)),
            ])),
            const SizedBox(height: 8),
            const Text('Track your feelings, grow your mind', style: TextStyle(color: Colors.white70, fontSize: 15)),
            const SizedBox(height: 36),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _Feature(Icons.edit_note_rounded, 'Journal'),
              const SizedBox(width: 32),
              _Feature(Icons.insights_rounded, 'Insights'),
              const SizedBox(width: 32),
              _Feature(Icons.local_fire_department_rounded, 'Streaks'),
            ]),
          ]))),
        ]))),
      ),
    );
  }
}

class _Feature extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Feature(this.icon, this.label);

  @override
  Widget build(BuildContext context) => Column(children: [
    Container(
      width: 48, height: 48,
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.20), borderRadius: BorderRadius.circular(14)),
      child: Icon(icon, size: 26, color: Colors.white),
    ),
    const SizedBox(height: 6),
    Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
  ]);
}
