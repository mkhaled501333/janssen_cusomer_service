// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketModelAdapter extends TypeAdapter<TicketModel> {
  @override
  final int typeId = 0;

  @override
  TicketModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketModel(
      ticket_ID: fields[0] as int,
      customer_ID: fields[11] as int,
      ticket_Num: fields[1] as int,
      Ticketresolved: fields[2] as bool,
      TicketType: fields[3] as String,
      requests: (fields[4] as List).cast<RequstesMolel>(),
      calls: (fields[5] as List).cast<CallInfo>(),
      datecreated: fields[6] as DateTime,
      colseReason: fields[7] as String,
      notes: fields[8] as String,
      others: fields[9] as String,
      actions: (fields[10] as List).cast<ActionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TicketModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.ticket_ID)
      ..writeByte(11)
      ..write(obj.customer_ID)
      ..writeByte(1)
      ..write(obj.ticket_Num)
      ..writeByte(2)
      ..write(obj.Ticketresolved)
      ..writeByte(3)
      ..write(obj.TicketType)
      ..writeByte(4)
      ..write(obj.requests)
      ..writeByte(5)
      ..write(obj.calls)
      ..writeByte(6)
      ..write(obj.datecreated)
      ..writeByte(7)
      ..write(obj.colseReason)
      ..writeByte(8)
      ..write(obj.notes)
      ..writeByte(9)
      ..write(obj.others)
      ..writeByte(10)
      ..write(obj.actions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
