import 'package:flutter/material.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _dailyReminder = true;
  bool _weeklyReport = false;

  @override
  Widget build(BuildContext context) {
    final streak = MockData.currentStreak;
    final avg = MockData.averageMood;
    final avgEmoji = AppTheme.moodEmojis[avg.round().clamp(1, 5)] ?? '😐';

    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: AppTheme.primary,
          title: const Text('Profile'),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(gradient: AppTheme.heroGradient),
              child: SafeArea(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(height: 24),
                Container(
                  width: 76, height: 76,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 3)),
                  child: const Center(child: Text('🌿', style: TextStyle(fontSize: 38))),
                ),
                const SizedBox(height: 8),
                const Text('Alex Chen', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                const Text('Mindful Explorer', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ])),
            ),
          ),
        ),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(20), child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.softShadow),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                _Stat('🔥 $streak', 'Streak'),
                _Div(),
                _Stat('${MockData.moodEntries.length}', 'Logs'),
                _Div(),
                _Stat('$avgEmoji ${avg.toStringAsFixed(1)}', 'Avg Mood'),
              ]),
            ),
            const SizedBox(height: 24),
            const Text('Notifications', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.softShadow),
              child: Column(children: [
                ListTile(
                  leading: Icon(Icons.notifications_outlined, color: AppTheme.primary),
                  title: const Text('Daily Reminder', style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: const Text('Log your mood each day'),
                  trailing: Switch(value: _dailyReminder, onChanged: (v) => setState(() => _dailyReminder = v), activeColor: AppTheme.primary),
                ),
                Divider(height: 1, color: Colors.grey[100]),
                ListTile(
                  leading: Icon(Icons.bar_chart_outlined, color: AppTheme.secondary),
                  title: const Text('Weekly Report', style: TextStyle(fontWeight: FontWeight.w500)),
                  subtitle: const Text('Get your weekly mood summary'),
                  trailing: Switch(value: _weeklyReport, onChanged: (v) => setState(() => _weeklyReport = v), activeColor: AppTheme.secondary),
                ),
              ]),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.softShadow),
              child: Column(children: [
                _Item(Icons.book_outlined, 'Journal Entries', '${MockData.journalEntries.length} entries', () {}),
                Divider(height: 1, color: Colors.grey[100]),
                _Item(Icons.share_outlined, 'Share MoodLeaf', '', () {}),
                Divider(height: 1, color: Colors.grey[100]),
                _Item(Icons.help_outline, 'Help & Support', '', () {}),
                Divider(height: 1, color: Colors.grey[100]),
                _Item(Icons.info_outline, 'About', 'v1.0.0', () {}),
              ]),
            ),
            const SizedBox(height: 24),
            Center(child: Text('MoodLeaf v1.0.0  ·  Track your feelings, grow your mind', style: TextStyle(color: Colors.grey[400], fontSize: 12))),
            const SizedBox(height: 20),
          ],
        ))),
      ]),
    );
  }
}

class _Stat extends StatelessWidget {
  final String value, label;
  const _Stat(this.value, this.label);

  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: AppTheme.primary)),
    Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
  ]);
}

class _Div extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(width: 1, height: 36, color: Colors.grey[200]);
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String label, subtitle;
  final VoidCallback onTap;
  const _Item(this.icon, this.label, this.subtitle, this.onTap);

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    leading: Icon(icon, color: AppTheme.primary),
    title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
    trailing: const Icon(Icons.chevron_right, color: Colors.grey),
  );
}
