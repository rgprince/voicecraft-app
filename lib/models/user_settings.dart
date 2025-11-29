import 'package:hive/hive.dart';

part 'user_settings.g.dart';

@HiveType(typeId: 1)
class UserSettings extends HiveObject {
  @HiveField(0)
  bool isDarkMode;

  @HiveField(1)
  String language; // 'en' or 'hi'

  @HiveField(2)
  int dailyGoalMinutes;

  @HiveField(3)
  String notificationTime;

  @HiveField(4)
  DateTime? lastPracticeDate;

  @HiveField(5)
  int currentStreak;

  @HiveField(6)
  int longestStreak;

  UserSettings({
    this.isDarkMode = false,
    this.language = 'en',
    this.dailyGoalMinutes = 30,
    this.notificationTime = '09:00',
    this.lastPracticeDate,
    this.currentStreak = 0,
    this.longestStreak = 0,
  });
}
