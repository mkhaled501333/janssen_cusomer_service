// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'governomates.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class governomateAdapter extends TypeAdapter<governomate> {
  @override
  final int typeId = 9;

  @override
  governomate read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return governomate(
      id: fields[0] as int,
      governo: fields[1] as String,
      cityies: (fields[2] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, governomate obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.governo)
      ..writeByte(2)
      ..write(obj.cityies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is governomateAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
