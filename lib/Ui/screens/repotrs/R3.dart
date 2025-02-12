// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:janssen_cusomer_service/app/extentions.dart';
import 'package:janssen_cusomer_service/data/localDB.dart';
import 'package:janssen_cusomer_service/models/customer.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

TextStyle textstyle11 = const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
// Future<void> createAndopenEXL(
//   GlobalKey<SfDataGridState> mkey,
// ) async {
//   permission();
//   Directory? appDocDirectory = await getExternalStorageDirectory();

//   final Workbook workbook = Workbook();
//   final Worksheet worksheet = workbook.worksheets[0];
//   mkey.currentState!.exportToExcelWorksheet(worksheet);
//   final List<int> bytes = workbook.saveAsStream();
//   File('${appDocDirectory!.path}/${formatwitTime2.format(DateTime.now())}تفاصيل البلوكات.xlsx')
//       .writeAsBytes(bytes, flush: true)
//       .then((value) => FileHandleApi.openFile(value));
// }

class R3 extends StatelessWidget {
  R3({super.key});

  var columns = <GridColumn>[
    GridColumn(
        width: 111,
        allowFiltering: true,
        columnName: '1',
        label: Container(
            padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Text(
              'نوع',
              style: textstyle11,
            ))),
    GridColumn(
        width: 111,
        allowFiltering: true,
        columnName: '2',
        label: Container(
            padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Text(
              'تاريخ',
              style: textstyle11,
            ))),
    GridColumn(
        width: 111,
        allowFiltering: true,
        columnName: '3',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'الغرض',
              style: textstyle11,
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        width: 111,
        allowFiltering: true,
        columnName: '4',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'النتيجه',
              style: textstyle11,
            ))),
    GridColumn(
        width: 130,
        allowFiltering: true,
        columnName: '5',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'المتقلى',
              style: textstyle11,
            ))),
    GridColumn(
        width: 222,
        allowFiltering: true,
        columnName: '6',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'اسم العميل',
              style: textstyle11,
            ))),
    GridColumn(
        width: 222,
        allowFiltering: true,
        columnName: '7',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'رقم التيلفون',
              style: textstyle11,
            ))),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfDataGridState> kkkkk = GlobalKey<SfDataGridState>();

    return Consumer<HiveDB>(builder: (context, blocks, child) {
      return Scaffold(
          appBar: AppBar(
            actions: const [
              // IconButton(onPressed: () {}, icon: const Icon(Icons.date_range)),
              // IconButton(
              //   onPressed: () async {
              //     // createAndopenEXL(kkkkk);
              //   },
              //   icon: const Icon(Icons.explicit_outlined),
              // ),
            ],
          ),
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(scrollbars: false),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: SfDataGrid(
                  isScrollbarAlwaysShown: true,
                  showHorizontalScrollbar: true,
                  allowPullToRefresh: true,
                  tableSummaryRows: [
                    GridTableSummaryRow(
                        showSummaryInRow: true,
                        title: 'Total  Count: {Count}',
                        titleColumnSpan: 3,
                        columns: [
                          const GridSummaryColumn(name: 'Count', columnName: 'num', summaryType: GridSummaryType.count),
                        ],
                        position: GridTableSummaryRowPosition.top),
                  ],
                  allowSwiping: true,
                  swipeMaxOffset: 100.0,
                  endSwipeActionsBuilder: (BuildContext context, DataGridRow row, int rowIndex) {
                    return GestureDetector(
                        onTap: () {},
                        child: Container(
                            color: Colors.redAccent,
                            child: const Center(
                              child: Icon(Icons.delete),
                            )));
                  },
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  selectionMode: SelectionMode.multiple,
                  navigationMode: GridNavigationMode.cell,
                  key: kkkkk,
                  allowSorting: true,
                  allowMultiColumnSorting: true,
                  allowTriStateSorting: true,
                  allowFiltering: true,
                  source: EmployeeDataSource22(context, coumingData: blocks.customers.values.toList()),
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: columns,
                ),
              ),
            ),
          ));
    });
  }
}

dynamic newCellValue;
TextEditingController editingController = TextEditingController();

