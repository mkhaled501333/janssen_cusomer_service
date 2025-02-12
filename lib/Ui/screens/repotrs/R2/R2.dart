// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssen_cusomer_service/Ui/pdf/pdf.dart';
import 'package:janssen_cusomer_service/Ui/pdf/pdfContent.dart';
import 'package:janssen_cusomer_service/Ui/screens/repotrs/R1.dart';
import 'package:janssen_cusomer_service/app/funcs.dart';
import 'package:janssen_cusomer_service/models/request.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:janssen_cusomer_service/app/actions.dart';
import 'package:janssen_cusomer_service/app/extentions.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';
import 'package:janssen_cusomer_service/models/customer.dart';
import 'package:janssen_cusomer_service/models/models.dart';
import 'package:janssen_cusomer_service/models/ticket.dart';

final ValueNotifier<int> counter = ValueNotifier<int>(0);
String x = "0";

DateTime? initionldateF;
DateTime? firstdateF;
DateTime? pickeddateF;
DateTime? pickeddateTo;

class R22 extends StatefulWidget {
  R22({super.key});
  @override
  State<R22> createState() => _R22State();
}

class _R22State extends State<R22> {
  @override
  void initState() {
    super.initState();
  }

  List<dynamic> selected = [];

  TextEditingController contrller = TextEditingController();

