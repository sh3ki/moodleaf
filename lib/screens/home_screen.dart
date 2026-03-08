import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/mood_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final today = MockData.latestMood;
    final streak = MockData.currentStreak;
    final avg = MockData.averageMood;
    final avgColor = AppTheme.moodColors[(avg.round().clamp(1, 5))] ?? AppTheme.primary;

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
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(gradient: AppTheme.heroGradient),
                padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
                alignment: Alignment.bottomLeft,
                child: Column(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text('How are you doing?', style: TextStyle(color: Colors.white70, fontSize: 13)),
                  Row(children: [
                    Text(today?.emoji ?? '😐', style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 8),
                    Text(today?.label ?? 'No entry yet', style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w800)),
                  ]),
                ]),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(padding: const EdgeInsets.all(20), child: Row(children: [
              _StatBox('🔥 $streak', 'Day Streak'),
              const SizedBox(width: 12),
              _StatBox('${avg.toStringAsFixed(1)} ${AppTheme.moodEmojis[avg.round().clamp(1, 5)]!}', 'Avg Mood', color: avgColor),
              const SizedBox(width: 12),
              _StatBox('${MockData.moodEntries.length}', 'Total Logs'),
            ])),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('Recent Entries', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
                Text('${MockData.moodEntries.length} total', style: TextStyle(color: Colors.grey[500], fontSize: 13)),
              ]),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, i) => MoodCard(entry: MockData.moodEntries[i]),
              childCount: MockData.moodEntries.take(8).length,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value, label;
  final Color? color;
  const _StatBox(this.value, this.label, {this.color});

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: AppTheme.softShadow),
      child: Column(children: [
        Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: color ?? AppTheme.primary)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11)),
      ]),
    ),
  );
}
