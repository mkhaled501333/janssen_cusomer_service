// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:janssen_cusomer_service/models/models.dart';
import 'package:janssen_cusomer_service/models/prodcutinfo.dart';
part 'request.g.dart';

@HiveType(typeId: 4)
class RequstesMolel {
  @HiveField(0)
  int Request_ID;
  @HiveField(1)
  int ticket_ID;
  @HiveField(52)
  int Request_serial;
  @HiveField(2)
  String reqreqson;
  @HiveField(3)
  String reqreasonInDetails;
  @HiveField(4)
  ProductInfo pfodcut;
  // المعاينه
  @HiveField(5)
  bool visited;
  @HiveField(6)
  DateTime visitingdate;
  @HiveField(7)
  String visitResult;
  @HiveField(8)
  String prductuionManagerdecision;
  @HiveField(9)
  bool choice1Accetp;
  @HiveField(10)
  bool choice1refuse;
  @HiveField(11)
  String choice1refusereason;
//استبدال لنفس النوع
  @HiveField(12)
  bool replaceToSameModel;
  @HiveField(13)
  String L2;
  @HiveField(14)
  String W2;
  @HiveField(15)
  String H2;
  @HiveField(16)
  double cost1;
  @HiveField(17)
  bool choice2Accetp;
  @HiveField(18)
  bool choice2refuse;
  @HiveField(19)
  String choice2refusereason;
  @HiveField(20)
  bool pulled1;
  @HiveField(21)
  DateTime pulledDate1;
  @HiveField(22)
  bool deleverd1;
  @HiveField(23)
  DateTime deleverdDate1;
//استبدال لنوع اخر
  @HiveField(24)
  bool replaceTosnotherModel;
  @HiveField(25)
  String replaceToBrandName;
  @HiveField(26)
  String replaceToProdcutName;
  @HiveField(27)
  String L3;
  @HiveField(28)
  String W3;
  @HiveField(29)
  String H3;
  @HiveField(30)
  double cost2;
  @HiveField(31)
  bool choice3Accetp;
  @HiveField(32)
  bool choice3refuse;
  @HiveField(33)
  String choice3refusereason;
  @HiveField(34)
  bool pulled2;
  @HiveField(35)
  DateTime pulledDate2;
  @HiveField(36)
  bool deleverd2;
  @HiveField(37)
  DateTime deleverdDate2;
//صيانه
  @HiveField(38)
  bool maintainace;
  @HiveField(39)
  String maintanancedescription;
  @HiveField(40)
  double cost3;
  @HiveField(41)
  bool choice4Accetp;
  @HiveField(42)
  bool choice4refuse;
  @HiveField(43)
  String choice4refusereason;
  @HiveField(44)
  bool pulled3;
  @HiveField(45)
  DateTime pulledDate3;
  @HiveField(46)
  bool deleverd3;
  @HiveField(47)
  DateTime deleverdDate3;
  @HiveField(48)
  String finalDicition;
  @HiveField(49)
  bool colsedMantananceReq;
  @HiveField(59)
  String colsedMantananceReqreason;
  //--------------------
  @HiveField(51)
  List<ActionModel> actions;
  RequstesMolel({
    required this.Request_ID,
    required this.ticket_ID,
    required this.Request_serial,
    required this.reqreqson,
    required this.reqreasonInDetails,
    required this.pfodcut,
    required this.visited,
    required this.visitingdate,
    required this.visitResult,
    required this.prductuionManagerdecision,
    required this.choice1Accetp,
    required this.choice1refuse,
    required this.choice1refusereason,
    required this.replaceToSameModel,
    required this.L2,
    required this.W2,
    required this.H2,
    required this.cost1,
    required this.choice2Accetp,
    required this.choice2refuse,
    required this.choice2refusereason,
    required this.pulled1,
    required this.pulledDate1,
    required this.deleverd1,
    required this.deleverdDate1,
    required this.replaceTosnotherModel,
    required this.replaceToBrandName,
    required this.replaceToProdcutName,
    required this.L3,
    required this.W3,
    required this.H3,
    required this.cost2,
    required this.choice3Accetp,
    required this.choice3refuse,
    required this.choice3refusereason,
    required this.pulled2,
    required this.pulledDate2,
    required this.deleverd2,
    required this.deleverdDate2,
    required this.maintainace,
    required this.maintanancedescription,
    required this.cost3,
    required this.choice4Accetp,
    required this.choice4refuse,
    required this.choice4refusereason,
    required this.pulled3,
    required this.pulledDate3,
    required this.deleverd3,
    required this.deleverdDate3,
    required this.finalDicition,
    required this.colsedMantananceReq,
    required this.colsedMantananceReqreason,
    required this.actions,
  });

