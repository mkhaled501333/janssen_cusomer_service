// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerModelAdapter extends TypeAdapter<CustomerModel> {
  @override
  final int typeId = 1;

  @override
  CustomerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerModel(
      customer_ID: fields[0] as int,
      cusotmerName: fields[1] as String,
      mobilenum: (fields[2] as List).cast<String>(),
      covernorate: fields[3] as String,
      area: fields[4] as String,
      adress: fields[5] as String,
      clientStatus: fields[6] as String,
      tickets: (fields[7] as List).cast<TicketModel>(),
      calls: (fields[8] as List).cast<CallInfo>(),
      lastUpdated: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CustomerModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.customer_ID)
      ..writeByte(1)
      ..write(obj.cusotmerName)
      ..writeByte(2)
      ..write(obj.mobilenum)
      ..writeByte(3)
      ..write(obj.covernorate)
      ..writeByte(4)
      ..write(obj.area)
      ..writeByte(5)
      ..write(obj.adress)
      ..writeByte(6)
      ..write(obj.clientStatus)
      ..writeByte(7)
      ..write(obj.tickets)
      ..writeByte(8)
      ..write(obj.calls)
      ..writeByte(9)
      ..write(obj.lastUpdated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
