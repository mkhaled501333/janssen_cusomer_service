// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prodcutinfo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductInfoAdapter extends TypeAdapter<ProductInfo> {
  @override
  final int typeId = 2;

  @override
  ProductInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductInfo(
      ID: fields[0] as int,
      ProdcutType: fields[1] as String,
      ProductName: fields[2] as String,
      L: fields[3] as int,
      W: fields[4] as int,
      H: fields[5] as int,
      Quantity: fields[6] as int,
      PurcheLocation: fields[7] as String,
      PurcheDate: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ProductInfo obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.ID)
      ..writeByte(1)
      ..write(obj.ProdcutType)
      ..writeByte(2)
      ..write(obj.ProductName)
      ..writeByte(3)
      ..write(obj.L)
      ..writeByte(4)
      ..write(obj.W)
      ..writeByte(5)
      ..write(obj.H)
      ..writeByte(6)
      ..write(obj.Quantity)
      ..writeByte(7)
      ..write(obj.PurcheLocation)
      ..writeByte(8)
      ..write(obj.PurcheDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
