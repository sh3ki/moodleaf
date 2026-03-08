import '../models/mood_model.dart';

class MockData {
  MockData._();

  static final DateTime _now = DateTime.now();

  static DateTime _daysAgo(int d, {int hour = 20, int minute = 0}) =>
      DateTime(_now.year, _now.month, _now.day - d, hour, minute);

  static final List<MoodEntry> moodEntries = [
    MoodEntry(id: 'm1',  mood: 5, note: 'Had a fantastic day! Finished a big project.', tags: ['Work', 'Grateful'], timestamp: _daysAgo(0, hour: 21)),
    MoodEntry(id: 'm2',  mood: 4, note: 'Good morning run, feeling energised.', tags: ['Exercise', 'Health'], timestamp: _daysAgo(0, hour: 8)),
    MoodEntry(id: 'm3',  mood: 4, note: 'Lunch with friends was lovely.', tags: ['Friends', 'Food'], timestamp: _daysAgo(1, hour: 14)),
    MoodEntry(id: 'm4',  mood: 3, note: 'Bit tired but okay overall.', tags: ['Sleep', 'Work'], timestamp: _daysAgo(1, hour: 9)),
    MoodEntry(id: 'm5',  mood: 5, note: 'Weekend hike — absolutely breathtaking views!', tags: ['Travel', 'Exercise'], timestamp: _daysAgo(2, hour: 17)),
    MoodEntry(id: 'm6',  mood: 4, note: 'Cozy day at home, read a book.', tags: ['Calm', 'Family'], timestamp: _daysAgo(3, hour: 15)),
    MoodEntry(id: 'm7',  mood: 2, note: 'Stressful meeting, feeling drained.', tags: ['Work', 'Stress'], timestamp: _daysAgo(4, hour: 18)),
    MoodEntry(id: 'm8',  mood: 3, note: 'Grocery run, nothing special.', tags: ['Food'], timestamp: _daysAgo(5, hour: 12)),
    MoodEntry(id: 'm9',  mood: 4, note: 'Great gym session.', tags: ['Exercise', 'Health'], timestamp: _daysAgo(6, hour: 7)),
    MoodEntry(id: 'm10', mood: 5, note: 'Family dinner was wonderful!', tags: ['Family', 'Food', 'Grateful'], timestamp: _daysAgo(7, hour: 20)),
    MoodEntry(id: 'm11', mood: 1, note: "Feeling really down, everything's off.", tags: ['Health', 'Sleep', 'Stress'], timestamp: _daysAgo(8, hour: 22)),
    MoodEntry(id: 'm12', mood: 3, note: 'Rainy day, quiet work from home.', tags: ['Weather', 'Work'], timestamp: _daysAgo(9, hour: 11)),
    MoodEntry(id: 'm13', mood: 4, note: 'Coffee date with a friend — great chat!', tags: ['Friends', 'Grateful'], timestamp: _daysAgo(10, hour: 15)),
    MoodEntry(id: 'm14', mood: 2, note: 'Poor sleep, feel groggy.', tags: ['Sleep'], timestamp: _daysAgo(11, hour: 8)),
    MoodEntry(id: 'm15', mood: 5, note: 'Promotion!!! Best day ever.', tags: ['Work', 'Grateful'], timestamp: _daysAgo(12, hour: 18)),
    MoodEntry(id: 'm16', mood: 3, note: 'Average day, nothing to note.', tags: ['Work'], timestamp: _daysAgo(13, hour: 20)),
    MoodEntry(id: 'm17', mood: 4, note: 'Yoga class was relaxing.', tags: ['Exercise', 'Calm', 'Health'], timestamp: _daysAgo(14, hour: 9)),
    MoodEntry(id: 'm18', mood: 3, note: 'Busy day, managed okay.', tags: ['Work', 'Stress'], timestamp: _daysAgo(15, hour: 19)),
    MoodEntry(id: 'm19', mood: 5, note: 'Sunny day, feeling amazing!', tags: ['Weather', 'Calm', 'Grateful'], timestamp: _daysAgo(16, hour: 13)),
    MoodEntry(id: 'm20', mood: 2, note: 'Headache all day.', tags: ['Health'], timestamp: _daysAgo(17, hour: 16)),
    MoodEntry(id: 'm21', mood: 4, note: 'Productive afternoon.', tags: ['Work'], timestamp: _daysAgo(18, hour: 17)),
    MoodEntry(id: 'm22', mood: 3, note: 'Just okay, a bit unmotivated.', tags: ['Stress'], timestamp: _daysAgo(19, hour: 20)),
    MoodEntry(id: 'm23', mood: 5, note: 'Concert night — amazing!', tags: ['Friends', 'Grateful'], timestamp: _daysAgo(20, hour: 23)),
    MoodEntry(id: 'm24', mood: 4, note: 'Good sleep, fresh start.', tags: ['Sleep', 'Health'], timestamp: _daysAgo(21, hour: 7)),
    MoodEntry(id: 'm25', mood: 2, note: 'Argument with a friend, feeling low.', tags: ['Friends', 'Stress'], timestamp: _daysAgo(22, hour: 21)),
    MoodEntry(id: 'm26', mood: 3, note: 'Steady day, nothing extreme.', tags: ['Work'], timestamp: _daysAgo(23, hour: 19)),
    MoodEntry(id: 'm27', mood: 5, note: 'Beach day! Perfect weather.', tags: ['Travel', 'Weather', 'Grateful'], timestamp: _daysAgo(24, hour: 15)),
    MoodEntry(id: 'm28', mood: 4, note: 'Nice home-cooked meal.', tags: ['Food', 'Family'], timestamp: _daysAgo(25, hour: 18)),
    MoodEntry(id: 'm29', mood: 3, note: 'Slightly overwhelmed with tasks.', tags: ['Work', 'Stress'], timestamp: _daysAgo(26, hour: 22)),
    MoodEntry(id: 'm30', mood: 4, note: 'Walked in the park, refreshing.', tags: ['Exercise', 'Weather'], timestamp: _daysAgo(27, hour: 10)),
  ];

