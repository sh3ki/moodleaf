import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/mood_data.dart';
import '../theme/app_theme.dart';
import '../widgets/mood_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = MoodData.latestMood;
    final streak = MoodData.currentStreak;
    final avg = MoodData.averageMood;
    final avgColor = AppTheme.moodColors[(avg.round().clamp(1, 5))] ?? AppTheme.primary;
    final avgIcon = AppTheme.moodIcons[(avg.round().clamp(1, 5))] ?? Icons.sentiment_neutral_rounded;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 160,
            floating: false,
            pinned: true,
            backgroundColor: AppTheme.primary,
            title: const Text('MoodLeaf'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(DateFormat('MMM d').format(DateTime.now()), style: const TextStyle(color: Colors.white70)),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primary, AppTheme.secondary],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                alignment: Alignment.bottomLeft,
                child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('How are you doing?', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  Row(children: [
                    if (today != null) Icon(today.icon, color: Colors.white, size: 28),
                    const SizedBox(width: 8),
                    Text(today?.label ?? 'No entry yet', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                  ]),
                ]),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(padding: const EdgeInsets.all(20), child: Row(children: [
              _StatBox(Icons.local_fire_department_rounded, '$streak', 'Day Streak', AppTheme.accent),
              const SizedBox(width: 12),
              _StatBox(avgIcon, avg.toStringAsFixed(1), 'Avg Mood', avgColor),
              const SizedBox(width: 12),
              _StatBox(Icons.check_circle_rounded, '${MoodData.moodEntries.length}', 'Total Logs', AppTheme.secondary),
            ])),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Recent Entries', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
                Text('${MoodData.moodEntries.length} total', style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
              ]),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => MoodCard(entry: MoodData.moodEntries[i]),
              childCount: MoodData.moodEntries.take(8).length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final IconData icon;
  final String value, label;
  final Color color;
  const _StatBox(this.icon, this.value, this.label, this.color);

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [AppTheme.cardShadow]),
      child: Column(children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
        Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11)),
      ]),
    ),
  );
}
