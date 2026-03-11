import 'package:flutter/material.dart';
import '../data/mood_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_logo.dart';

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
    final streak = MoodData.currentStreak;
    final avg = MoodData.averageMood;
    final avgIcon = AppTheme.moodIcons[avg.round().clamp(1, 5)] ?? Icons.sentiment_neutral_rounded;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 210,
          pinned: true,
          backgroundColor: AppTheme.primary,
          title: const Text('Profile'),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppTheme.primary, AppTheme.secondary],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SafeArea(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const SizedBox(height: 24),
                Container(
                  width: 82, height: 82,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 4))],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.network(
                    'https://randomuser.me/api/portraits/men/32.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.white24,
                      child: const Icon(Icons.person_rounded, color: Colors.white, size: 42),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text('Alex Chen', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
                const Text('Mindful Explorer', style: TextStyle(color: Colors.white70, fontSize: 13)),
              ])),
            ),
          ),
        ),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [AppTheme.cardShadow]),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              _Stat(Icons.local_fire_department_rounded, '$streak', 'Streak', AppTheme.accent),
              Container(width: 1, height: 36, color: AppTheme.divider),
              _Stat(Icons.check_circle_rounded, '${MoodData.moodEntries.length}', 'Logs', AppTheme.secondary),
              Container(width: 1, height: 36, color: AppTheme.divider),
              _Stat(avgIcon, avg.toStringAsFixed(1), 'Avg Mood', AppTheme.primary),
            ]),
          ),
          const SizedBox(height: 24),
          const Text('Notifications', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [AppTheme.cardShadow]),
            child: Column(children: [
              ListTile(
                leading: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.notifications_rounded, color: AppTheme.primary, size: 18),
                ),
                title: const Text('Daily Reminder', style: TextStyle(fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
                subtitle: const Text('Log your mood each day', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                trailing: Switch(value: _dailyReminder, onChanged: (v) => setState(() => _dailyReminder = v), activeColor: AppTheme.primary),
              ),
              Divider(height: 1, color: AppTheme.divider),
              ListTile(
                leading: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppTheme.secondary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: const Icon(Icons.bar_chart_rounded, color: AppTheme.secondary, size: 18),
                ),
                title: const Text('Weekly Report', style: TextStyle(fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
                subtitle: const Text('Get your weekly mood summary', style: TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
                trailing: Switch(value: _weeklyReport, onChanged: (v) => setState(() => _weeklyReport = v), activeColor: AppTheme.secondary),
              ),
            ]),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [AppTheme.cardShadow]),
            child: Column(children: [
              _Item(Icons.book_rounded, 'Journal Entries', '${MoodData.journalEntries.length} entries', () {}),
              const Divider(height: 1, color: AppTheme.divider),
              _Item(Icons.share_rounded, 'Share MoodLeaf', '', () {}),
              const Divider(height: 1, color: AppTheme.divider),
              _Item(Icons.help_outline_rounded, 'Help & Support', '', () {}),
              const Divider(height: 1, color: AppTheme.divider),
              _Item(Icons.info_outline_rounded, 'About', 'v1.0.0', () {}),
            ]),
          ),
          const SizedBox(height: 32),
          Center(child: Column(children: [
            const AppLogo(size: 32),
            const SizedBox(height: 8),
            Text('Track your feelings, grow your mind', style: TextStyle(color: AppTheme.textSecondary.withOpacity(0.6), fontSize: 12)),
          ])),
          const SizedBox(height: 20),
        ]))),
      ]),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value, label;
  final Color color;
  const _Stat(this.icon, this.value, this.label, this.color);

  @override
  Widget build(BuildContext context) => Column(children: [
    Icon(icon, color: color, size: 18),
    const SizedBox(height: 2),
    Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: color)),
    Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)),
  ]);
}

class _Item extends StatelessWidget {
  final IconData icon;
  final String label, subtitle;
  final VoidCallback onTap;
  const _Item(this.icon, this.label, this.subtitle, this.onTap);

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    leading: Container(
      width: 36, height: 36,
      decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
      child: Icon(icon, color: AppTheme.primary, size: 18),
    ),
    title: Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: AppTheme.textPrimary)),
    subtitle: subtitle.isNotEmpty ? Text(subtitle, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12)) : null,
    trailing: const Icon(Icons.chevron_right, color: AppTheme.textSecondary),
  );
}