  static final List<JournalEntry> journalEntries = [
    JournalEntry(id: 'j1', title: 'My Gratitude List', content: 'Today I\'m grateful for my health, my family, and the sunshine that brightened my afternoon walk.', tags: ['Grateful', 'Calm'], timestamp: _daysAgo(0, hour: 22), isPinned: true),
    JournalEntry(id: 'j2', title: 'Weekly Reflection', content: 'This week was intense at work but I managed to keep balanced. The promotion news was incredible — hard work pays off!', tags: ['Work', 'Grateful'], timestamp: _daysAgo(3, hour: 21)),
    JournalEntry(id: 'j3', title: 'What I\'m Learning', content: 'Started a new Flutter course. Building apps from scratch feels both challenging and rewarding. I love the creative process.', tags: ['Work', 'Exercise'], timestamp: _daysAgo(7, hour: 20)),
    JournalEntry(id: 'j4', title: 'Tough Day Thoughts', content: 'Feeling down today. Had a rough meeting and didn\'t get enough sleep. Need to prioritise rest this weekend.', tags: ['Stress', 'Health'], timestamp: _daysAgo(8, hour: 23)),
    JournalEntry(id: 'j5', title: 'Goals for Next Month', content: '1. Exercise 4x per week\n2. Read 2 books\n3. Cook more at home\n4. Connect with old friends', tags: ['Exercise', 'Food', 'Friends'], timestamp: _daysAgo(14, hour: 19), isPinned: true),
  ];

  static List<MoodEntry> get todayEntries {
    final today = DateTime.now();
    return moodEntries.where((e) =>
      e.timestamp.year == today.year &&
      e.timestamp.month == today.month &&
      e.timestamp.day == today.day).toList();
  }

  static MoodEntry? get latestMood => moodEntries.isNotEmpty ? moodEntries.first : null;

  static double get averageMood {
    if (moodEntries.isEmpty) return 3;
    return moodEntries.take(7).fold(0.0, (s, e) => s + e.mood) / moodEntries.take(7).length;
  }

  static int get currentStreak {
    if (moodEntries.isEmpty) return 0;
    int streak = 0;
    DateTime check = DateTime(_now.year, _now.month, _now.day);
    for (int i = 0; i < 60; i++) {
      final d = check.subtract(Duration(days: i));
      if (moodEntries.any((e) => e.timestamp.year == d.year && e.timestamp.month == d.month && e.timestamp.day == d.day)) {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  static List<MoodEntry> entriesForDay(DateTime day) =>
    moodEntries.where((e) => e.timestamp.year == day.year && e.timestamp.month == day.month && e.timestamp.day == day.day).toList();
}
