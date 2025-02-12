// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:janssen_cusomer_service/models/callinfo.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';

part 'customer.g.dart';

@HiveType(typeId: 1)
class CustomerModel {
  @HiveField(0)
  int customer_ID;
  @HiveField(1)
  String cusotmerName;
  @HiveField(2)
  List<String> mobilenum;
  @HiveField(3)
  String covernorate;
  @HiveField(4)
  String area;
  @HiveField(5)
  String adress;
  @HiveField(6)
  String clientStatus;
  @HiveField(7)
  List<TicketModel> tickets;
  @HiveField(8)
  List<CallInfo> calls;
  @HiveField(9)
  int lastUpdated;
  CustomerModel({
    required this.customer_ID,
    required this.cusotmerName,
    required this.mobilenum,
    required this.covernorate,
    required this.area,
    required this.adress,
    required this.clientStatus,
    required this.tickets,
    required this.calls,
    required this.lastUpdated,
  });

  CustomerModel copyWith({
    int? customer_ID,
    String? cusotmerName,
    List<String>? mobilenum,
    String? covernorate,
    String? area,
    String? adress,
    String? clientStatus,
    List<TicketModel>? tickets,
    List<CallInfo>? calls,
    int? lastUpdated,
  }) {
    return CustomerModel(
      customer_ID: customer_ID ?? this.customer_ID,
      cusotmerName: cusotmerName ?? this.cusotmerName,
      mobilenum: mobilenum ?? this.mobilenum,
      covernorate: covernorate ?? this.covernorate,
      area: area ?? this.area,
      adress: adress ?? this.adress,
      clientStatus: clientStatus ?? this.clientStatus,
      tickets: tickets ?? this.tickets,
      calls: calls ?? this.calls,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customer_ID': customer_ID,
      'cusotmerName': cusotmerName,
      'mobilenum': mobilenum,
      'covernorate': covernorate,
      'area': area,
      'adress': adress,
      'clientStatus': clientStatus,
      'tickets': tickets.map((x) => x.toMap()).toList(),
      'calls': calls.map((x) => x.toMap()).toList(),
      'lastUpdated': lastUpdated,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      customer_ID: map['customer_ID'] as int,
      cusotmerName: map['cusotmerName'] as String,
      mobilenum: List<String>.from((map['mobilenum'] as List<dynamic>)),
      covernorate: map['covernorate'] as String,
      area: map['area'] as String,
      adress: map['adress'] as String,
      clientStatus: map['clientStatus'] as String,
      tickets: List<TicketModel>.from(
        (map['tickets'] as List<dynamic>).map<TicketModel>(
          (x) => TicketModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      calls: List<CallInfo>.from(
        (map['calls'] as List<dynamic>).map<CallInfo>(
          (x) => CallInfo.fromMap(x as Map<String, dynamic>),
        ),
      ),
      lastUpdated: map['lastUpdated'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerModel(customer_ID: $customer_ID, cusotmerName: $cusotmerName, mobilenum: $mobilenum, covernorate: $covernorate, area: $area, adress: $adress, clientStatus: $clientStatus, tickets: $tickets, calls: $calls, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(covariant CustomerModel other) {
    if (identical(this, other)) return true;

    return other.customer_ID == customer_ID &&
        other.cusotmerName == cusotmerName &&
        listEquals(other.mobilenum, mobilenum) &&
        other.covernorate == covernorate &&
        other.area == area &&
        other.adress == adress &&
        other.clientStatus == clientStatus &&
        listEquals(other.tickets, tickets) &&
        listEquals(other.calls, calls) &&
        other.lastUpdated == lastUpdated;
  }

  @override
  int get hashCode {
    return customer_ID.hashCode ^
        cusotmerName.hashCode ^
        mobilenum.hashCode ^
        covernorate.hashCode ^
        area.hashCode ^
        adress.hashCode ^
        clientStatus.hashCode ^
        tickets.hashCode ^
        calls.hashCode ^
        lastUpdated.hashCode;
  }
}