  final textstyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 13.7,
      color: Color.fromARGB(255, 112, 110, 110));

  @override
  Widget build(BuildContext context) {
    List<CustomerModel> customers =context.read<HiveDB>().customers.values.toList();
    List<TicketModel> tickets = customers.expand((c) => c.tickets).toList().filterDatefrom(pickeddateF).filterDateTo(pickeddateTo);
    List<RequstesMolel> reqests =  tickets.expand((element) => element.requests,).toList();

        if (firstdateF!=null) {
          if (tickets.isNotEmpty) {
             firstdateF=tickets.map((e) => e.datecreated,).min;
          }
         
        }
       var fdate= customers.expand((c) => c.tickets).toList().map((e) => e.datecreated,).min;
        firstdateF ??= fdate;
        pickeddateF ??= fdate;
        initionldateF ??= fdate;
        pickeddateTo ??= DateTime.now();
    // print(tickets.map((e) => e.ticket_Num,));
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
        actions: const [],
        title: Row(
          children: [
            ValueListenableBuilder<int>(
              valueListenable: counter,
              builder: (c, value, _) {
                return Row(
                  children: [
                    Text(
                      'allTickets ( ${tickets.toSet().toList().length} )',
                      style: textstyle,
                    ),
                    Text(
                      'selected',
                      style: textstyle,
                    ),
                    Text(
                      ' ($value)',
                      style: textstyle,
                    ),
                  ],
                );
              },
            ),
            Row(
              children: [
                IconButton(
                    tooltip: 'يانسن',
                    iconSize: 20,
                    onPressed: () {
                      permission().then((value) async {
                        PDF1_multi.generate(
                                context,
                                selected
                                    .toSet()
                                    .toList()
                                    .map(
                                      (e) => s(
                                          c: customers.firstWhere(
                                            (element) => element.tickets
                                                .where(
                                                  (g) =>
                                                      g.ticket_Num == e as int,
                                                )
                                                .isNotEmpty,
                                          ),
                                          t: tickets.firstWhere(
                                            (t) => t.ticket_Num == e as int,
                                          )),
                                    )
                                    .toList())
                            .then((value) =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (e) => PDfpreview(
                                          v: value.save(),
                                        ))));
                      });
                    },
                    icon: const Icon(Icons.picture_as_pdf)),
                IconButton(
                    tooltip: "انجلندر",
                    iconSize: 20,
                    onPressed: () {
                      permission().then((value) async {
                        PDF2_multi.generate(
                                context,
                                selected
                                    .toSet()
                                    .toList()
                                    .map(
                                      (e) => s(
                                          c: customers.firstWhere(
                                            (element) => element.tickets
                                                .where(
                                                  (g) =>
                                                      g.ticket_Num == e as int,
                                                )
                                                .isNotEmpty,
                                          ),
                                          t: tickets.firstWhere(
                                            (t) => t.ticket_Num == e as int,
                                          )),
                                    )
                                    .toList())
                            .then((value) =>
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (e) => PDfpreview(
                                          v: value.save(),
                                        ))));
                      });
                    },
                    icon: const Icon(Icons.picture_as_pdf)),
              ],
            ),
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: pickeddateTo,
                      firstDate: pickeddateF!,
                      lastDate:  DateTime.now());

                  if (pickedDate != null) {
                   pickeddateTo= pickedDate;
                   setState(() {
                     
                   });
                  } else {}
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      // decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.teal), borderRadius: BorderRadius.circular(5)),
                      child: Text(
                       pickeddateTo!.formatt_yMd(),
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 97, 92, 92),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                      "الى",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            const Text('-'),
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate:initionldateF,
                      firstDate:customers.expand((element) => element.tickets,).isEmpty?DateTime(2000): fdate,
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    pickeddateF= pickedDate;
                    initionldateF=pickedDate;
                   setState(() {
                     
                   });
                  } else {}
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(7),
                      // decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.teal), borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        initionldateF!.formatt_yMd(),
                        style: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 97, 92, 92),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                      "من",
                      style:
                          TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
          ],
        ),
      ),
      body: SfDataGridTheme(
        data: const SfDataGridThemeData(
          gridLineStrokeWidth: 1,
          // sortIcon: SizedBox(),
          // filterIcon: SizedBox()
        ),
        child: SfDataGrid(
          onSelectionChanged: (v, g) {
            selected.addAll(
                v.map((e) => e.getCells().first.value).toSet().toList());

            g.map((e) => e.getCells().first.value).forEach(
              (h) {
                selected.remove(h);
              },
            );

            counter.value = selected.toSet().toList().length;
          },
          showCheckboxColumn: true,
          checkboxColumnSettings: const DataGridCheckboxColumnSettings(),
          selectionMode: SelectionMode.multiple,
          onQueryRowHeight: (details) {
            return details.rowIndex == 0 ? 30.0 : 27.0;
          },
          frozenColumnsCount: 2,
          footerFrozenColumnsCount: 1,
          source: DataSource(
              customers: customers, tickets: tickets, reqests: reqests),
          columnWidthMode: ColumnWidthMode.fill,
          allowSorting: true,
          allowMultiColumnSorting: true,
          allowFiltering: true,
          showSortNumbers: true,
          allowEditing: true,
          headerGridLinesVisibility: GridLinesVisibility.both,
          isScrollbarAlwaysShown: true,
          showHorizontalScrollbar: true,
          gridLinesVisibility: GridLinesVisibility.horizontal,
          highlightRowOnHover: true,
          columns: <GridColumn>[
            GridColumn(
                allowFiltering: true,
                width: 111,
                columnName: 'ticketnum',
                label: const Text(
                  'ticket.no',
                  style: TextStyle(fontSize: 12),
                )),
            GridColumn(
                allowFiltering: true,
                allowEditing: true,
                width: 100,
                columnName: 'date',
                label: Center(
                  child: Text(
                    ' Date',
                    style: textstyle,
                  ),
                )),
            GridColumn(
                allowFiltering: true,
                allowEditing: true,
                width: 118,
                columnName: 'statues',
                label: Center(
                  child: Text(
                    'Statues',
                    style: textstyle,
                  ),
                )),
            GridColumn(
                allowFiltering: true,
                allowEditing: true,
                width: 144,
                columnName: 'client',
                label: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 219, 219, 219),
                            borderRadius: BorderRadius.circular(4)),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text("11"),
                        ),
                      ),
                      const Gap(3),
                      Text(
                        'Client',
                        style: textstyle,
                      ),
                    ],
                  ),
                )),
            GridColumn(
                allowFiltering: true,
                width: 112,
                columnName: 'phone',
                label: Center(
                  child: Text(
                    'phone',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                allowFiltering: true,
                width: 112,
                columnName: 'governomate',
                label: Center(
                  child: Text(
                    'Governomate',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                allowFiltering: true,
                width: 111,
                columnName: 'city',
                label: Center(
                  child: Text(
                    'City',
                    overflow: TextOverflow.ellipsis,
                    style: textstyle,
                  ),
                )),
            GridColumn(
                allowSorting: false,
                allowFiltering: true,
                width: 111,
                columnName: 'brand',
                label: const Center(child: Text('brand'))),
            GridColumn(
                allowFiltering: true,
                width: 190,
                columnName: 'Size',
                label: Center(
                  child: Text(
                    'Size',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                allowFiltering: true,
                width: 111,
                columnName: 'action',
                label: Center(
                  child: Text(
                    'action',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                allowFiltering: true,
                width: 130,
                columnName: 'المعاينه',
                label: Center(
                  child: Text(
                    'المعاينه',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                allowFiltering: true,
                width: 120,
                columnName: 'السحب',
                label: Center(
                  child: Text(
                    'السحب',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                allowFiltering: true,
                width: 120,
                columnName: 'التسليم',
                label: Center(
                  child: Text(
                    'التسليم',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                visible: false,
                allowFiltering: true,
                width: 112,
                columnName: 'c',
                label: Center(
                  child: Text(
                    'c',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
            GridColumn(
                visible: false,
                allowFiltering: true,
                width: 112,
                columnName: 't',
                label: Center(
                  child: Text(
                    't',
                    style: textstyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class NewWidget0 extends StatefulWidget {
  const NewWidget0({
    Key? key,
    required this.data,
    required this.selected,
    required this.controller,
  }) : super(key: key);

  final List<String> data;
  final List<String> selected;
  final TextEditingController controller;
  @override
  State<NewWidget0> createState() => _NewWidget0State();
}

class _NewWidget0State extends State<NewWidget0> {
  @override
  Widget build(BuildContext context) {
    final data = widget.data
        .where((test) => test.contains(widget.controller.text))
        .toList();
    return Column(
      children: [
        SizedBox(
          height: 25,
          width: 280,
          child: TextField(
            controller: widget.controller,
            onChanged: (value) {
              setState(() {});
            },
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(top: 4),
                prefixIcon: const Icon(Icons.search_outlined),
                hoverColor: Colors.orange,
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 180, 4)),
                    borderRadius: BorderRadius.circular(9)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(9),
                    borderSide:
                        const BorderSide(color: Colors.orange, width: .5)),
                hintStyle: const TextStyle(
                  fontSize: 12,
                ),
                hintText: 'Find '),
          ),
        ),
        const Gap(10),
        SizedBox(
          width: 290,
          height: 120,
          child: ScrollbarTheme(
            data: const ScrollbarThemeData(
                thickness: WidgetStatePropertyAll(7),
                radius: Radius.circular(66),
                trackVisibility: WidgetStatePropertyAll(true),
                trackColor:
                    WidgetStatePropertyAll(Color.fromARGB(255, 215, 215, 215)),
                thumbColor: WidgetStatePropertyAll(Colors.grey),
                thumbVisibility: WidgetStatePropertyAll(true),
                interactive: true),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => Material(
                color: const Color.fromARGB(255, 251, 251, 251),
                child: InkWell(
                  hoverColor: Colors.grey.shade400,
                  focusColor: Colors.red,
                  highlightColor: Colors.cyan,
                  splashColor: Colors.grey.shade300,
                  onTap: () {
                    setState(() {
                      if (widget.selected.contains(data[index]) == true) {
                        widget.selected.remove(data[index]);
                      } else {
                        widget.selected.add(data[index]);
                      }
                    });
                  },
                  child: Row(
                    children: [
                      widget.selected.contains(data[index]) == true
                          ? const Icon(
                              fill: 1,
                              size: 20,
                              weight: 100,
                              Icons.check_box_rounded,
                              color: Color.fromARGB(255, 2, 13, 109),
                            )
                          : const Icon(
                              size: 20,
                              weight: 1,
                              Icons.check_box_outline_blank_rounded,
                              color: Colors.black,
                            ),
                      const Gap(10),
                      Text(
                        data[index],
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color:
                                widget.selected.contains(widget.data[index]) ==
                                        true
                                    ? const Color.fromARGB(255, 252, 125, 41)
                                    : Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

int i = -1;
int h = -1;

class DataSource extends DataGridSource {
  DataSource(
      {required List<CustomerModel> customers,
      required List<TicketModel> tickets,
      required List<RequstesMolel> reqests}) {
    _employeeData = reqests.map<DataGridRow>((req) {
      final ticket = tickets.firstWhere(
        (element) => element.ticket_ID == req.ticket_ID,
      );
      return DataGridRow(cells: [
        DataGridCell<int>(columnName: 'ticketnum', value: ticket.ticket_Num),
        DataGridCell<String>(
            columnName: 'date',
            value: ticket.actions
                .get_Date_of_action(TicketAction.creat_NewTicket.getTitle)
                .formatt_yMd()),
        DataGridCell<bool>(columnName: 'statues', value: ticket.Ticketresolved),
        DataGridCell<String>(
            columnName: 'client',
            value: customers
                .firstWhere((f) => f.customer_ID == ticket.customer_ID)
                .cusotmerName),
        DataGridCell<List<String>>(
            columnName: 'phone',
            value: customers
                .firstWhere((test) => test.customer_ID == ticket.customer_ID)
                .mobilenum),
        DataGridCell<String>(
            columnName: 'governomate',
            value: customers
                .firstWhere((f) => f.customer_ID == ticket.customer_ID)
                .covernorate),
        DataGridCell<String>(
            columnName: 'city',
            value: customers
                .firstWhere((f) => f.customer_ID == ticket.customer_ID)
                .area),
        DataGridCell<String>(
            columnName: 'brand', value: req.pfodcut.ProdcutType),
        DataGridCell<String>(
            columnName: 'Size',
            value: "${req.pfodcut.L}*${req.pfodcut.W}*${req.pfodcut.H}"),
        DataGridCell<String>(columnName: 'action', value: getactiontittle(req)),
        DataGridCell<String>(
            columnName: 'المعاينه',
            value: req.visited == true ? 'تمت المعاينه' : 'لم تتم المعاينه'),
        DataGridCell<String>(columnName: 'السحب', value: pull(req)),
        DataGridCell<String>(columnName: 'التسليم', value: delvery(req)),
        DataGridCell<CustomerModel>(
            columnName: 'c',
            value: customers
                .firstWhere((e) => e.customer_ID == ticket.customer_ID)),
        DataGridCell<TicketModel>(columnName: 't', value: ticket),
      ]);
    }).toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  int old = 0;
  int currentColor = 1;
  // final firstcolor=const Color.fromARGB(255, 204, 213, 240);
  // final secondcolor=const Color.fromARGB(255, 242, 245, 252);

  // final firstcolor=const Color.fromARGB(255, 235, 249, 236);
  // final secondcolor=const Color.fromARGB(255, 253, 245, 224);

  // final firstcolor=const Color.fromARGB(255, 252, 187, 185);
  // final secondcolor=const Color.fromARGB(255, 198, 233, 191);

  final firstcolor = const Color.fromARGB(255, 190, 221, 238);
  final secondcolor = const Color.fromARGB(255, 239, 239, 239);

  // final firstcolor=const Color.fromARGB(255, 230, 247, 237);
  // final secondcolor=const Color.fromARGB(255, 255, 255, 255);

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    Color getRowBackgroundColor(int index) {
      if (index == old) {
        if (currentColor == 1) {
          return firstcolor;
        } else {
          return secondcolor;
        }
      } else {
        if (currentColor == 1) {
          currentColor = 2;
        } else {
          currentColor = 1;
        }
        if (currentColor == 2) {
          return secondcolor;
        } else {
          return firstcolor;
        }
      }
    }

    return DataGridRowAdapter(
        color: getRowBackgroundColor(row.getCells().first.value),
        cells: row.getCells().map<Widget>((e) {
          old = row.getCells().first.value;
          final t = row.getCells().firstWhere((e) => e.columnName == 't').value
              as TicketModel;
          final c = row.getCells().firstWhere((e) => e.columnName == 'c').value
              as CustomerModel;
          return switch (e.columnName) {
            "ticketnum" => Row(
                children: [
                  Builder(builder: (context) {
                    return TextButton(
                        onPressed: () {
                          context.read<HiveDB>().chosenTicket = t;
                          context.read<HiveDB>().shosenCustomer = c;
                          Navigator.of(context).pop();
                          context.read<HiveDB>().Refresh_UI();
                        },
                        child: Text(e.value.toString()));
                  }),
                ],
              ),
            "المعاينه" => e.value as String == 'تمت المعاينه'
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
            "السحب" => e.value as String == 'تم السحب'
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
            "التسليم" => e.value as String == 'تم التسليم'
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
            "statues" => SizedBox(
                height: 20,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                  child: switch (e.value as bool) {
                    true => const Resolved(),
                    _ => const Opend()
                  },
                ),
              ),
            _ => Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(0.0),
                child: Tooltip(
                  message: e.value.toString(),
                  child: Text(
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.w500),
                    e.value.toString(),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
          };
        }).toList());
  }
}

class Resolved extends StatelessWidget {
  const Resolved({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 188, 218, 172),
          borderRadius: BorderRadius.circular(9)),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(8),
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 115, 126, 102),
              radius: 4,
            ),
            Gap(4),
            Text(
              "Resolved",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
            Gap(8),
          ],
        ),
      ),
    );
  }
}

class Opend extends StatelessWidget {
  const Opend({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 174, 140),
          borderRadius: BorderRadius.circular(9)),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(8),
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 133, 106, 87),
              radius: 4,
            ),
            Gap(4),
            Text(
              "Opend",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Gap(8),
          ],
        ),
      ),
    );
  }
}

String getactiontittle(RequstesMolel req) {
  if (req.replaceToSameModel == true) {
    return 'استبدال لنفس النوع';
  } else if (req.replaceTosnotherModel == true) {
    return 'استبدال لنوع اخر';
  } else if (req.maintainace == true) {
    return 'صيانه';
  } else {
    return 'غير محدد';
  }
}

String pull(RequstesMolel req) {
  if (req.replaceToSameModel == true && req.pulled1 == false) {
    return 'لم يتم السحب';
  } else if (req.replaceTosnotherModel == true && req.pulled2 == false) {
    return 'لم يتم السحب';
  } else if (req.maintainace == true && req.pulled3 == false) {
    return 'لم يتم السحب';
  } else if (req.replaceToSameModel == false &&
      req.maintainace == false &&
      req.replaceTosnotherModel == false) {
    return 'لم يتم السحب';
  } else {
    return 'تم السحب';
  }
}

String delvery(RequstesMolel req) {
  if (req.replaceToSameModel == true && req.deleverd1 == false) {
    return 'لم يتم التسليم';
  } else if (req.replaceTosnotherModel == true && req.deleverd2 == false) {
    return 'لم يتم التسليم';
  } else if (req.maintainace == true && req.deleverd3 == false) {
    return 'لم يتم التسليم';
  } else if (req.replaceToSameModel == false &&
      req.maintainace == false &&
      req.replaceTosnotherModel == false) {
    return 'لم يتم التسليم';
  } else {
    return 'تم التسليم';
  }
}

class DatepickerFrom4 extends StatelessWidget {
  const DatepickerFrom4({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<HiveDB>().pickedDateFrom = DateTime.now();
    return Consumer<HiveDB>(
      builder: (context, myType, child) {
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: myType.pickedDateFrom,
                      firstDate: myType.AllDatesOfOfData().min,
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    myType.pickedDateFrom = pickedDate;
                    myType.Refresh_UI();
                  } else {}
                },
                child: Column(
                  children: [
                    const Text(
                      "من",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.pickedDateFrom!.formatt_yMd(),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 97, 92, 92),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}

class DatepickerTo4 extends StatelessWidget {
  const DatepickerTo4({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<HiveDB>().pickedDateFrom = DateTime.now();

    context.read<HiveDB>().pickedDateTO = DateTime.now();
    return Consumer<HiveDB>(
      builder: (context, myType, child) {
        if (myType.pickedDateFrom!.microsecondsSinceEpoch >
            myType.pickedDateTO!.microsecondsSinceEpoch) {
          myType.pickedDateTO = myType.pickedDateFrom;
        }
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: myType.pickedDateTO!,
                      firstDate: myType.pickedDateFrom!,
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    myType.pickedDateTO = pickedDate;
                    myType.Refresh_UI();
                  } else {}
                },
                child: Column(
                  children: [
                    const Text(
                      "الى",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.pickedDateTO!.formatt_yMd(),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 97, 92, 92),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
