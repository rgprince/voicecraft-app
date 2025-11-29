import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/practice_record.dart';
import '../models/user_settings.dart';

// Practice records provider
final practiceBoxProvider = Provider<Box<PracticeRecord>>((ref) {
  return Hive.box<PracticeRecord>('practice_records');
});

// Settings provider
final settingsBoxProvider = Provider<Box<UserSettings>>((ref) {
  return Hive.box<UserSettings>('user_settings');
});

// Current user settings
final userSettingsProvider = StateNotifierProvider<UserSettingsNotifier, UserSettings>((ref) {
  final box = ref.watch(settingsBoxProvider);
  return UserSettingsNotifier(box);
});

class UserSettingsNotifier extends StateNotifier<UserSettings> {
  final Box<UserSettings> _box;

  UserSettingsNotifier(this._box)
      : super(_box.get('settings') ?? UserSettings()) {
    _initSettings();
  }

  void _initSettings() {
    if (_box.get('settings') == null) {
      _box.put('settings', state);
    }
  }

  void updateStreak() {
    final now = DateTime.now();
    final lastDate = state.lastPracticeDate;

    if (lastDate == null) {
      // First practice ever
      state = UserSettings(
        isDarkMode: state.isDarkMode,
        language: state.language,
        dailyGoalMinutes: state.dailyGoalMinutes,
        notificationTime: state.notificationTime,
        lastPracticeDate: now,
        currentStreak: 1,
        longestStreak: 1,
      );
    } else {
      final daysDiff = now.difference(lastDate).inDays;

      if (daysDiff == 0) {
        // Same day, no change
        return;
      } else if (daysDiff == 1) {
        // Consecutive day
        final newStreak = state.currentStreak + 1;
        state = UserSettings(
          isDarkMode: state.isDarkMode,
          language: state.language,
          dailyGoalMinutes: state.dailyGoalMinutes,
          notificationTime: state.notificationTime,
          lastPracticeDate: now,
          currentStreak: newStreak,
          longestStreak: newStreak > state.longestStreak ? newStreak : state.longestStreak,
        );
      } else {
        // Streak broken
        state = UserSettings(
          isDarkMode: state.isDarkMode,
          language: state.language,
          dailyGoalMinutes: state.dailyGoalMinutes,
          notificationTime: state.notificationTime,
          lastPracticeDate: now,
          currentStreak: 1,
          longestStreak: state.longestStreak,
        );
      }
    }

    _box.put('settings', state);
  }

  void toggleDarkMode() {
    state = UserSettings(
      isDarkMode: !state.isDarkMode,
      language: state.language,
      dailyGoalMinutes: state.dailyGoalMinutes,
      notificationTime: state.notificationTime,
      lastPracticeDate: state.lastPracticeDate,
      currentStreak: state.currentStreak,
      longestStreak: state.longestStreak,
    );
    _box.put('settings', state);
  }
}

// Today's practice records
final todayPracticeProvider = Provider<List<PracticeRecord>>((ref) {
  final box = ref.watch(practiceBoxProvider);
  final now = DateTime.now();
  
  return box.values.where((record) {
    return record.date.year == now.year &&
        record.date.month == now.month &&
        record.date.day == now.day;
  }).toList();
});

// Total practice minutes today
final todayMinutesProvider = Provider<int>((ref) {
  final todayRecords = ref.watch(todayPracticeProvider);
  return todayRecords.where((r) => r.completed).fold(0, (sum, record) => sum + record.durationMinutes);
});

// Completion percentage today
final todayCompletionProvider = Provider<double>((ref) {
  final todayMinutes = ref.watch(todayMinutesProvider);
  final settings = ref.watch(userSettingsProvider);
  final goal = settings.dailyGoalMinutes;
  
  if (goal == 0) return 0.0;
  return (todayMinutes / goal).clamp(0.0, 1.0);
});

// This week's practice days
final weekPracticeProvider = Provider<List<int>>((ref) {
  final box = ref.watch(practiceBoxProvider);
  final now = DateTime.now();
  final weekStart = now.subtract(Duration(days: now.weekday - 1));
  
  List<int> minutesPerDay = List.filled(7, 0);
  
  for (var record in box.values) {
    if (!record.completed) continue;
    
    final daysDiff = record.date.difference(weekStart).inDays;
    if (daysDiff >= 0 && daysDiff < 7) {
      minutesPerDay[daysDiff] += record.durationMinutes;
    }
  }
  
  return minutesPerDay;
});
