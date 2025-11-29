import 'package:hive/hive.dart';

part 'practice_record.g.dart';

@HiveType(typeId: 0)
class PracticeRecord extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String exerciseType; // 'morning', 'evening', 'song', 'misc'

  @HiveField(3)
  String exerciseName;

  @HiveField(4)
  int durationMinutes;

  @HiveField(5)
  bool completed;

  @HiveField(6)
  String? notes;

  PracticeRecord({
    required this.id,
    required this.date,
    required this.exerciseType,
    required this.exerciseName,
    required this.durationMinutes,
    this.completed = false,
    this.notes,
  });

  // Helper to check if this is today's record
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}
