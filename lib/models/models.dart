// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, constant_identifier_names
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
part 'models.g.dart';

@HiveType(typeId: 5)
class ActionModel {
  @HiveField(0)
  String action;
  @HiveField(1)
  String who;
  @HiveField(2)
  DateTime when;
  ActionModel({
    required this.action,
    required this.who,
    required this.when,
  });

  ActionModel copyWith({
    String? action,
    String? who,
    DateTime? when,
  }) {
    return ActionModel(
      action: action ?? this.action,
      who: who ?? this.who,
      when: when ?? this.when,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'action': action,
      'who': who,
      'when': when.millisecondsSinceEpoch,
    };
  }

  factory ActionModel.fromMap(Map<String, dynamic> map) {
    return ActionModel(
      action: map['action'] as String,
      who: map['who'] as String,
      when: DateTime.fromMillisecondsSinceEpoch(map['when'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionModel.fromJson(String source) =>
      ActionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ActionModel(action: $action, who: $who, when: $when)';

  @override
  bool operator ==(covariant ActionModel other) {
    if (identical(this, other)) return true;

    return other.action == action && other.who == who && other.when == when;
  }

  @override
  int get hashCode => action.hashCode ^ who.hashCode ^ when.hashCode;
}

@HiveType(typeId: 6)
class ProdcutsModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String companyName;
  @HiveField(2)
  List<String> prodcuts;
  @HiveField(3)
  List<ActionModel> actions;
  ProdcutsModel({
    required this.id,
    required this.companyName,
    required this.prodcuts,
    required this.actions,
  });

  ProdcutsModel copyWith({
    int? id,
    String? companyName,
    List<String>? prodcuts,
    List<ActionModel>? actions,
  }) {
    return ProdcutsModel(
      id: id ?? this.id,
      companyName: companyName ?? this.companyName,
      prodcuts: prodcuts ?? this.prodcuts,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'companyName': companyName,
      'prodcuts': prodcuts,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory ProdcutsModel.fromMap(Map<String, dynamic> map) {
    return ProdcutsModel(
      id: map['id'] as int,
      companyName: map['companyName'] as String,
      prodcuts: List<String>.from((map['prodcuts'] as List<dynamic>)),
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdcutsModel.fromJson(String source) =>
      ProdcutsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProdcutsModel(id: $id, companyName: $companyName, prodcuts: $prodcuts, actions: $actions)';
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyName.hashCode ^
        prodcuts.hashCode ^
        actions.hashCode;
  }
}

@HiveType(typeId: 7)
class CallTypeModel {
  @HiveField(0)
  int id;
  @HiveField(1)
  String callType;
  @HiveField(2)
  List<ActionModel> actions;
  CallTypeModel({
    required this.id,
    required this.callType,
    required this.actions,
  });

  CallTypeModel copyWith({
    int? id,
    String? callType,
    List<ActionModel>? actions,
  }) {
    return CallTypeModel(
      id: id ?? this.id,
      callType: callType ?? this.callType,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'callType': callType,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory CallTypeModel.fromMap(Map<String, dynamic> map) {
    return CallTypeModel(
      id: map['id'] as int,
      callType: map['callType'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CallTypeModel.fromJson(String source) =>
      CallTypeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CallTypeModel(id: $id, callType: $callType, actions: $actions)';

  @override
  int get hashCode => id.hashCode ^ callType.hashCode ^ actions.hashCode;
}

@HiveType(typeId: 8)
class ReqReasons {
  @HiveField(0)
  int id;
  @HiveField(1)
  String Reqreason;
  @HiveField(2)
  List<ActionModel> actions;
  ReqReasons({
    required this.id,
    required this.Reqreason,
    required this.actions,
  });

  ReqReasons copyWith({
    int? id,
    String? Reqreason,
    List<ActionModel>? actions,
  }) {
    return ReqReasons(
      id: id ?? this.id,
      Reqreason: Reqreason ?? this.Reqreason,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'Reqreason': Reqreason,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory ReqReasons.fromMap(Map<String, dynamic> map) {
    return ReqReasons(
      id: map['id'] as int,
      Reqreason: map['Reqreason'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReqReasons.fromJson(String source) =>
      ReqReasons.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ReqReasons(id: $id, Reqreason: $Reqreason, actions: $actions)';

  @override
  bool operator ==(covariant ReqReasons other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.Reqreason == Reqreason &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode => id.hashCode ^ Reqreason.hashCode ^ actions.hashCode;
}

extension C3 on List<ActionModel> {
  String get_Who_Of(String action) {
    return firstWhere(
      (element) => element.action == action,
      orElse: () => ActionModel(action: '', who: '', when: DateTime(0)),
    ).who;
  }

  //get fraction date for this action
  DateTime get_Date_of_action(String action) {
    return where((element) => element.action == action).isEmpty
        ? DateTime.utc(0)
        : where((element) => element.action == action).first.when;
  }

  // return true if action exist
  bool if_action_exist(String actiontitle) {
    return where((element) => element.action == actiontitle).isNotEmpty;
  }
}
