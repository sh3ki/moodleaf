import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'log_mood_screen.dart';
import 'history_screen.dart';
import 'insights_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _idx = 0;

  final _screens = const [
    HomeScreen(),
    LogMoodScreen(),
    HistoryScreen(),
    InsightsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _idx, children: _screens),
      bottomNavigationBar: _FloatingNavBar(
        selectedIndex: _idx,
        onTap: (i) => setState(() => _idx = i),
      ),
    );
  }
}

class _FloatingNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const _FloatingNavBar({required this.selectedIndex, required this.onTap});

  static const _colors = [
    AppTheme.primary,
    AppTheme.accent,
    AppTheme.secondary,
    AppTheme.purple,
    AppTheme.pink,
  ];

  static const _activeIcons = [
    Icons.home_rounded,
    Icons.add_circle_rounded,
    Icons.calendar_month_rounded,
    Icons.bar_chart_rounded,
    Icons.person_rounded,
  ];

  static const _inactiveIcons = [
    Icons.home_outlined,
    Icons.add_circle_outline,
    Icons.calendar_month_outlined,
    Icons.bar_chart_outlined,
    Icons.person_outline,
  ];

  static const _labels = ['Home', 'Log', 'History', 'Insights', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.of(context).padding.bottom;
    return Container(
      color: AppTheme.surface,
      padding: EdgeInsets.fromLTRB(16, 8, 16, 14 + bottomPad),
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFFFFF), Color(0xFFF8FFFE)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.13), blurRadius: 28, offset: const Offset(0, 10)),
            BoxShadow(color: AppTheme.primary.withOpacity(0.10), blurRadius: 14, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (i) {
            final active = i == selectedIndex;
            final color = _colors[i];
            return GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: SizedBox(
                width: 62,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutBack,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: active ? color.withOpacity(0.14) : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        active ? _activeIcons[i] : _inactiveIcons[i],
                        color: active ? color : const Color(0xFFB8CCBB),
                        size: active ? 25 : 22,
                      ),
                    ),
                    const SizedBox(height: 1),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                        color: active ? color : const Color(0xFFB8CCBB),
                        letterSpacing: active ? 0.2 : 0,
                      ),
                      child: Text(_labels[i]),
                    ),
                    const SizedBox(height: 2),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 280),
                      width: active ? 18 : 0,
                      height: 3,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