class EmployeeDataSource22 extends DataGridSource {
//DataGridRowهنا تحويل البيانات الى قائمه من
  EmployeeDataSource22(
    this.context, {
    required List<CustomerModel> coumingData,
  }) {
    List<DataGridRow> dataa() {
      List<DataGridRow> list = [];
      for (var customercall in coumingData.expand((e) => e.calls)) {
        list.add(DataGridRow(cells: [
          DataGridCell<String>(columnName: '1', value: customercall.calltype),
          DataGridCell<String>(columnName: '2', value: customercall.callDate.formatt_yMd()),
          DataGridCell<String>(columnName: '3', value: customercall.callReason),
          DataGridCell<String>(columnName: '4', value: customercall.callresult),
          DataGridCell<String>(columnName: '5', value: customercall.callRecipient),
          DataGridCell<String>(columnName: '6', value: coumingData.firstWhere((test) => test.customer_ID == customercall.customer_ID).cusotmerName),
          DataGridCell<List<String>>(columnName: '7', value: coumingData.firstWhere((test) => test.customer_ID == customercall.customer_ID).mobilenum),
        ]));
      }
      for (var ticketCall in coumingData.expand((e) => e.tickets).expand((e) => e.calls)) {
        list.add(DataGridRow(cells: [
          DataGridCell<String>(columnName: '1', value: ticketCall.calltype),
          DataGridCell<String>(columnName: '2', value: ticketCall.callDate.formatt_yMd()),
          DataGridCell<String>(columnName: '3', value: ticketCall.callReason),
          DataGridCell<String>(columnName: '4', value: ticketCall.callresult),
          DataGridCell<String>(columnName: '5', value: ticketCall.callRecipient),
          DataGridCell<String>(columnName: '6', value: coumingData.firstWhere((test) => test.customer_ID == ticketCall.customer_ID).cusotmerName),
          DataGridCell<List<String>>(columnName: '7', value: coumingData.firstWhere((test) => test.customer_ID == ticketCall.customer_ID).mobilenum),
        ]));
      }
      return list;
    }

    data = dataa();

    data2 = coumingData;
  }

  final BuildContext context;

  List<DataGridRow> data = [];
  List<CustomerModel> data2 = [];

  @override
  List<DataGridRow> get rows => data;
  @override
  Widget? buildTableSummaryCellWidget(GridTableSummaryRow summaryRow, GridSummaryColumn? summaryColumn, RowColumnIndex rowColumnIndex, String summaryValue) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Text(summaryValue),
    );
  }

  // @override
  // Widget? buildEditWidget(DataGridRow dataGridRow,
  //     RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
  //   // Text going to display on editable widget
  //   final String displayText = dataGridRow
  //           .getCells()
  //           .firstWhereOrNull((DataGridCell dataGridCell) =>
  //               dataGridCell.columnName == column.columnName)
  //           ?.value
  //           ?.toString() ??
  //       '';
  //   final dynamic oldValue = dataGridRow
  //           .getCells()
  //           .firstWhereOrNull((DataGridCell dataGridCell) =>
  //               dataGridCell.columnName == column.columnName)
  //           ?.value ??
  //       '';

  //   final int dataRowIndex = data.indexOf(dataGridRow);
  //   final BlockModel u = data2.elementAt(dataRowIndex);

  //   newCellValue = "";

  //   final bool isNumericType =
  //       column.columnName == 'id' || column.columnName == 'amount';

  //   return Container(
  //     padding: const EdgeInsets.all(8.0),
  //     alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
  //     child: TextField(
  //       autofocus: true,
  //       controller: editingController..text = displayText,
  //       textAlign: isNumericType ? TextAlign.right : TextAlign.left,
  //       decoration: const InputDecoration(
  //         contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
  //       ),
  //       keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
  //       onChanged: (String value) {
  //         if (value.isNotEmpty) {
  //           if (isNumericType) {
  //             newCellValue = int.parse(value);
  //           } else {
  //             newCellValue = value;
  //           }
  //         } else {
  //           newCellValue = null;
  //         }
  //       },
  //       // onSubmitted: (String value) {
  //       //   if (column.columnName == "size") {
  //       //     String i = value;
  //       //     List<String> b = i.replaceAll("*", " ").split(" ");
  //       //     context
  //       //         .read<BlockFirebasecontroller>()
  //       //         .edit_cell_size(oldValue, u.Block_Id, column.columnName, b);
  //       //   } else {
  //       //     context
  //       //         .read<BlockFirebasecontroller>()
  //       //         .edit_cell(u.Block_Id, column.columnName, value);
  //       //     submitCell();
  //       //   }
  //       //   submitCell();
  //       // },
  //     ),
  //   );
  // }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      //هنا الخلايا
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4.0),
        child: Tooltip(
          message: e.value.toString(),
          child: Text(
            e.value.toString(),
          ),
        ),
      );
    }).toList());
  }
}
