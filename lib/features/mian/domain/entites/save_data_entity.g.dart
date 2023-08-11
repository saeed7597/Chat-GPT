// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_data_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveDataEntityAdapter extends TypeAdapter<SaveDataEntity> {
  @override
  final int typeId = 0;

  @override
  SaveDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveDataEntity(
      content: fields[0] as String,
      created: fields[1] as num,
      fromIs: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SaveDataEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.content)
      ..writeByte(1)
      ..write(obj.created)
      ..writeByte(2)
      ..write(obj.fromIs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
