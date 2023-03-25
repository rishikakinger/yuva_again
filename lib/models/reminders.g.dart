// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminders.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RemindersAdapter extends TypeAdapter<Reminders> {
  @override
  final int typeId = 0;

  @override
  Reminders read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Reminders()
      ..name = fields[0] as String
      ..date = fields[1] as DateTime
      ..getNotified = fields[3] as bool
      ..category = fields[4] as String
      ..done = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, Reminders obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.getNotified)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.done);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RemindersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
