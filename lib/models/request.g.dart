// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RequstesMolelAdapter extends TypeAdapter<RequstesMolel> {
  @override
  final int typeId = 4;

  @override
  RequstesMolel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RequstesMolel(
      Request_ID: fields[0] as int,
      ticket_ID: fields[1] as int,
      Request_serial: fields[52] as int,
      reqreqson: fields[2] as String,
      reqreasonInDetails: fields[3] as String,
      pfodcut: fields[4] as ProductInfo,
      visited: fields[5] as bool,
      visitingdate: fields[6] as DateTime,
      visitResult: fields[7] as String,
      prductuionManagerdecision: fields[8] as String,
      choice1Accetp: fields[9] as bool,
      choice1refuse: fields[10] as bool,
      choice1refusereason: fields[11] as String,
      replaceToSameModel: fields[12] as bool,
      L2: fields[13] as String,
      W2: fields[14] as String,
      H2: fields[15] as String,
      cost1: fields[16] as double,
      choice2Accetp: fields[17] as bool,
      choice2refuse: fields[18] as bool,
      choice2refusereason: fields[19] as String,
      pulled1: fields[20] as bool,
      pulledDate1: fields[21] as DateTime,
      deleverd1: fields[22] as bool,
      deleverdDate1: fields[23] as DateTime,
      replaceTosnotherModel: fields[24] as bool,
      replaceToBrandName: fields[25] as String,
      replaceToProdcutName: fields[26] as String,
      L3: fields[27] as String,
      W3: fields[28] as String,
      H3: fields[29] as String,
      cost2: fields[30] as double,
      choice3Accetp: fields[31] as bool,
      choice3refuse: fields[32] as bool,
      choice3refusereason: fields[33] as String,
      pulled2: fields[34] as bool,
      pulledDate2: fields[35] as DateTime,
      deleverd2: fields[36] as bool,
      deleverdDate2: fields[37] as DateTime,
      maintainace: fields[38] as bool,
      maintanancedescription: fields[39] as String,
      cost3: fields[40] as double,
      choice4Accetp: fields[41] as bool,
      choice4refuse: fields[42] as bool,
      choice4refusereason: fields[43] as String,
      pulled3: fields[44] as bool,
      pulledDate3: fields[45] as DateTime,
      deleverd3: fields[46] as bool,
      deleverdDate3: fields[47] as DateTime,
      finalDicition: fields[48] as String,
      colsedMantananceReq: fields[49] as bool,
      colsedMantananceReqreason: fields[59] as String,
      actions: (fields[51] as List).cast<ActionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, RequstesMolel obj) {
    writer
      ..writeByte(53)
      ..writeByte(0)
      ..write(obj.Request_ID)
      ..writeByte(1)
      ..write(obj.ticket_ID)
      ..writeByte(52)
      ..write(obj.Request_serial)
      ..writeByte(2)
      ..write(obj.reqreqson)
      ..writeByte(3)
      ..write(obj.reqreasonInDetails)
      ..writeByte(4)
      ..write(obj.pfodcut)
      ..writeByte(5)
      ..write(obj.visited)
      ..writeByte(6)
      ..write(obj.visitingdate)
      ..writeByte(7)
      ..write(obj.visitResult)
      ..writeByte(8)
      ..write(obj.prductuionManagerdecision)
      ..writeByte(9)
      ..write(obj.choice1Accetp)
      ..writeByte(10)
      ..write(obj.choice1refuse)
      ..writeByte(11)
      ..write(obj.choice1refusereason)
      ..writeByte(12)
      ..write(obj.replaceToSameModel)
      ..writeByte(13)
      ..write(obj.L2)
      ..writeByte(14)
      ..write(obj.W2)
      ..writeByte(15)
      ..write(obj.H2)
      ..writeByte(16)
      ..write(obj.cost1)
      ..writeByte(17)
      ..write(obj.choice2Accetp)
      ..writeByte(18)
      ..write(obj.choice2refuse)
      ..writeByte(19)
      ..write(obj.choice2refusereason)
      ..writeByte(20)
      ..write(obj.pulled1)
      ..writeByte(21)
      ..write(obj.pulledDate1)
      ..writeByte(22)
      ..write(obj.deleverd1)
      ..writeByte(23)
      ..write(obj.deleverdDate1)
      ..writeByte(24)
      ..write(obj.replaceTosnotherModel)
      ..writeByte(25)
      ..write(obj.replaceToBrandName)
      ..writeByte(26)
      ..write(obj.replaceToProdcutName)
      ..writeByte(27)
      ..write(obj.L3)
      ..writeByte(28)
      ..write(obj.W3)
      ..writeByte(29)
      ..write(obj.H3)
      ..writeByte(30)
      ..write(obj.cost2)
      ..writeByte(31)
      ..write(obj.choice3Accetp)
      ..writeByte(32)
      ..write(obj.choice3refuse)
      ..writeByte(33)
      ..write(obj.choice3refusereason)
      ..writeByte(34)
      ..write(obj.pulled2)
      ..writeByte(35)
      ..write(obj.pulledDate2)
      ..writeByte(36)
      ..write(obj.deleverd2)
      ..writeByte(37)
      ..write(obj.deleverdDate2)
      ..writeByte(38)
      ..write(obj.maintainace)
      ..writeByte(39)
      ..write(obj.maintanancedescription)
      ..writeByte(40)
      ..write(obj.cost3)
      ..writeByte(41)
      ..write(obj.choice4Accetp)
      ..writeByte(42)
      ..write(obj.choice4refuse)
      ..writeByte(43)
      ..write(obj.choice4refusereason)
      ..writeByte(44)
      ..write(obj.pulled3)
      ..writeByte(45)
      ..write(obj.pulledDate3)
      ..writeByte(46)
      ..write(obj.deleverd3)
      ..writeByte(47)
      ..write(obj.deleverdDate3)
      ..writeByte(48)
      ..write(obj.finalDicition)
      ..writeByte(49)
      ..write(obj.colsedMantananceReq)
      ..writeByte(59)
      ..write(obj.colsedMantananceReqreason)
      ..writeByte(51)
      ..write(obj.actions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RequstesMolelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
