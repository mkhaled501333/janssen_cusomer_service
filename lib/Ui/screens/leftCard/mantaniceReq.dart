// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssen_cusomer_service/Ui/base.dart';
import 'package:janssen_cusomer_service/Ui/recourses/sharedWidgets/textformfield.dart';
import 'package:janssen_cusomer_service/Ui/screens/rightCard/rightCard.dart';
import 'package:janssen_cusomer_service/app/actions.dart';
import 'package:janssen_cusomer_service/app/extentions.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';
import 'package:janssen_cusomer_service/main.dart';
import 'package:janssen_cusomer_service/models/models.dart';
import 'package:janssen_cusomer_service/models/request.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';
import 'package:provider/provider.dart';

class MantainceRequestInfo extends StatelessWidget {
  MantainceRequestInfo({
    super.key,
    required this.ticket,
  });
  final TicketModel ticket;
  // ignore: non_constant_identifier_names
  var TStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
  TEDcontrollers con = TEDcontrollers();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(5),
        mantananceReqHeader(context),
        Container(
          height: MediaQuery.of(context).size.height - 120,
          decoration: const BoxDecoration(color: Color.fromRGBO(246, 246, 248, 1), borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
          // width: .4 * (MediaQuery.sizeOf(context).width * .78),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // اضافة طلب جديد
                addNewMaintananceReq(context),
                ...ticket.requests.sortedBy<num>((n) => n.Request_ID).map((i) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        leading: editMaintainceReqItem(i, context),
                        collapsedShape: const OutlineInputBorder(),
                        shape: const OutlineInputBorder(),
                        title: Column(
                          children: [
                            // نوع المنتج
                            Padding(
                              padding: const EdgeInsets.only(right: 9, bottom: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    " ${i.pfodcut.ProdcutType}",
                                    style: TStyle,
                                  ),
                                  Text(
                                    " : نوع المنتج ",
                                    style: TStyle,
                                  ),
                                ],
                              ),
                            ),
                            //اسم المنتج
                            Padding(
                              padding: const EdgeInsets.only(right: 9, bottom: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    i.pfodcut.ProductName,
                                    style: TStyle,
                                  ),
                                  Text(
                                    " : اسم المنتج",
                                    style: TStyle,
                                  ),
                                ],
                              ),
                            ),
                            // المقاس
                            Padding(
                              padding: const EdgeInsets.only(right: 9, bottom: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "${i.pfodcut.L}*${i.pfodcut.W}*${i.pfodcut.H}",
                                    style: TStyle,
                                  ),
                                  Text(
                                    " : المقاس",
                                    style: TStyle,
                                  ),
                                ],
                              ),
                            ),
                            // الكميه
                            Padding(
                              padding: const EdgeInsets.only(right: 9, bottom: 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "${i.pfodcut.Quantity} ",
                                    style: TStyle,
                                  ),
                                  Text(
                                    " : الكميه",
                                    style: TStyle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        collapsedBackgroundColor: const Color.fromARGB(255, 153, 211, 218),
                        backgroundColor: const Color.fromARGB(255, 226, 229, 235),
                        children: [
                          maintainceReqdetails(i),
                          const Line(),
                          visited(i, context),
                          const Line(),
                          replaceToSameModel(i, context),
                          replaceToAnotherMolel(i, context),
                          maintaince(i, context)
                        ],
                      ),
                    ))
              ],
            ),
          ),
        )
      ],
    );
  }

  Container mantananceReqHeader(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 211, 210, 210), borderRadius: BorderRadius.vertical(top: Radius.circular(5))),
      // width: .4 * (MediaQuery.sizeOf(context).width * .78),
      child: const Center(
          child: Text(
        "MantainceRequest Info",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      )),
    );
  }

  Visibility maintaince(RequstesMolel i, BuildContext context) {
    return Visibility(
        visible: i.replaceToSameModel == false && i.replaceTosnotherModel == false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (i.maintainace == true)
                  Tooltip(
                      message:
                          '${i.actions.get_Who_Of(MaintainanceRequestAction.maintanance.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.maintanance.getTitle))}',
                      child: const Icon(size: 22, Icons.info_outline)),
                Text(
                  ' صيانه ',
                  style: TStyle,
                ),
                Checkbox(
                    value: i.maintainace,
                    onChanged: (b) async {
                      // if (b == true) {
                      i.maintainace = !i.maintainace;
                      i.actions.add(MaintainanceRequestAction.maintanance.add);
                      con.updateRequest(context, i);
                      // }
                    }),
              ],
            ),
            if (i.maintainace == true)
              Center(
                child: CustomTextFormField(
                    onsubmitted: (v) {
                      i.maintanancedescription = v!;
                      con.updateRequest(context, i);

                      return null;
                    },
                    hint: 'الاجراءات المتبعه للصيانه',
                    width: 250,
                    controller: TextEditingController(text: ticket.requests.first.maintanancedescription)),
              ),
            if (i.maintainace == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: CustomTextFormField(
                        onsubmitted: (v) {
                          i.cost3 = v!.to_double();
                          con.updateRequest(context, i);

                          return null;
                        },
                        hint: 'التكلفه',
                        width: 88,
                        controller: TextEditingController(text: i.cost3.toString())),
                  ),
                  const Gap(12),
                  Checkbox(
                      value: i.choice4Accetp,
                      onChanged: (b) async {
                        i.choice4Accetp = !i.choice4Accetp;
                        i.actions.add(MaintainanceRequestAction.ch4Agree.add);
                        con.updateRequest(context, i);
                      }),
                  Text(
                    ' موافق',
                    style: TStyle,
                  ),
                  if (i.choice4Accetp == true)
                    Tooltip(
                        message:
                            '${i.actions.get_Who_Of(MaintainanceRequestAction.ch4Agree.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.ch4Agree.getTitle))}',
                        child: const Icon(size: 22, Icons.info_outline)),
                  const Gap(12),
                  Checkbox(
                      value: i.choice4refuse,
                      onChanged: (b) async {
                        i.choice4refuse = !i.choice4refuse;
                        i.actions.add(MaintainanceRequestAction.ch4disdisAgree.add);

                        con.updateRequest(context, i);
                      }),
                  if (i.choice4refuse == true)
                    Tooltip(
                        message:
                            '${i.actions.get_Who_Of(MaintainanceRequestAction.ch4disdisAgree.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.ch4disdisAgree.getTitle))}',
                        child: const Icon(size: 22, Icons.info_outline)),
                  Text(
                    ' غير موافق',
                    style: TStyle,
                  ),
                ].reversed.toList(),
              ),
            if (i.maintainace == true)
              if (i.choice4refuse == true)
                Center(
                  child: CustomTextFormField(
                      onsubmitted: (v) {
                        i.choice4refusereason = v!;
                        con.updateRequest(context, i);

                        return null;
                      },
                      hint: 'سبب الرفض',
                      width: 250,
                      controller: TextEditingController(text: i.choice4refusereason)),
                ),
            pulledAndDeleverd3(i, context)
          ],
        ));
  }

  Visibility replaceToAnotherMolel(RequstesMolel i, BuildContext context) {
    return Visibility(
        visible: i.maintainace == false && i.replaceToSameModel == false,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (i.replaceTosnotherModel == true)
                  Tooltip(
                      message:
                          '${i.actions.get_Who_Of(MaintainanceRequestAction.replaceToAnotherProdcut.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.replaceToAnotherProdcut.getTitle))}',
                      child: const Icon(size: 22, Icons.info_outline)),
                Text(
                  '! استبدال لنوع اخر ',
                  style: TStyle,
                ),
                Checkbox(
                    value: i.replaceTosnotherModel,
                    onChanged: (b) async {
                      // if (b == true) {
                      i.replaceTosnotherModel = !i.replaceTosnotherModel;
                      i.actions.add(MaintainanceRequestAction.replaceToAnotherProdcut.add);
                      con.updateRequest(context, i);
                      // }
                    }),
              ],
            ),
            if (i.replaceTosnotherModel == true)
              Center(
                child: SearchWithSugestions2(
                  v: (f) {
                    i.replaceToBrandName = f;
                    con.updateRequest(context, i);
                    // con.validate();
                    FocusScope.of(context).nextFocus();
                  },
                  labal: 'العلامة التجاريه',
                  listOfsugestions: context.read<HiveDB>().prodcuts.values.map((convert) => convert.companyName).toList(),
                  TEC_forgovernmoate: TextEditingController(text: i.replaceToBrandName),
                  onSubmitted: (f) {},
                ),
              ),
            const Gap(5),
            if (i.replaceTosnotherModel == true)
              Center(
                child: SearchWithSugestions2(
                  v: (f) {
                    i.replaceToProdcutName = f;
                    con.updateRequest(context, i);
                    // con.validate();
                    FocusScope.of(context).nextFocus();
                  },
                  labal: 'اسم المنتج',
                  listOfsugestions: con.TED_productType.text.isEmpty
                      ? []
                      : context.read<HiveDB>().prodcuts.values.where((test) => test.companyName == con.TED_productType.text).expand((e) => e.prodcuts).toList(),
                  TEC_forgovernmoate: TextEditingController(text: i.replaceToProdcutName),
                  onSubmitted: (f) {
                    i.replaceToProdcutName = f;
                    con.updateRequest(context, i);
                    // con.validate();
                    FocusScope.of(context).nextFocus();
                  },
                ),
              ),
            const Gap(11),
            if (i.replaceTosnotherModel == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CustomTextFormField(
                        onsubmitted: (v) {
                          i.L3 = v!;
                          con.updateRequest(context, i);
                          FocusScope.of(context).previousFocus();
                          return null;
                        },
                        hint: 'طول',
                        width: 88,
                        controller: TextEditingController(text: i.L3.toString())),
                  ),
                  Center(
                    child: CustomTextFormField(
                        onsubmitted: (v) {
                          i.W3 = v!;
                          con.updateRequest(context, i);
                          FocusScope.of(context).focusInDirection(TraversalDirection.left);

                          return null;
                        },
                        hint: 'عرض',
                        width: 88,
                        controller: TextEditingController(text: i.W3.toString())),
                  ),
                  Center(
                    child: CustomTextFormField(
                        onsubmitted: (v) {
                          i.H3 = v!;
                          con.updateRequest(context, i);
                          FocusScope.of(context).previousFocus();

                          return null;
                        },
                        hint: 'ارتفاع',
                        width: 88,
                        controller: TextEditingController(text: i.H3.toString())),
                  ),
                ].reversed.toList(),
              ),
            if (i.replaceTosnotherModel == true)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: CustomTextFormField(
                        onsubmitted: (v) {
                          i.cost2 = v!.to_double();
                          con.updateRequest(context, i);

                          return null;
                        },
                        hint: 'التكلفه',
                        width: 88,
                        controller: TextEditingController(text: i.cost2.toString())),
                  ),
                  const Gap(12),
                  Checkbox(
                      value: i.choice3Accetp,
                      onChanged: (b) async {
                        i.choice3Accetp = !i.choice3Accetp;
                        i.actions.add(MaintainanceRequestAction.ch3Agree.add);
                        con.updateRequest(context, i);
                      }),
                  Text(
                    ' موافق',
                    style: TStyle,
                  ),
                  if (i.choice3Accetp == true)
                    Tooltip(
                        message:
                            '${i.actions.get_Who_Of(MaintainanceRequestAction.ch3Agree.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.ch3Agree.getTitle))}',
                        child: const Icon(size: 22, Icons.info_outline)),
                  const Gap(12),
                  Checkbox(
                      value: i.choice3refuse,
                      onChanged: (b) async {
                        i.choice3refuse = !i.choice3refuse;
                        i.actions.add(MaintainanceRequestAction.ch3disdisAgree.add);

                        con.updateRequest(context, i);
                      }),
                  if (i.choice3refuse == true)
                    Tooltip(
                        message:
                            '${i.actions.get_Who_Of(MaintainanceRequestAction.ch3disdisAgree.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.ch3disdisAgree.getTitle))}',
                        child: const Icon(size: 22, Icons.info_outline)),
                  Text(
                    ' غير موافق',
                    style: TStyle,
                  ),
                ].reversed.toList(),
              ),
            if (i.replaceTosnotherModel == true)
              if (i.choice3refuse == true)
                Center(
                  child: CustomTextFormField(
                      onsubmitted: (v) {
                        i.choice3refusereason = v!;
                        con.updateRequest(context, i);

                        return null;
                      },
                      hint: 'سبب الرفض',
                      width: 250,
                      controller: TextEditingController(text: i.choice3refusereason)),
                ),
            pulledAndDeleverd2(i, context)
          ],
        ));
  }

  Visibility replaceToSameModel(RequstesMolel i, BuildContext context) {
    return Visibility(
        visible: i.replaceTosnotherModel == false && i.maintainace == false,
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (i.replaceToSameModel == true)
                      Tooltip(
                          message:
                              '${i.actions.get_Who_Of(MaintainanceRequestAction.replaceToSameProdcut.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.replaceToSameProdcut.getTitle))}',
                          child: const Icon(size: 22, Icons.info_outline)),
                    Text(
                      ' استبدال لنفس النوع ',
                      style: TStyle,
                    ),
                    Checkbox(
                        value: i.replaceToSameModel,
                        onChanged: (b) async {
                          // if (b == true) {
                          i.replaceToSameModel = !i.replaceToSameModel;
                          i.actions.add(MaintainanceRequestAction.replaceToSameProdcut.add);
                          con.updateRequest(context, i);
                          // }
                        }),
                  ],
                ),
                if (i.replaceToSameModel == true)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                          onsubmitted: (v) {
                            i.L2 = v!;
                            con.updateRequest(context, i);
                            FocusScope.of(context).focusInDirection(TraversalDirection.left);
                            return null;
                          },
                          hint: 'طول',
                          width: 88,
                          controller: TextEditingController(text: i.L2.toString())),
                      CustomTextFormField(
                          onsubmitted: (v) {
                            i.W2 = v!;
                            con.updateRequest(context, i);
                            FocusScope.of(context).focusInDirection(TraversalDirection.left);

                            return null;
                          },
                          hint: 'عرض',
                          width: 88,
                          controller: TextEditingController(text: i.W2.toString())),
                      CustomTextFormField(
                          onsubmitted: (v) {
                            i.H2 = v!;
                            con.updateRequest(context, i);
                            FocusScope.of(context).focusInDirection(TraversalDirection.down);

                            return null;
                          },
                          hint: 'ارتفاع',
                          width: 88,
                          controller: TextEditingController(text: i.H2.toString())),
                    ].reversed.toList(),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (i.replaceToSameModel == true)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Center(
                            child: CustomTextFormField(
                                onsubmitted: (v) {
                                  i.cost1 = v!.to_double();
                                  con.updateRequest(context, i);

                                  return null;
                                },
                                hint: 'التكلفه',
                                width: 88,
                                controller: TextEditingController(text: i.cost1.toString())),
                          ),
                          const Gap(12),
                          Checkbox(
                              value: i.choice2Accetp,
                              onChanged: (b) async {
                                i.choice2Accetp = !i.choice2Accetp;
                                i.actions.add(MaintainanceRequestAction.ch2Agree.add);
                                con.updateRequest(context, i);
                              }),
                          Text(
                            ' موافق',
                            style: TStyle,
                          ),
                          if (i.choice2Accetp == true)
                            Tooltip(
                                message:
                                    '${i.actions.get_Who_Of(MaintainanceRequestAction.ch2Agree.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.ch2Agree.getTitle))}',
                                child: const Icon(size: 22, Icons.info_outline)),
                          const Gap(12),
                          Checkbox(
                              value: i.choice2refuse,
                              onChanged: (b) async {
                                i.choice2refuse = !i.choice2refuse;
                                i.actions.add(MaintainanceRequestAction.ch2disdisAgree.add);

                                con.updateRequest(context, i);
                              }),
                          if (i.choice2refuse == true)
                            Tooltip(
                                message:
                                    '${i.actions.get_Who_Of(MaintainanceRequestAction.ch2disdisAgree.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.ch2disdisAgree.getTitle))}',
                                child: const Icon(size: 22, Icons.info_outline)),
                          Text(
                            ' غير موافق',
                            style: TStyle,
                          ),
                        ].reversed.toList(),
                      ),
                    if (i.replaceToSameModel == true)
                      if (i.choice2refuse == true)
                        Center(
                          child: CustomTextFormField(
                              onsubmitted: (v) {
                                i.choice2refusereason = v!;
                                con.updateRequest(context, i);

                                return null;
                              },
                              hint: 'سبب الرفض',
                              width: 250,
                              controller: TextEditingController(text: i.choice2refusereason)),
                        ),
                    pulledAndDeleverd1(i, context)
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Visibility visited(RequstesMolel i, BuildContext context) {
    return Visibility(
      visible: true,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (i.visited == true)
                Text(
                  '${df.format(i.visitingdate)} < تاريخ المعاينه',
                  style: TStyle,
                ),
              const Gap(11),
              if (i.visited == true)
                Tooltip(
                    message:
                        '${i.actions.get_Who_Of(MaintainanceRequestAction.visited.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.visited.getTitle))}',
                    child: const Icon(size: 22, Icons.info_outline)),
              const Gap(5),
              // المعاينه

              Text(
                ' تمت المعاينه ',
                style: TStyle,
              ),
              Checkbox(
                  value: i.visited,
                  onChanged: (b) async {
                    DateTime? picked;
                    if (b == true) {
                      picked = await showDatePicker(
                          helpText: "اختر تاريخ المعاينه",
                          context: context,
                          initialDate: DateTime.now(),
                          initialDatePickerMode: DatePickerMode.day,
                          firstDate: DateTime(2015),
                          lastDate: DateTime.now());
                      if (picked != null) {
                        i.visited = !i.visited;
                        i.visitingdate = picked;
                        i.actions.add(MaintainanceRequestAction.visited.add);
                        con.updateRequest(context, i);
                      }
                    }
                  }),
            ],
          ),
          const Gap(14),
          if (i.visited == true)
            Center(
              child: CustomTextFormField(
                  onsubmitted: (v) {
                    i.visitResult = v!;
                    con.updateRequest(context, i);

                    return null;
                  },
                  hint: 'نتيجة المعاينه',
                  width: 444,
                  controller: TextEditingController(text: i.visitResult)),
            ),
          const Gap(11),
          if (i.visited == true)
            Center(
              child: CustomTextFormField(
                  onsubmitted: (v) {
                    i.prductuionManagerdecision = v!;
                    con.updateRequest(context, i);
                    return null;
                  },
                  hint: 'قرار مدير الانتاج',
                  width: 444,
                  controller: TextEditingController(text: i.prductuionManagerdecision)),
            ),
          if (i.visited == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (i.choice1Accetp == true)
                  Tooltip(
                      message:
                          '${i.actions.get_Who_Of(MaintainanceRequestAction.ch1Agree.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.ch1Agree.getTitle))}',
                      child: const Icon(size: 22, Icons.info_outline)),
                Text(
                  ' موافق',
                  style: TStyle,
                ),
                Checkbox(
                    value: i.choice1Accetp,
                    onChanged: (b) async {
                      i.choice1Accetp = !i.choice1Accetp;
                      i.actions.add(MaintainanceRequestAction.ch1Agree.add);
                      con.updateRequest(context, i);
                    }),
              ],
            ),
          if (i.visited == true)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (i.choice1refuse == true)
                  Tooltip(
                      message:
                          '${i.actions.get_Who_Of(MaintainanceRequestAction.ch1disdisAgree.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.ch1disdisAgree.getTitle))}',
                      child: const Icon(size: 22, Icons.info_outline)),
                Text(
                  ' غير موافق',
                  style: TStyle,
                ),
                Checkbox(
                    value: i.choice1refuse,
                    onChanged: (b) async {
                      i.choice1refuse = !i.choice1refuse;
                      i.actions.add(MaintainanceRequestAction.ch1disdisAgree.add);

                      con.updateRequest(context, i);
                    }),
              ],
            ),
          if (i.choice1refuse == true)
            Center(
              child: CustomTextFormField(
                  onsubmitted: (v) {
                    i.choice1refusereason = v!;
                    con.updateRequest(context, i);

                    return null;
                  },
                  hint: 'سبب الرفض',
                  width: 250,
                  controller: TextEditingController(text: i.choice1refusereason)),
            ),
        ],
      ),
    );
  }

  Column maintainceReqdetails(RequstesMolel i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        //تاريخ الاانشاء
        Padding(
          padding: const EdgeInsets.only(right: 9, bottom: 6),
          child: Text(
            "${YMDHM.format(DateTime.fromMicrosecondsSinceEpoch(i.pfodcut.ID))} : تاريخ الانشاء",
            style: TStyle,
          ),
        ),
        //تاريخ الشراء
        Padding(
          padding: const EdgeInsets.only(right: 9, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: i.pfodcut.PurcheDate.year != 0,
                child: Text(
                  "${df.format(i.pfodcut.PurcheDate)} ",
                  style: TStyle,
                ),
              ),
              Text(
                " : تاريخ الشراء",
                style: TStyle,
              ),
            ],
          ),
        ),
        // مكان الشراء
        Padding(
          padding: const EdgeInsets.only(right: 9, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "  ${i.pfodcut.PurcheLocation} ",
                style: TStyle,
              ),
              Text(
                " : مكان الشراء",
                style: TStyle,
              ),
            ],
          ),
        ),
        // سبب الطلب
        Padding(
          padding: const EdgeInsets.only(right: 9, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                " ${i.reqreqson}",
                style: TStyle,
              ),
              Text(
                " : سبب الطلب ",
                style: TStyle,
              ),
            ],
          ),
        ),
        // تفصيل سبب الطلب
        Padding(
          padding: const EdgeInsets.only(right: 9, bottom: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  " ${i.reqreasonInDetails}",
                  style: TStyle,
                ),
              ),
              Text(
                " : سبب الطلب ب التفصيل ",
                style: TStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconButton editMaintainceReqItem(RequstesMolel i, BuildContext context) {
    return IconButton(
        onPressed: () {
          DateTime? pickedDate;
          con.TED_RequestReasonINDetails.text = i.reqreasonInDetails;

          con.TED_ProdcutName.text = i.pfodcut.ProductName;
          con.TED_RequestReason.text = i.reqreqson;
          con.TED_productType.text = i.pfodcut.ProdcutType;
          con.TED_L.text = i.pfodcut.L.toString();
          con.TED_H.text = i.pfodcut.H.toString();
          con.TED_W.text = i.pfodcut.W.toString();
          con.TED_Quantity.text = i.pfodcut.Quantity.toString();
          con.TED_purchePlace.text = i.pfodcut.PurcheLocation.toString();
          pickedDate = i.pfodcut.PurcheDate;
          showDialog(
              context: context,
              builder: (c) => Consumer<HiveDB>(
                    builder: (context, myType, child) {
                      return AlertDialog(
                        content: SizedBox(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SearchWithSugestions(onselected: (p0) {
                                  
                                },
                                  labal: 'العلامة التجاريه',
                                  listOfsugestions: context.read<HiveDB>().prodcuts.values.map((convert) => convert.companyName).toList(),
                                  TEC_forgovernmoate: con.TED_productType,
                                  onSubmitted: (f) {
                                    // con.validate();
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                                const Gap(5),
                                SearchWithSugestions(onselected: (p0) {
                                  
                                },
                                  labal: 'اسم المنتج',
                                  listOfsugestions:
                                      context.read<HiveDB>().prodcuts.values.where((test) => test.companyName == con.TED_productType.text).expand((e) => e.prodcuts).toList(),
                                  TEC_forgovernmoate: con.TED_ProdcutName,
                                  onSubmitted: (f) {
                                    // con.validate();
                                    FocusScope.of(context).nextFocus();
                                  },
                                ),
                                const Gap(5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomTextFormField(
                                        onsubmitted: (v) {
                                          FocusScope.of(context).nextFocus();
                                          return null;
                                        },
                                        autofocus: true,
                                        hint: 'ارتفاع',
                                        width: 64,
                                        controller: con.TED_H),
                                    const Gap(4),
                                    CustomTextFormField(
                                        onsubmitted: (v) {
                                          FocusScope.of(context).nextFocus();
                                          return null;
                                        },
                                        autofocus: true,
                                        hint: 'عرض',
                                        width: 64,
                                        controller: con.TED_W),
                                    const Gap(4),
                                    CustomTextFormField(
                                        onsubmitted: (v) {
                                          FocusScope.of(context).nextFocus();
                                          return null;
                                        },
                                        autofocus: true,
                                        hint: 'طول',
                                        width: 64,
                                        controller: con.TED_L),
                                  ].reversed.toList(),
                                ),
                                const Gap(5),
                                CustomTextFormField(
                                    onsubmitted: (v) {
                                      FocusScope.of(context).nextFocus();
                                      return null;
                                    },
                                    autofocus: true,
                                    hint: 'كميه',
                                    width: 200,
                                    controller: con.TED_Quantity),
                                const Gap(5),
                                CustomTextFormField(
                                    onsubmitted: (v) {
                                      FocusScope.of(context).nextFocus();
                                      return null;
                                    },
                                    autofocus: true,
                                    hint: 'مكان الشراس',
                                    width: 200,
                                    controller: con.TED_purchePlace),
                                const Gap(5),
                                CustomTextFormField(
                                    ontap: () {
                                      showDatePicker(context: context, firstDate: DateTime(1950), lastDate: DateTime(2090)).then((onValue) {
                                        pickedDate = onValue;
                                        if (pickedDate != null) {
                                          con.TED_purcheDate.text = df.format(pickedDate!);
                                          FocusScope.of(context).nextFocus();
                                        }
                                      });
                                      return null;
                                    },
                                    readOnly: true,
                                    onsubmitted: (v) {
                                      return null;
                                    },
                                    autofocus: true,
                                    hint: 'تاريخ الشراء',
                                    width: 200,
                                    controller: con.TED_purcheDate),
                                const Gap(5),
                                SearchWithSugestions(onselected: (p0) {
                                  
                                },
                                    listOfsugestions: context.read<HiveDB>().reqreasons.values.map((toElement) => toElement.Reqreason).toList(),
                                    onSubmitted: (v) {
                                      FocusScope.of(context).nextFocus();
                                      return null;
                                    },
                                    autofocus: true,
                                    labal: 'سبب الطلب',
                                    TEC_forgovernmoate: con.TED_RequestReason),
                                const Gap(5),
                                CustomTextFormField(
                                    onsubmitted: (v) {
                                      FocusScope.of(context).nextFocus();
                                      return null;
                                    },
                                    autofocus: true,
                                    hint: 'سبب الطلب ب التفصيل',
                                    width: 200,
                                    controller: con.TED_RequestReasonINDetails),
                                const Gap(5),
                                ElevatedButton(
                                    onPressed: () {
                                      i.reqreqson = con.TED_RequestReason.text;
                                      i.reqreasonInDetails = con.TED_RequestReasonINDetails.text;
                                      i.pfodcut.ProductName = con.TED_ProdcutName.text;
                                      i.pfodcut.ProdcutType = con.TED_productType.text;
                                      i.pfodcut.L = con.TED_L.text.to_int();
                                      i.pfodcut.H = con.TED_H.text.to_int();
                                      i.pfodcut.W = con.TED_W.text.to_int();
                                      i.pfodcut.Quantity = con.TED_Quantity.text.to_int();
                                      i.pfodcut.PurcheLocation = con.TED_purchePlace.text;
                                      i.pfodcut.PurcheDate = pickedDate!;

                                      con.updateRequest(context, i);
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('تم'))
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ));
        },
        icon: const Icon(Icons.edit));
  }

  IconButton addNewMaintananceReq(BuildContext context) {
    return IconButton(
        onPressed: () {
          TEDcontrollers con = TEDcontrollers();

          showDialog(
              context: context,
              builder: (c) => Form(
                    key: con.formKey,
                    child: Consumer<HiveDB>(
                      builder: (context, myType, child) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SearchWithSugestions(onselected: (p0) {
                                
                              },
                                labal: 'العلامة التجاريه',
                                listOfsugestions: context.read<HiveDB>().prodcuts.values.map((convert) => convert.companyName).toList(),
                                TEC_forgovernmoate: con.TED_productType,
                                onSubmitted: (f) {
                                  // con.validate();
                                  FocusScope.of(context).nextFocus();
                                },
                              ),
                              const Gap(5),
                              SearchWithSugestions(onselected: (p0) {
                                
                              },
                                labal: 'اسم المنتج',
                                listOfsugestions:
                                    context.read<HiveDB>().prodcuts.values.where((test) => test.companyName == con.TED_productType.text).expand((e) => e.prodcuts).toList(),
                                TEC_forgovernmoate: con.TED_ProdcutName,
                                onSubmitted: (f) {
                                  // con.validate();
                                  FocusScope.of(context).nextFocus();
                                },
                              ),
                              const Gap(5),
                              const Gap(5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomTextFormField(
                                      onsubmitted: (v) {
                                        FocusScope.of(context).nextFocus();
                                        return null;
                                      },
                                      autofocus: true,
                                      hint: 'ارتفاع',
                                      width: 64,
                                      controller: con.TED_H),
                                  const Gap(4),
                                  CustomTextFormField(
                                      onsubmitted: (v) {
                                        FocusScope.of(context).nextFocus();
                                        return null;
                                      },
                                      autofocus: true,
                                      hint: 'عرض',
                                      width: 64,
                                      controller: con.TED_W),
                                  const Gap(4),
                                  CustomTextFormField(
                                      onsubmitted: (v) {
                                        FocusScope.of(context).nextFocus();
                                        return null;
                                      },
                                      autofocus: true,
                                      hint: 'طول',
                                      width: 64,
                                      controller: con.TED_L),
                                ].reversed.toList(),
                              ),
                              const Gap(5),
                              CustomTextFormField(
                                  onsubmitted: (v) {
                                    FocusScope.of(context).nextFocus();
                                    return null;
                                  },
                                  autofocus: true,
                                  hint: 'كميه',
                                  width: 200,
                                  controller: con.TED_Quantity),
                              const Gap(5),
                              CustomTextFormField(
                                  onsubmitted: (v) {
                                    FocusScope.of(context).nextFocus();
                                    return null;
                                  },
                                  autofocus: true,
                                  hint: 'مكان الشراس',
                                  width: 200,
                                  controller: con.TED_purchePlace),
                              const Gap(5),
                              CustomTextFormField(
                                  ontap: () {
                                    DateTime? pickedDate;
                                    showDatePicker(context: context, firstDate: DateTime(1950), lastDate: DateTime(2090)).then((onValue) {
                                      pickedDate = onValue;
                                      if (pickedDate != null) {
                                        con.TED_purcheDate.text = pickedDate!.toString();
                                        FocusScope.of(context).nextFocus();
                                      }
                                    });
                                    return null;
                                  },
                                  onsubmitted: (v) {
                                    FocusScope.of(context).nextFocus();
                                    return null;
                                  },
                                  autofocus: true,
                                  hint: 'تاريخ الشراء',
                                  width: 200,
                                  controller: con.TED_purcheDate),
                              const Gap(5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
                                      onPressed: () {},
                                      child: const Text(
                                        'الغاء',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                      )),
                                  const Gap(7),
                                  ElevatedButton(
                                      style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber)),
                                      onPressed: () {
                                        con.addrequest(context);
                                      },
                                      child: const Text(
                                        '    تم    ',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                                      ))
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ));
        },
        icon: const Icon(Icons.add));
  }

  Column pulledAndDeleverd3(RequstesMolel i, BuildContext context) {
    return Column(
      children: [
        if (i.maintainace == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (i.deleverd3 == true && i.actions.get_Date_of_action(MaintainanceRequestAction.deleverd3.getTitle).year != 0)
                Text(
                  ' ${df.format(i.deleverdDate3)} << ',
                  style: TStyle,
                ),
              if (i.deleverd3 == true)
                Tooltip(
                    message:
                        '${i.actions.get_Who_Of(MaintainanceRequestAction.deleverd3.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.deleverd3.getTitle))}',
                    child: const Icon(size: 22, Icons.info_outline)),
              Text(
                'تم التسليم',
                style: TStyle,
              ),
              Checkbox(
                  value: i.deleverd3,
                  onChanged: (b) async {
                    DateTime? picked;
                    if (b == true) {
                      picked = await showDatePicker(
                          helpText: "اختر تاريخ المعاينه",
                          context: context,
                          initialDate: DateTime.now(),
                          initialDatePickerMode: DatePickerMode.day,
                          firstDate: DateTime(2015),
                          lastDate: DateTime.now());
                      if (picked != null) {
                        i.deleverd3 = !i.deleverd3;
                        i.deleverdDate3=picked;
                        i.actions.add(MaintainanceRequestAction.deleverd3.add);
                        con.updateRequest(context, i);
                      }
                    }
                  }),
            ],
          ),
        if (i.maintainace == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (i.pulled3 == true && i.actions.get_Date_of_action(MaintainanceRequestAction.pulled3.getTitle).year != 0)
                Text(
                  ' ${df.format(i.pulledDate3)} << ',
                  style: TStyle,
                ),
              if (i.pulled3 == true)
                Tooltip(
                    message:
                        '${i.actions.get_Who_Of(MaintainanceRequestAction.deleverd3.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.deleverd3.getTitle))}',
                    child: const Icon(size: 22, Icons.info_outline)),
              Text(
                'تم السحب',
                style: TStyle,
              ),
              Checkbox(
                  value: i.pulled3,
                  onChanged: (b) async {
                    DateTime? picked;
                    if (b == true) {
                      picked = await showDatePicker(
                          helpText: "اختر تاريخ المعاينه",
                          context: context,
                          initialDate: DateTime.now(),
                          initialDatePickerMode: DatePickerMode.day,
                          firstDate: DateTime(2015),
                          lastDate: DateTime.now());
                      if (picked != null) {
                        i.pulled3 = !i.pulled3;
                        i.pulledDate3=picked;
                        i.actions.add(MaintainanceRequestAction.pulled3.add);
                        con.updateRequest(context, i);
                      }
                    }
                  }),
            ],
          )
      ].reversed.toList(),
    );
  }

  Column pulledAndDeleverd2(RequstesMolel i, BuildContext context) {
    return Column(
      children: [
        if (i.replaceTosnotherModel == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (i.deleverd2 == true && i.actions.get_Date_of_action(MaintainanceRequestAction.deleverd2.getTitle).year != 0)
                Text(
                  ' ${df.format(i.deleverdDate2)} << ',
                  style: TStyle,
                ),
              if (i.deleverd2 == true)
                Tooltip(
                    message:
                        '${i.actions.get_Who_Of(MaintainanceRequestAction.deleverd2.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.deleverd2.getTitle))}',
                    child: const Icon(size: 22, Icons.info_outline)),
              Text(
                'تم التسليم',
                style: TStyle,
              ),
              Checkbox(
                  value: i.deleverd2,
                  onChanged: (b) async {
                    DateTime? picked;
                    if (b == true) {
                      picked = await showDatePicker(
                          helpText: "اختر تاريخ ",
                          context: context,
                          initialDate: DateTime.now(),
                          initialDatePickerMode: DatePickerMode.day,
                          firstDate: DateTime(2015),
                          lastDate: DateTime.now());
                      if (picked != null) {
                        i.deleverd2 = !i.deleverd2;
                        i.deleverdDate2=picked;
                        i.actions.add(MaintainanceRequestAction.deleverd2.add);
                        con.updateRequest(context, i);
                      }
                    }
                  }),
            ],
          ),
        if (i.replaceTosnotherModel == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (i.pulled2 == true && i.pulledDate2.year != 0)
                Text(
                  ' ${df.format(i.pulledDate2)} << ',
                  style: TStyle,
                ),
              if (i.pulled2 == true)
                Tooltip(
                    message:
                        '${i.actions.get_Who_Of(MaintainanceRequestAction.pulled2.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.pulled2.getTitle))}',
                    child: const Icon(size: 22, Icons.info_outline)),
              Text(
                'تم السحب',
                style: TStyle,
              ),
              Checkbox(
                  value: i.pulled2,
                  onChanged: (b) async {
                    DateTime? picked;
                    if (b == true) {
                      picked = await showDatePicker(
                          helpText: "اختر تاريخ السحب",
                          context: context,
                          initialDate: DateTime.now(),
                          initialDatePickerMode: DatePickerMode.day,
                          firstDate: DateTime(2015),
                          lastDate: DateTime.now());
                      if (picked != null) {
                        i.pulled2 = !i.pulled2;
                        i.pulledDate2=picked;
                        i.actions.add(MaintainanceRequestAction.pulled2.add);
                        con.updateRequest(context, i);
                      }
                    }
                  }),
            ],
          )
      ].reversed.toList(),
    );
  }

  Column pulledAndDeleverd1(RequstesMolel i, BuildContext context) {
    return Column(
      children: [
        if (i.replaceToSameModel == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (i.deleverd1 == true && i.actions.get_Date_of_action(MaintainanceRequestAction.deleverd1.getTitle).year != 0)
                Text(
                  ' ${df.format(i.deleverdDate1)} << ',
                  style: TStyle,
                ),
              if (i.deleverd1 == true)
                Tooltip(
                    message:
                        '${i.actions.get_Who_Of(MaintainanceRequestAction.deleverd1.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.deleverd1.getTitle))}',
                    child: const Icon(size: 22, Icons.info_outline)),
              Text(
                'تم التسليم',
                style: TStyle,
              ),
              Checkbox(
                  value: i.deleverd1,
                  onChanged: (b) async {
                    DateTime? picked;
                    if (b == true) {
                      picked = await showDatePicker(
                          helpText: "اختر تاريخ المعاينه",
                          context: context,
                          initialDate: DateTime.now(),
                          initialDatePickerMode: DatePickerMode.day,
                          firstDate: DateTime(2015),
                          lastDate: DateTime.now());
                      if (picked != null) {
                        i.deleverd1 = !i.deleverd1;
                        i.deleverdDate1=picked;
                        i.actions.add(MaintainanceRequestAction.deleverd1.add);
                        con.updateRequest(context, i);
                      }
                    }
                  }),
            ],
          ),
        if (i.replaceToSameModel == true)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (i.pulled1 == true && i.actions.get_Date_of_action(MaintainanceRequestAction.pulled1.getTitle).year != 0)
                Text(
                  ' ${df.format(i.pulledDate1)} << ',
                  style: TStyle,
                ),
              if (i.pulled3 == true)
                Tooltip(
                    message:
                        '${i.actions.get_Who_Of(MaintainanceRequestAction.pulled1.getTitle)} ${YMDHM.format(i.actions.get_Date_of_action(MaintainanceRequestAction.pulled1.getTitle))}',
                    child: const Icon(size: 22, Icons.info_outline)),
              Text(
                'تم السحب',
                style: TStyle,
              ),
              Checkbox(
                  value: i.pulled1,
                  onChanged: (b) async {
                    DateTime? picked;
                    if (b == true) {
                      picked = await showDatePicker(
                          helpText: "اختر تاريخ المعاينه",
                          context: context,
                          initialDate: DateTime.now(),
                          initialDatePickerMode: DatePickerMode.day,
                          firstDate: DateTime(2015),
                          lastDate: DateTime.now());
                      if (picked != null) {
                        i.pulled1 = !i.pulled1;
                        i.pulledDate1=picked;
                        i.actions.add(MaintainanceRequestAction.pulled1.add);
                        con.updateRequest(context, i);
                      }
                    }
                  }),
            ],
          )
      ].reversed.toList(),
    );
  }
}

class Line extends StatelessWidget {
  const Line({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      color: Colors.black,
    );
  }
}
