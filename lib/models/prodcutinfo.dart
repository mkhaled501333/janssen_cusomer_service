// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:hive/hive.dart';

part 'prodcutinfo.g.dart';

@HiveType(typeId: 2)
class ProductInfo {
  @HiveField(0)
  int ID;
  @HiveField(1)
  String ProdcutType;
  @HiveField(2)
  String ProductName;
  @HiveField(3)
  int L;
  @HiveField(4)
  int W;
  @HiveField(5)
  int H;
  @HiveField(6)
  int Quantity;
  @HiveField(7)
  String PurcheLocation;
  @HiveField(8)
  DateTime PurcheDate;
  ProductInfo({
    required this.ID,
    required this.ProdcutType,
    required this.ProductName,
    required this.L,
    required this.W,
    required this.H,
    required this.Quantity,
    required this.PurcheLocation,
    required this.PurcheDate,
  });

  ProductInfo copyWith({
    int? ID,
    String? ProdcutType,
    String? ProductName,
    int? L,
    int? W,
    int? H,
    int? Quantity,
    String? PurcheLocation,
    DateTime? PurcheDate,
  }) {
    return ProductInfo(
      ID: ID ?? this.ID,
      ProdcutType: ProdcutType ?? this.ProdcutType,
      ProductName: ProductName ?? this.ProductName,
      L: L ?? this.L,
      W: W ?? this.W,
      H: H ?? this.H,
      Quantity: Quantity ?? this.Quantity,
      PurcheLocation: PurcheLocation ?? this.PurcheLocation,
      PurcheDate: PurcheDate ?? this.PurcheDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': ID,
      'ProdcutType': ProdcutType,
      'ProductName': ProductName,
      'L': L,
      'W': W,
      'H': H,
      'Quantity': Quantity,
      'PurcheLocation': PurcheLocation,
      'PurcheDate': PurcheDate.millisecondsSinceEpoch,
    };
  }

  factory ProductInfo.fromMap(Map<String, dynamic> map) {
    return ProductInfo(
      ID: map['ID'] as int,
      ProdcutType: map['ProdcutType'] as String,
      ProductName: map['ProductName'] as String,
      L: map['L'] as int,
      W: map['W'] as int,
      H: map['H'] as int,
      Quantity: map['Quantity'] as int,
      PurcheLocation: map['PurcheLocation'] as String,
      PurcheDate: DateTime.fromMillisecondsSinceEpoch(map['PurcheDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductInfo.fromJson(String source) =>
      ProductInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductInfo(ID: $ID, ProdcutType: $ProdcutType, ProductName: $ProductName, L: $L, W: $W, H: $H, Quantity: $Quantity, PurcheLocation: $PurcheLocation, PurcheDate: $PurcheDate)';
  }

  @override
  bool operator ==(covariant ProductInfo other) {
    if (identical(this, other)) return true;

    return other.ID == ID &&
        other.ProdcutType == ProdcutType &&
        other.ProductName == ProductName &&
        other.L == L &&
        other.W == W &&
        other.H == H &&
        other.Quantity == Quantity &&
        other.PurcheLocation == PurcheLocation &&
        other.PurcheDate == PurcheDate;
  }

  @override
  int get hashCode {
    return ID.hashCode ^
        ProdcutType.hashCode ^
        ProductName.hashCode ^
        L.hashCode ^
        W.hashCode ^
        H.hashCode ^
        Quantity.hashCode ^
        PurcheLocation.hashCode ^
        PurcheDate.hashCode;
  }
}
