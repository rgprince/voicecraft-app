// GENERATED CODE - DO NOT MODIFY BY HAND
// This is a manual stub - in production this would be auto-generated

part of 'practice_record.dart';

// Hive TypeAdapter stub
class PracticeRecordAdapter extends TypeAdapter<PracticeRecord> {
  @override
  final int typeId = 0;

  @override
  PracticeRecord read(BinaryReader reader) {
    return PracticeRecord(
      id: reader.readString(),
      date: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      exerciseType: reader.readString(),
      exerciseName: reader.readString(),
      durationMinutes: reader.readInt(),
      completed: reader.readBool(),
      notes: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, PracticeRecord obj) {
    writer.writeString(obj.id);
    writer.writeInt(obj.date.millisecondsSinceEpoch);
    writer.writeString(obj.exerciseType);
    writer.writeString(obj.exerciseName);
    writer.writeInt(obj.durationMinutes);
    writer.writeBool(obj.completed);
    writer.writeString(obj.notes ?? '');
  }
}
