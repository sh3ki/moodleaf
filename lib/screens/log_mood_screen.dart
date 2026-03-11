import 'package:flutter/material.dart';
import '../models/mood_model.dart';
import '../theme/app_theme.dart';
import '../widgets/mood_card.dart';

class LogMoodScreen extends StatefulWidget {
  const LogMoodScreen({super.key});

  @override
  State<LogMoodScreen> createState() => _LogMoodScreenState();
}

class _LogMoodScreenState extends State<LogMoodScreen> {
  int? _selectedMood;
  final Set<String> _selectedTags = {};
  final TextEditingController _noteCtrl = TextEditingController();
  bool _logged = false;

  @override
  void dispose() { _noteCtrl.dispose(); super.dispose(); }

  void _submit() {
    if (_selectedMood == null) return;
    setState(() => _logged = true);
    final label = AppTheme.moodLabels[_selectedMood!] ?? 'Okay';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mood logged: $label'), backgroundColor: AppTheme.primary, behavior: SnackBarBehavior.floating),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() { _logged = false; _selectedMood = null; _selectedTags.clear(); _noteCtrl.clear(); });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(title: const Text('Log Your Mood')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('How are you feeling right now?', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppTheme.textPrimary)),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [5, 4, 3, 2, 1].map((m) => Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: MoodBubble(mood: m, selected: _selectedMood == m, onTap: () => setState(() => _selectedMood = m)),
            ),
          )).toList()),
          const SizedBox(height: 24),
          const Text('What\'s on your mind?', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
          const SizedBox(height: 10),
          TextField(
            controller: _noteCtrl,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Write a note (optional)...',
              hintStyle: const TextStyle(color: AppTheme.textSecondary),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Add Tags', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppTheme.textPrimary)),
          const SizedBox(height: 10),
          Wrap(spacing: 8, runSpacing: 8, children: kMoodTags.map((tag) {
            final sel = _selectedTags.contains(tag);
            return GestureDetector(
              onTap: () => setState(() => sel ? _selectedTags.remove(tag) : _selectedTags.add(tag)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: sel ? AppTheme.secondary : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: sel ? AppTheme.secondary : AppTheme.divider),
                ),
                child: Text(tag, style: TextStyle(color: sel ? Colors.white : AppTheme.textPrimary, fontWeight: FontWeight.w600, fontSize: 13)),
              ),
            );
          }).toList()),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _selectedMood == null ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: Text(_logged ? 'Logged!' : 'Save Mood', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
