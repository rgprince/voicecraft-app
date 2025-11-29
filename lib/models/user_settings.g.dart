// GENERATED CODE - DO NOT MODIFY BY HAND  
// This is a manual stub - in production this would be auto-generated

part of 'user_settings.dart';

// Hive TypeAdapter stub
class UserSettingsAdapter extends TypeAdapter<UserSettings> {
  @override
  final int typeId = 1;

  @override
  UserSettings read(BinaryReader reader) {
    return UserSettings(
      isDarkMode: reader.readBool(),
      language: reader.readString(),
      dailyGoalMinutes: reader.readInt(),
      notificationTime: reader.readString(),
      lastPracticeDate: reader.readInt() > 0
          ? DateTime.fromMillisecondsSinceEpoch(reader.readInt())
          : null,
      currentStreak: reader.readInt(),
      longestStreak: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, UserSettings obj) {
    writer.writeBool(obj.isDarkMode);
    writer.writeString(obj.language);
    writer.writeInt(obj.dailyGoalMinutes);
    writer.writeString(obj.notificationTime);
    writer.writeInt(obj.lastPracticeDate?.millisecondsSinceEpoch ?? 0);
    writer.writeInt(obj.currentStreak);
    writer.writeInt(obj.longestStreak);
  }
}