  RequstesMolel copyWith({
    int? Request_ID,
    int? ticket_ID,
    int? Request_serial,
    String? reqreqson,
    String? reqreasonInDetails,
    ProductInfo? pfodcut,
    bool? visited,
    DateTime? visitingdate,
    String? visitResult,
    String? prductuionManagerdecision,
    bool? choice1Accetp,
    bool? choice1refuse,
    String? choice1refusereason,
    bool? replaceToSameModel,
    String? L2,
    String? W2,
    String? H2,
    double? cost1,
    bool? choice2Accetp,
    bool? choice2refuse,
    String? choice2refusereason,
    bool? pulled1,
    DateTime? pulledDate1,
    bool? deleverd1,
    DateTime? deleverdDate1,
    bool? replaceTosnotherModel,
    String? replaceToBrandName,
    String? replaceToProdcutName,
    String? L3,
    String? W3,
    String? H3,
    double? cost2,
    bool? choice3Accetp,
    bool? choice3refuse,
    String? choice3refusereason,
    bool? pulled2,
    DateTime? pulledDate2,
    bool? deleverd2,
    DateTime? deleverdDate2,
    bool? maintainace,
    String? maintanancedescription,
    double? cost3,
    bool? choice4Accetp,
    bool? choice4refuse,
    String? choice4refusereason,
    bool? pulled3,
    DateTime? pulledDate3,
    bool? deleverd3,
    DateTime? deleverdDate3,
    String? finalDicition,
    bool? colsedMantananceReq,
    String? colsedMantananceReqreason,
    List<ActionModel>? actions,
  }) {
    return RequstesMolel(
      Request_ID: Request_ID ?? this.Request_ID,
      ticket_ID: ticket_ID ?? this.ticket_ID,
      Request_serial: Request_serial ?? this.Request_serial,
      reqreqson: reqreqson ?? this.reqreqson,
      reqreasonInDetails: reqreasonInDetails ?? this.reqreasonInDetails,
      pfodcut: pfodcut ?? this.pfodcut,
      visited: visited ?? this.visited,
      visitingdate: visitingdate ?? this.visitingdate,
      visitResult: visitResult ?? this.visitResult,
      prductuionManagerdecision:
          prductuionManagerdecision ?? this.prductuionManagerdecision,
      choice1Accetp: choice1Accetp ?? this.choice1Accetp,
      choice1refuse: choice1refuse ?? this.choice1refuse,
      choice1refusereason: choice1refusereason ?? this.choice1refusereason,
      replaceToSameModel: replaceToSameModel ?? this.replaceToSameModel,
      L2: L2 ?? this.L2,
      W2: W2 ?? this.W2,
      H2: H2 ?? this.H2,
      cost1: cost1 ?? this.cost1,
      choice2Accetp: choice2Accetp ?? this.choice2Accetp,
      choice2refuse: choice2refuse ?? this.choice2refuse,
      choice2refusereason: choice2refusereason ?? this.choice2refusereason,
      pulled1: pulled1 ?? this.pulled1,
      pulledDate1: pulledDate1 ?? this.pulledDate1,
      deleverd1: deleverd1 ?? this.deleverd1,
      deleverdDate1: deleverdDate1 ?? this.deleverdDate1,
      replaceTosnotherModel:
          replaceTosnotherModel ?? this.replaceTosnotherModel,
      replaceToBrandName: replaceToBrandName ?? this.replaceToBrandName,
      replaceToProdcutName: replaceToProdcutName ?? this.replaceToProdcutName,
      L3: L3 ?? this.L3,
      W3: W3 ?? this.W3,
      H3: H3 ?? this.H3,
      cost2: cost2 ?? this.cost2,
      choice3Accetp: choice3Accetp ?? this.choice3Accetp,
      choice3refuse: choice3refuse ?? this.choice3refuse,
      choice3refusereason: choice3refusereason ?? this.choice3refusereason,
      pulled2: pulled2 ?? this.pulled2,
      pulledDate2: pulledDate2 ?? this.pulledDate2,
      deleverd2: deleverd2 ?? this.deleverd2,
      deleverdDate2: deleverdDate2 ?? this.deleverdDate2,
      maintainace: maintainace ?? this.maintainace,
      maintanancedescription:
          maintanancedescription ?? this.maintanancedescription,
      cost3: cost3 ?? this.cost3,
      choice4Accetp: choice4Accetp ?? this.choice4Accetp,
      choice4refuse: choice4refuse ?? this.choice4refuse,
      choice4refusereason: choice4refusereason ?? this.choice4refusereason,
      pulled3: pulled3 ?? this.pulled3,
      pulledDate3: pulledDate3 ?? this.pulledDate3,
      deleverd3: deleverd3 ?? this.deleverd3,
      deleverdDate3: deleverdDate3 ?? this.deleverdDate3,
      finalDicition: finalDicition ?? this.finalDicition,
      colsedMantananceReq: colsedMantananceReq ?? this.colsedMantananceReq,
      colsedMantananceReqreason:
          colsedMantananceReqreason ?? this.colsedMantananceReqreason,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Request_ID': Request_ID,
      'ticket_ID': ticket_ID,
      'Request_serial': Request_serial,
      'reqreqson': reqreqson,
      'reqreasonInDetails': reqreasonInDetails,
      'pfodcut': pfodcut.toMap(),
      'visited': visited,
      'visitingdate': visitingdate.millisecondsSinceEpoch,
      'visitResult': visitResult,
      'prductuionManagerdecision': prductuionManagerdecision,
      'choice1Accetp': choice1Accetp,
      'choice1refuse': choice1refuse,
      'choice1refusereason': choice1refusereason,
      'replaceToSameModel': replaceToSameModel,
      'L2': L2,
      'W2': W2,
      'H2': H2,
      'cost1': cost1,
      'choice2Accetp': choice2Accetp,
      'choice2refuse': choice2refuse,
      'choice2refusereason': choice2refusereason,
      'pulled1': pulled1,
      'pulledDate1': pulledDate1.millisecondsSinceEpoch,
      'deleverd1': deleverd1,
      'deleverdDate1': deleverdDate1.millisecondsSinceEpoch,
      'replaceTosnotherModel': replaceTosnotherModel,
      'replaceToBrandName': replaceToBrandName,
      'replaceToProdcutName': replaceToProdcutName,
      'L3': L3,
      'W3': W3,
      'H3': H3,
      'cost2': cost2,
      'choice3Accetp': choice3Accetp,
      'choice3refuse': choice3refuse,
      'choice3refusereason': choice3refusereason,
      'pulled2': pulled2,
      'pulledDate2': pulledDate2.millisecondsSinceEpoch,
      'deleverd2': deleverd2,
      'deleverdDate2': deleverdDate2.millisecondsSinceEpoch,
      'maintainace': maintainace,
      'maintanancedescription': maintanancedescription,
      'cost3': cost3,
      'choice4Accetp': choice4Accetp,
      'choice4refuse': choice4refuse,
      'choice4refusereason': choice4refusereason,
      'pulled3': pulled3,
      'pulledDate3': pulledDate3.millisecondsSinceEpoch,
      'deleverd3': deleverd3,
      'deleverdDate3': deleverdDate3.millisecondsSinceEpoch,
      'finalDicition': finalDicition,
      'colsedMantananceReq': colsedMantananceReq,
      'colsedMantananceReqreason': colsedMantananceReqreason,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory RequstesMolel.fromMap(Map<String, dynamic> map) {
    return RequstesMolel(
      Request_ID: map['Request_ID'] as int,
      ticket_ID: map['ticket_ID'] as int,
      Request_serial: map['Request_serial'] as int,
      reqreqson: map['reqreqson'] as String,
      reqreasonInDetails: map['reqreasonInDetails'] as String,
      pfodcut: ProductInfo.fromMap(map['pfodcut'] as Map<String, dynamic>),
      visited: map['visited'] as bool,
      visitingdate:
          DateTime.fromMillisecondsSinceEpoch(map['visitingdate'] as int),
      visitResult: map['visitResult'] as String,
      prductuionManagerdecision: map['prductuionManagerdecision'] as String,
      choice1Accetp: map['choice1Accetp'] as bool,
      choice1refuse: map['choice1refuse'] as bool,
      choice1refusereason: map['choice1refusereason'] as String,
      replaceToSameModel: map['replaceToSameModel'] as bool,
      L2: map['L2'] as String,
      W2: map['W2'] as String,
      H2: map['H2'] as String,
      cost1: map['cost1'] as double,
      choice2Accetp: map['choice2Accetp'] as bool,
      choice2refuse: map['choice2refuse'] as bool,
      choice2refusereason: map['choice2refusereason'] as String,
      pulled1: map['pulled1'] as bool,
      pulledDate1:
          DateTime.fromMillisecondsSinceEpoch(map['pulledDate1'] as int),
      deleverd1: map['deleverd1'] as bool,
      deleverdDate1:
          DateTime.fromMillisecondsSinceEpoch(map['deleverdDate1'] as int),
      replaceTosnotherModel: map['replaceTosnotherModel'] as bool,
      replaceToBrandName: map['replaceToBrandName'] as String,
      replaceToProdcutName: map['replaceToProdcutName'] as String,
      L3: map['L3'] as String,
      W3: map['W3'] as String,
      H3: map['H3'] as String,
      cost2: map['cost2'] as double,
      choice3Accetp: map['choice3Accetp'] as bool,
      choice3refuse: map['choice3refuse'] as bool,
      choice3refusereason: map['choice3refusereason'] as String,
      pulled2: map['pulled2'] as bool,
      pulledDate2:
          DateTime.fromMillisecondsSinceEpoch(map['pulledDate2'] as int),
      deleverd2: map['deleverd2'] as bool,
      deleverdDate2:
          DateTime.fromMillisecondsSinceEpoch(map['deleverdDate2'] as int),
      maintainace: map['maintainace'] as bool,
      maintanancedescription: map['maintanancedescription'] as String,
      cost3: map['cost3'] as double,
      choice4Accetp: map['choice4Accetp'] as bool,
      choice4refuse: map['choice4refuse'] as bool,
      choice4refusereason: map['choice4refusereason'] as String,
      pulled3: map['pulled3'] as bool,
      pulledDate3:
          DateTime.fromMillisecondsSinceEpoch(map['pulledDate3'] as int),
      deleverd3: map['deleverd3'] as bool,
      deleverdDate3:
          DateTime.fromMillisecondsSinceEpoch(map['deleverdDate3'] as int),
      finalDicition: map['finalDicition'] as String,
      colsedMantananceReq: map['colsedMantananceReq'] as bool,
      colsedMantananceReqreason: map['colsedMantananceReqreason'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory RequstesMolel.fromJson(String source) =>
      RequstesMolel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'RequstesMolel(Request_ID: $Request_ID, ticket_ID: $ticket_ID, Request_serial: $Request_serial, reqreqson: $reqreqson, reqreasonInDetails: $reqreasonInDetails, pfodcut: $pfodcut, visited: $visited, visitingdate: $visitingdate, visitResult: $visitResult, prductuionManagerdecision: $prductuionManagerdecision, choice1Accetp: $choice1Accetp, choice1refuse: $choice1refuse, choice1refusereason: $choice1refusereason, replaceToSameModel: $replaceToSameModel, L2: $L2, W2: $W2, H2: $H2, cost1: $cost1, choice2Accetp: $choice2Accetp, choice2refuse: $choice2refuse, choice2refusereason: $choice2refusereason, pulled1: $pulled1, pulledDate1: $pulledDate1, deleverd1: $deleverd1, deleverdDate1: $deleverdDate1, replaceTosnotherModel: $replaceTosnotherModel, replaceToBrandName: $replaceToBrandName, replaceToProdcutName: $replaceToProdcutName, L3: $L3, W3: $W3, H3: $H3, cost2: $cost2, choice3Accetp: $choice3Accetp, choice3refuse: $choice3refuse, choice3refusereason: $choice3refusereason, pulled2: $pulled2, pulledDate2: $pulledDate2, deleverd2: $deleverd2, deleverdDate2: $deleverdDate2, maintainace: $maintainace, maintanancedescription: $maintanancedescription, cost3: $cost3, choice4Accetp: $choice4Accetp, choice4refuse: $choice4refuse, choice4refusereason: $choice4refusereason, pulled3: $pulled3, pulledDate3: $pulledDate3, deleverd3: $deleverd3, deleverdDate3: $deleverdDate3, finalDicition: $finalDicition, colsedMantananceReq: $colsedMantananceReq, colsedMantananceReqreason: $colsedMantananceReqreason, actions: $actions)';
  }

  @override
  bool operator ==(covariant RequstesMolel other) {
    if (identical(this, other)) return true;

    return other.Request_ID == Request_ID &&
        other.ticket_ID == ticket_ID &&
        other.Request_serial == Request_serial &&
        other.reqreqson == reqreqson &&
        other.reqreasonInDetails == reqreasonInDetails &&
        other.pfodcut == pfodcut &&
        other.visited == visited &&
        other.visitingdate == visitingdate &&
        other.visitResult == visitResult &&
        other.prductuionManagerdecision == prductuionManagerdecision &&
        other.choice1Accetp == choice1Accetp &&
        other.choice1refuse == choice1refuse &&
        other.choice1refusereason == choice1refusereason &&
        other.replaceToSameModel == replaceToSameModel &&
        other.L2 == L2 &&
        other.W2 == W2 &&
        other.H2 == H2 &&
        other.cost1 == cost1 &&
        other.choice2Accetp == choice2Accetp &&
        other.choice2refuse == choice2refuse &&
        other.choice2refusereason == choice2refusereason &&
        other.pulled1 == pulled1 &&
        other.pulledDate1 == pulledDate1 &&
        other.deleverd1 == deleverd1 &&
        other.deleverdDate1 == deleverdDate1 &&
        other.replaceTosnotherModel == replaceTosnotherModel &&
        other.replaceToBrandName == replaceToBrandName &&
        other.replaceToProdcutName == replaceToProdcutName &&
        other.L3 == L3 &&
        other.W3 == W3 &&
        other.H3 == H3 &&
        other.cost2 == cost2 &&
        other.choice3Accetp == choice3Accetp &&
        other.choice3refuse == choice3refuse &&
        other.choice3refusereason == choice3refusereason &&
        other.pulled2 == pulled2 &&
        other.pulledDate2 == pulledDate2 &&
        other.deleverd2 == deleverd2 &&
        other.deleverdDate2 == deleverdDate2 &&
        other.maintainace == maintainace &&
        other.maintanancedescription == maintanancedescription &&
        other.cost3 == cost3 &&
        other.choice4Accetp == choice4Accetp &&
        other.choice4refuse == choice4refuse &&
        other.choice4refusereason == choice4refusereason &&
        other.pulled3 == pulled3 &&
        other.pulledDate3 == pulledDate3 &&
        other.deleverd3 == deleverd3 &&
        other.deleverdDate3 == deleverdDate3 &&
        other.finalDicition == finalDicition &&
        other.colsedMantananceReq == colsedMantananceReq &&
        other.colsedMantananceReqreason == colsedMantananceReqreason &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return Request_ID.hashCode ^
        ticket_ID.hashCode ^
        Request_serial.hashCode ^
        reqreqson.hashCode ^
        reqreasonInDetails.hashCode ^
        pfodcut.hashCode ^
        visited.hashCode ^
        visitingdate.hashCode ^
        visitResult.hashCode ^
        prductuionManagerdecision.hashCode ^
        choice1Accetp.hashCode ^
        choice1refuse.hashCode ^
        choice1refusereason.hashCode ^
        replaceToSameModel.hashCode ^
        L2.hashCode ^
        W2.hashCode ^
        H2.hashCode ^
        cost1.hashCode ^
        choice2Accetp.hashCode ^
        choice2refuse.hashCode ^
        choice2refusereason.hashCode ^
        pulled1.hashCode ^
        pulledDate1.hashCode ^
        deleverd1.hashCode ^
        deleverdDate1.hashCode ^
        replaceTosnotherModel.hashCode ^
        replaceToBrandName.hashCode ^
        replaceToProdcutName.hashCode ^
        L3.hashCode ^
        W3.hashCode ^
        H3.hashCode ^
        cost2.hashCode ^
        choice3Accetp.hashCode ^
        choice3refuse.hashCode ^
        choice3refusereason.hashCode ^
        pulled2.hashCode ^
        pulledDate2.hashCode ^
        deleverd2.hashCode ^
        deleverdDate2.hashCode ^
        maintainace.hashCode ^
        maintanancedescription.hashCode ^
        cost3.hashCode ^
        choice4Accetp.hashCode ^
        choice4refuse.hashCode ^
        choice4refusereason.hashCode ^
        pulled3.hashCode ^
        pulledDate3.hashCode ^
        deleverd3.hashCode ^
        deleverdDate3.hashCode ^
        finalDicition.hashCode ^
        colsedMantananceReq.hashCode ^
        colsedMantananceReqreason.hashCode ^
        actions.hashCode;
  }
}
