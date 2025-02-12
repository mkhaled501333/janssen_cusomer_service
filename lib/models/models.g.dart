// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ActionModelAdapter extends TypeAdapter<ActionModel> {
  @override
  final int typeId = 5;

  @override
  ActionModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ActionModel(
      action: fields[0] as String,
      who: fields[1] as String,
      when: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ActionModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.action)
      ..writeByte(1)
      ..write(obj.who)
      ..writeByte(2)
      ..write(obj.when);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActionModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProdcutsModelAdapter extends TypeAdapter<ProdcutsModel> {
  @override
  final int typeId = 6;

  @override
  ProdcutsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProdcutsModel(
      id: fields[0] as int,
      companyName: fields[1] as String,
      prodcuts: (fields[2] as List).cast<String>(),
      actions: (fields[3] as List).cast<ActionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProdcutsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.companyName)
      ..writeByte(2)
      ..write(obj.prodcuts)
      ..writeByte(3)
      ..write(obj.actions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProdcutsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CallTypeModelAdapter extends TypeAdapter<CallTypeModel> {
  @override
  final int typeId = 7;

  @override
  CallTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CallTypeModel(
      id: fields[0] as int,
      callType: fields[1] as String,
      actions: (fields[2] as List).cast<ActionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, CallTypeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.callType)
      ..writeByte(2)
      ..write(obj.actions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReqReasonsAdapter extends TypeAdapter<ReqReasons> {
  @override
  final int typeId = 8;

  @override
  ReqReasons read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ReqReasons(
      id: fields[0] as int,
      Reqreason: fields[1] as String,
      actions: (fields[2] as List).cast<ActionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ReqReasons obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.Reqreason)
      ..writeByte(2)
      ..write(obj.actions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReqReasonsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
