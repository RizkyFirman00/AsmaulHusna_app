// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_bookmark.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelBookmarkAdapter extends TypeAdapter<ModelBookmark> {
  @override
  final int typeId = 1;

  @override
  ModelBookmark read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelBookmark(
      id: fields[0] as int?,
      number: fields[1] as int?,
      name: fields[2] as String?,
      transliteration: fields[3] as String?,
      meaning: fields[4] as String?,
      flag: fields[5] as String?,
      keterangan: fields[6] as String?,
      amalan: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelBookmark obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.number)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.transliteration)
      ..writeByte(4)
      ..write(obj.meaning)
      ..writeByte(5)
      ..write(obj.flag)
      ..writeByte(6)
      ..write(obj.keterangan)
      ..writeByte(7)
      ..write(obj.amalan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelBookmarkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
