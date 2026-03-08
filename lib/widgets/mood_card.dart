import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/mood_model.dart';
import '../theme/app_theme.dart';

class MoodCard extends StatelessWidget {
  final MoodEntry entry;
  final VoidCallback? onTap;
  const MoodCard({super.key, required this.entry, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.moodColors[entry.mood] ?? AppTheme.primary;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppTheme.softShadow,
          border: Border(left: BorderSide(color: color, width: 4)),
        ),
        child: Row(children: [
          Text(entry.emoji, style: const TextStyle(fontSize: 36)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(entry.label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: color)),
              const Spacer(),
              Text(DateFormat('hh:mm a').format(entry.timestamp), style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
            if (entry.note != null) ...[
              const SizedBox(height: 4),
              Text(entry.note!, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black87, fontSize: 13)),
            ],
            if (entry.tags.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(spacing: 6, children: entry.tags.map((t) => _Tag(t)).toList()),
            ],
          ])),
        ]),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag(this.label);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: AppTheme.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
    child: Text(label, style: TextStyle(fontSize: 11, color: AppTheme.primary, fontWeight: FontWeight.w600)),
  );
}

class MoodBubble extends StatelessWidget {
  final int mood;
  final bool selected;
  final VoidCallback onTap;
  const MoodBubble({super.key, required this.mood, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.moodColors[mood] ?? AppTheme.primary;
    final emoji = AppTheme.moodEmojis[mood] ?? '😐';
    final label = AppTheme.moodLabels[mood] ?? 'Okay';
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? color : Colors.grey.shade200, width: 2),
          boxShadow: selected ? AppTheme.cardShadow : [],
        ),
        child: Column(children: [
          Text(emoji, style: const TextStyle(fontSize: 32)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: selected ? Colors.white : Colors.black87)),
        ]),
      ),
    );
  }
}
