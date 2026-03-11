import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/mood_data.dart';
import '../theme/app_theme.dart';
import '../widgets/mood_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final entries = MoodData.entriesForDay(_focusedDay);
    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(title: const Text('History')),
      body: Column(children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              IconButton(onPressed: () => setState(() => _focusedDay = DateTime(_focusedDay.year, _focusedDay.month - 1)), icon: const Icon(Icons.chevron_left)),
              Text(DateFormat('MMMM yyyy').format(_focusedDay), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: AppTheme.textPrimary)),
              IconButton(onPressed: () => setState(() => _focusedDay = DateTime(_focusedDay.year, _focusedDay.month + 1)), icon: const Icon(Icons.chevron_right)),
            ]),
            const SizedBox(height: 8),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children:
              ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((d) => SizedBox(width: 36, child: Center(child: Text(d, style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.textSecondary, fontSize: 12))))).toList()),
            const SizedBox(height: 4),
            _buildCalendarGrid(),
          ]),
        ),
        const Divider(height: 1, color: AppTheme.divider),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
          child: Row(children: [
            Text(DateFormat('MMMM d, yyyy').format(_focusedDay), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: AppTheme.textPrimary)),
            const Spacer(),
            Text('${entries.length} entr${entries.length == 1 ? 'y' : 'ies'}', style: const TextStyle(color: AppTheme.textSecondary)),
          ]),
        ),
        Expanded(
          child: entries.isEmpty
            ? Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.eco_rounded, size: 48, color: AppTheme.primary.withOpacity(0.4)),
                const SizedBox(height: 12),
                const Text('No entries for this day', style: TextStyle(color: AppTheme.textSecondary)),
              ]))
            : ListView.builder(itemCount: entries.length, itemBuilder: (_, i) => MoodCard(entry: entries[i])),
        ),
      ]),
    );
  }

  Widget _buildCalendarGrid() {
    final first = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final daysInMonth = DateUtils.getDaysInMonth(_focusedDay.year, _focusedDay.month);
    final startWeekday = first.weekday % 7;
    final cells = <Widget>[];
    for (int i = 0; i < startWeekday; i++) cells.add(const SizedBox(width: 36, height: 36));
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(_focusedDay.year, _focusedDay.month, day);
      final dayEntries = MoodData.entriesForDay(date);
      final isToday = DateUtils.isSameDay(date, DateTime.now());
      final isSelected = DateUtils.isSameDay(date, _focusedDay);
      Color? bg;
      if (dayEntries.isNotEmpty) {
        final avg = dayEntries.fold(0, (s, e) => s + e.mood) ~/ dayEntries.length;
        bg = (AppTheme.moodColors[avg] ?? AppTheme.primary).withOpacity(0.3);
      }
      cells.add(GestureDetector(
        onTap: () => setState(() => _focusedDay = date),
        child: Container(
          width: 36, height: 36,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primary : bg,
            shape: BoxShape.circle,
            border: isToday ? Border.all(color: AppTheme.primary, width: 2) : null,
          ),
          child: Center(child: Text('$day', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isSelected ? Colors.white : AppTheme.textPrimary))),
        ),
      ));
    }
    final rows = <Widget>[];
    for (int i = 0; i < cells.length; i += 7) {
      rows.add(Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: cells.skip(i).take(7).toList()));
    }
    return Column(children: rows);
  }
}
