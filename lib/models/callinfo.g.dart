// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'callinfo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CallInfoAdapter extends TypeAdapter<CallInfo> {
  @override
  final int typeId = 3;

  @override
  CallInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CallInfo(
      callSerial: fields[0] as int,
      CallInfo_ID: fields[1] as int,
      customer_ID: fields[2] as int,
      Ticket_ID: fields[8] as int,
      callRecipient: fields[9] as String,
      callDate: fields[3] as DateTime,
      calltype: fields[4] as String,
      callReason: fields[5] as String,
      callReasonINdetails: fields[6] as String,
      callresult: fields[7] as String,
      notes: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CallInfo obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.callSerial)
      ..writeByte(1)
      ..write(obj.CallInfo_ID)
      ..writeByte(2)
      ..write(obj.customer_ID)
      ..writeByte(8)
      ..write(obj.Ticket_ID)
      ..writeByte(9)
      ..write(obj.callRecipient)
      ..writeByte(3)
      ..write(obj.callDate)
      ..writeByte(4)
      ..write(obj.calltype)
      ..writeByte(5)
      ..write(obj.callReason)
      ..writeByte(6)
      ..write(obj.callReasonINdetails)
      ..writeByte(7)
      ..write(obj.callresult)
      ..writeByte(10)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CallInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
