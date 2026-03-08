class MoodEntry {
  final String id;
  final int mood; // 1–5
  final String? note;
  final List<String> tags;
  final DateTime timestamp;

  const MoodEntry({
    required this.id,
    required this.mood,
    this.note,
    this.tags = const [],
    required this.timestamp,
  });

  String get emoji {
    const map = {5: '😄', 4: '🙂', 3: '😐', 2: '😔', 1: '😢'};
    return map[mood] ?? '😐';
  }

  String get label {
    const map = {5: 'Great', 4: 'Good', 3: 'Okay', 2: 'Low', 1: 'Awful'};
    return map[mood] ?? 'Okay';
  }
}

class JournalEntry {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final DateTime timestamp;
  bool isPinned;

  JournalEntry({
    required this.id,
    required this.title,
    required this.content,
    this.tags = const [],
    required this.timestamp,
    this.isPinned = false,
  });
}

const List<String> kMoodTags = [
  'Work', 'Family', 'Health', 'Exercise', 'Sleep', 'Friends',
  'Travel', 'Food', 'Weather', 'Stress', 'Grateful', 'Calm',
];
