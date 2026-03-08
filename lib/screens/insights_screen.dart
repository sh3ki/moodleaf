import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = MockData.moodEntries.take(14).toList().reversed.toList();
    final spots = entries.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value.mood.toDouble())).toList();

    // Tag frequency
    final tagMap = <String, int>{};
    for (final e in MockData.moodEntries) {
      for (final t in e.tags) tagMap[t] = (tagMap[t] ?? 0) + 1;
    }
    final topTags = tagMap.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    // Mood distribution
    final dist = <int, int>{1: 0, 2: 0, 3: 0, 4: 0, 5: 0};
    for (final e in MockData.moodEntries) dist[e.mood] = (dist[e.mood] ?? 0) + 1;

    return Scaffold(
      backgroundColor: AppTheme.surface,
      appBar: AppBar(title: const Text('Insights')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        _SectionTitle('Mood Trend — Last 14 Days'),
        const SizedBox(height: 8),
        Container(
          height: 200,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.softShadow),
          child: LineChart(LineChartData(
            minY: 1, maxY: 5,
            gridData: FlGridData(show: true, horizontalInterval: 1, drawVerticalLine: false, getDrawingHorizontalLine: (v) => FlLine(color: Colors.grey.shade100, strokeWidth: 1)),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 24, getTitlesWidget: (v, _) => Text(AppTheme.moodEmojis[v.toInt()] ?? '', style: const TextStyle(fontSize: 12)))),
              bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            lineBarsData: [LineChartBarData(
              spots: spots,
              isCurved: true,
              color: AppTheme.primary,
              barWidth: 3,
              belowBarData: BarAreaData(show: true, color: AppTheme.primary.withOpacity(0.1)),
              dotData: FlDotData(show: true, getDotPainter: (s, _, __, ___) => FlDotCirclePainter(radius: 4, color: AppTheme.moodColors[s.y.toInt()] ?? AppTheme.primary, strokeWidth: 2, strokeColor: Colors.white)),
            )],
          )),
        ),
        const SizedBox(height: 24),
        _SectionTitle('Mood Distribution'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.softShadow),
          child: Column(children: [5, 4, 3, 2, 1].map((m) {
            final count = dist[m] ?? 0;
            final total = MockData.moodEntries.length;
            final pct = total > 0 ? count / total : 0.0;
            final color = AppTheme.moodColors[m] ?? AppTheme.primary;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(children: [
                Text(AppTheme.moodEmojis[m] ?? '😐', style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                SizedBox(width: 48, child: Text(AppTheme.moodLabels[m] ?? '', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13))),
                Expanded(child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(value: pct, minHeight: 14, color: color, backgroundColor: color.withOpacity(0.15)),
                )),
                const SizedBox(width: 8),
                SizedBox(width: 28, child: Text('$count', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13), textAlign: TextAlign.end)),
              ]),
            );
          }).toList()),
        ),
        const SizedBox(height: 24),
        _SectionTitle('Top Activity Tags'),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: AppTheme.softShadow),
          child: Wrap(spacing: 10, runSpacing: 10, children: topTags.take(8).map((entry) => Chip(
            label: Text('${entry.key}  ${entry.value}', style: const TextStyle(fontWeight: FontWeight.w600)),
            backgroundColor: AppTheme.primary.withOpacity(0.1),
            labelStyle: TextStyle(color: AppTheme.primary),
          )).toList()),
        ),
        const SizedBox(height: 20),
      ]),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) => Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700));
}
