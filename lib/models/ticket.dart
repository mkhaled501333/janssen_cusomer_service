// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:janssen_cusomer_service/models/callinfo.dart';
import 'package:janssen_cusomer_service/models/models.dart';
import 'package:janssen_cusomer_service/models/request.dart';

part 'ticket.g.dart';

@HiveType(typeId: 0)
class TicketModel {
  @HiveField(0)
  int ticket_ID;
  @HiveField(11)
  int customer_ID;
  @HiveField(1)
  int ticket_Num;
  @HiveField(2)
  bool Ticketresolved;
  @HiveField(3)
  String TicketType;
  @HiveField(4)
  List<RequstesMolel> requests;
  @HiveField(5)
  List<CallInfo> calls;
  @HiveField(6)
  DateTime datecreated;
  @HiveField(7)
  String colseReason;
  @HiveField(8)
  String notes;
  @HiveField(9)
  String others;
  @HiveField(10)
  List<ActionModel> actions;
  TicketModel({
    required this.ticket_ID,
    required this.customer_ID,
    required this.ticket_Num,
    required this.Ticketresolved,
    required this.TicketType,
    required this.requests,
    required this.calls,
    required this.datecreated,
    required this.colseReason,
    required this.notes,
    required this.others,
    required this.actions,
  });

  TicketModel copyWith({
    int? ticket_ID,
    int? customer_ID,
    int? ticket_Num,
    bool? Ticketresolved,
    String? TicketType,
    List<RequstesMolel>? requests,
    List<CallInfo>? calls,
    DateTime? datecreated,
    String? colseReason,
    String? notes,
    String? others,
    List<ActionModel>? actions,
  }) {
    return TicketModel(
      ticket_ID: ticket_ID ?? this.ticket_ID,
      customer_ID: customer_ID ?? this.customer_ID,
      ticket_Num: ticket_Num ?? this.ticket_Num,
      Ticketresolved: Ticketresolved ?? this.Ticketresolved,
      TicketType: TicketType ?? this.TicketType,
      requests: requests ?? this.requests,
      calls: calls ?? this.calls,
      datecreated: datecreated ?? this.datecreated,
      colseReason: colseReason ?? this.colseReason,
      notes: notes ?? this.notes,
      others: others ?? this.others,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ticket_ID': ticket_ID,
      'customer_ID': customer_ID,
      'ticket_Num': ticket_Num,
      'Ticketresolved': Ticketresolved,
      'TicketType': TicketType,
      'requests': requests.map((x) => x.toMap()).toList(),
      'calls': calls.map((x) => x.toMap()).toList(),
      'datecreated': datecreated.millisecondsSinceEpoch,
      'colseReason': colseReason,
      'notes': notes,
      'others': others,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      ticket_ID: map['ticket_ID'] as int,
      customer_ID: map['customer_ID'] as int,
      ticket_Num: map['ticket_Num'] as int,
      Ticketresolved: map['Ticketresolved'] as bool,
      TicketType: map['TicketType'] as String,
      requests: List<RequstesMolel>.from(
        (map['requests'] as List<dynamic>).map<RequstesMolel>(
          (x) => RequstesMolel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      calls: List<CallInfo>.from(
        (map['calls'] as List<dynamic>).map<CallInfo>(
          (x) => CallInfo.fromMap(x as Map<String, dynamic>),
        ),
      ),
      datecreated:
          DateTime.fromMillisecondsSinceEpoch(map['datecreated'] as int),
      colseReason: map['colseReason'] as String,
      notes: map['notes'] as String,
      others: map['others'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TicketModel.fromJson(String source) =>
      TicketModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TicketModel(ticket_ID: $ticket_ID, customer_ID: $customer_ID, ticket_Num: $ticket_Num, Ticketresolved: $Ticketresolved, TicketType: $TicketType, requests: $requests, calls: $calls, datecreated: $datecreated, colseReason: $colseReason, notes: $notes, others: $others, actions: $actions)';
  }

  @override
  bool operator ==(covariant TicketModel other) {
    if (identical(this, other)) return true;

    return other.ticket_ID == ticket_ID &&
        other.customer_ID == customer_ID &&
        other.ticket_Num == ticket_Num &&
        other.Ticketresolved == Ticketresolved &&
        other.TicketType == TicketType &&
        listEquals(other.requests, requests) &&
        listEquals(other.calls, calls) &&
        other.datecreated == datecreated &&
        other.colseReason == colseReason &&
        other.notes == notes &&
        other.others == others &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return ticket_ID.hashCode ^
        customer_ID.hashCode ^
        ticket_Num.hashCode ^
        Ticketresolved.hashCode ^
        TicketType.hashCode ^
        requests.hashCode ^
        calls.hashCode ^
        datecreated.hashCode ^
        colseReason.hashCode ^
        notes.hashCode ^
        others.hashCode ^
        actions.hashCode;
  }
}
