// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelUserAdapter extends TypeAdapter<ModelUser> {
  @override
  final int typeId = 0;

  @override
  ModelUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelUser(
      id: fields[0] as int?,
      email: fields[1] as String?,
      phoneNumber: fields[2] as String?,
      username: fields[3] as String?,
      password: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ModelUser obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.username)
      ..writeByte(4)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
