// ignore_for_file: must_be_immutable

import 'package:davi/davi.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssen_cusomer_service/Ui/base.dart';
import 'package:janssen_cusomer_service/Ui/recourses/sharedWidgets/textformfield.dart';
import 'package:janssen_cusomer_service/Ui/screens/rightCard/rightCard.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';
import 'package:janssen_cusomer_service/main.dart';
import 'package:janssen_cusomer_service/models/callinfo.dart';
import 'package:provider/provider.dart';

class calls extends StatelessWidget {
  calls({
    super.key,
    required this.vm,
  });

  final TEDcontrollers vm;
  DaviModel<CallInfo>? model;

  @override
  Widget build(BuildContext context) {
    return Consumer<HiveDB>(
      builder: (context, myType, child) {
        model = DaviModel<CallInfo>(multiSortEnabled: true, rows: myType.chosenTicket!.calls, columns: [
          DaviColumn(
              resizable: true,
              // grow: 1,
              name: 'نوع المكالمه',
              stringValue: (row) => row.calltype),
          DaviColumn(
              width: 160,
              // grow: 2,
              name: 'تاريخ المكالمه',
              stringValue: (row) => YMDHM.format(row.callDate)),
          DaviColumn(
              resizable: true,
              width: MediaQuery.of(context).size.width * .17,
              // grow: 2,
              name: 'الغرص من المكالمه',
              stringValue: (row) => row.callReason),
          DaviColumn(
              width: MediaQuery.of(context).size.width * .17,
              // grow: 2,
              name: 'نتيجة المكالمه',
              stringValue: (row) => row.callresult),
          DaviColumn(
              width: MediaQuery.of(context).size.width * .11,
              // grow: 2,
              name: 'متلقى المكالمه',
              stringValue: (row) => row.callRecipient),
        ]);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.amber)),
                      onPressed: () {
                        var x = 'صادر';
                        TEDcontrollers vm = TEDcontrollers();
                        showDialog(
                            context: context,
                            builder: (c) => AlertDialog(
                                  content: SizedBox(
                                    height: 222,
                                    child: Form(
                                      key: vm.formKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SearchWithSugestions(onselected: (p0) {
                                              
                                            },
                                                listOfsugestions: myType.callTypes.values.map((e) => e.callType).toList(),
                                                validator: (v) {
                                                  if (v != '') {
                                                    return null;
                                                  } else {
                                                    return 'فارغ';
                                                  }
                                                },
                                                onSubmitted: (v) {
                                                  FocusScope.of(context).nextFocus();
                                                  return null;
                                                },
                                                autofocus: true,
                                                labal: 'الغرض من المكالمه',
                                                TEC_forgovernmoate: vm.TED_callReason),
                                            const Gap(11),
                                            CustomTextFormField(
                                                validator: (v) {
                                                  if (v != '') {
                                                    return null;
                                                  } else {
                                                    return 'فارغ';
                                                  }
                                                },
                                                onsubmitted: (v) {
                                                  FocusScope.of(context).nextFocus();
                                                  return null;
                                                },
                                                autofocus: true,
                                                hint: 'نتيجة المكالمه',
                                                width: 200,
                                                controller: vm.TED_callresult),
                                            ElevatedButton(
                                                onPressed: () {
                                                  vm.addcall(context, x);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('ok'))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      child: const Text(
                        'مكالمة صادره',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      )),
                  const Gap(5),
                  const Icon(Icons.arrow_downward_rounded),
                  const Text(
                    "المكالمات",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const Gap(5),
                  TextButton(
                      style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 207, 15, 134))),
                      onPressed: () {
                        var x = 'وارد';
                        TEDcontrollers vm = TEDcontrollers();
                        showDialog(
                            context: context,
                            builder: (c) => AlertDialog(
                                  content: SizedBox(
                                    height: 222,
                                    child: Form(
                                      key: vm.formKey,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            SearchWithSugestions(onselected: (p0) {
                                              
                                            },
                                                listOfsugestions: myType.callTypes.values.map((e) => e.callType).toList(),
                                                validator: (v) {
                                                  if (v != '') {
                                                    return null;
                                                  } else {
                                                    return 'فارغ';
                                                  }
                                                },
                                                onSubmitted: (v) {
                                                  FocusScope.of(context).nextFocus();
                                                  return null;
                                                },
                                                autofocus: true,
                                                labal: 'الغرض من المكالمه',
                                                TEC_forgovernmoate: vm.TED_callReason),
                                            CustomTextFormField(
                                                validator: (v) {
                                                  if (v != '') {
                                                    return null;
                                                  } else {
                                                    return 'فارغ';
                                                  }
                                                },
                                                onsubmitted: (v) {
                                                  FocusScope.of(context).nextFocus();
                                                  return null;
                                                },
                                                autofocus: true,
                                                hint: 'نتيجة المكالمه',
                                                width: 200,
                                                controller: vm.TED_callresult),
                                            ElevatedButton(
                                                onPressed: () {
                                                  vm.addcall(context, x);
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('ok'))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ));
                      },
                      child: const Text(
                        'مكالمة وارده',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .38,
                height: MediaQuery.of(context).size.height * .38,
                child: DaviTheme(
                    data: DaviThemeData(
                        header: HeaderThemeData(color: Colors.green[50], bottomBorderHeight: 1, bottomBorderColor: Colors.blue),
                        headerCell: HeaderCellThemeData(
                            height: 40,
                            alignment: Alignment.center,
                            textStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            resizeAreaWidth: 10,
                            resizeAreaHoverColor: Colors.blue.withOpacity(.5),
                            sortIconColors: SortIconColors.all(const Color.fromARGB(255, 243, 33, 121)),
                            expandableName: false),
                        row: RowThemeData(color: RowThemeData.zebraColor(evenColor: Colors.green[50]))),
                    child: Davi<CallInfo>(
                      model,
                      onRowTap: (call) {
                        showDialog(
                            context: context,
                            builder: (c) => AlertDialog(
                                  content: SizedBox(
                                    width: 120,
                                    height: 150,
                                    child: SingleChildScrollView(child: Text(style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600), '${call.callresult}')),
                                  ),
                                ));
                      },
                    )))
          ],
        );
      },
    );
  }
}
