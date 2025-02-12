// ignore_for_file: unused_element

import 'dart:math';

import 'package:davi/davi.dart';
import 'package:flutter/material.dart';

class Person {
  Person(this.name, this.age, this.value);

  final String name;
  final int age;
  final int value;

  bool _valid = true;

  bool get valid => _valid;

  String _editable = '';

  String get editable => _editable;

  set editable(String value) {
    _editable = value;
    _valid = _editable.length < 6;
  }
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Davi Example',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DaviModel<Person>? _model;

  @override
  void initState() {
    super.initState();

    List<Person> rows = [];
    Random random = Random();
    for (int i = 1; i < 100; i++) {
      rows.add(Person('User $i', 20 + random.nextInt(50), random.nextInt(999)));
    }
    rows.shuffle();

    _model = DaviModel<Person>(
        rows: rows,
        columns: [
          DaviColumn(
              pinStatus: PinStatus.left,
              name: 'Name',
              cellBuilder: (BuildContext context, DaviRow<Person> row) {
                return InkWell(
                    child: const Icon(Icons.edit, size: 16), onTap: () {});
              }),
          DaviColumn(name: 'Age', intValue: (data) => data.age),
          DaviColumn(
            name: 'Age2',
            cellBuilder: (context, row) => const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          ),
          DaviColumn(
            name: 'Age2',
            cellBuilder: (context, row) => const Icon(
              Icons.cancel,
              color: Colors.red,
            ),
          ),
          DaviColumn(
              name: 'Value',
              intValue: (data) => data.value,
              headerTextStyle: TextStyle(color: Colors.blue[900]!),
              headerAlignment: Alignment.center,
              cellAlignment: Alignment.center,
              cellTextStyle: TextStyle(color: Colors.blue[700]!),
              cellBackground: (data) => Colors.blue[50]),
          DaviColumn(
              name: 'Editable',
              sortable: false,
              cellBuilder: _buildField,
              cellBackground: (row) => row.data.valid ? null : Colors.red[800])
        ],
        alwaysSorted: true,
        multiSortEnabled: true);
  }

  Widget _buildField(BuildContext context, DaviRow<Person> rowData) {
    return TextFormField(
        initialValue: rowData.data.editable,
        style:
            TextStyle(color: rowData.data.valid ? Colors.black : Colors.white),
        onChanged: (value) => _onFieldChange(value, rowData.data));
  }

  void _onFieldChange(String value, Person person) {
    final wasValid = person.valid;
    person.editable = value;
    if (wasValid != person.valid) {
      setState(() {
        // rebuild
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SizedBox(
          // width: 500,
          // height: 500,
          child: DaviTheme(
            data: DaviThemeData(
                row: RowThemeData(
                    hoverBackground: (rowIndex) => Colors.blue[50])),
            child: Davi<Person>(_model,
                rowColor: _rowColor,
                onHover: _onHover,
                onRowSecondaryTap: (person) =>
                    _onRowSecondaryTap(context, person),
                onRowSecondaryTapUp: (person, detail) =>
                    _onRowSecondaryTapUp(context, person, detail),
                onRowDoubleTap: (person) => _onRowDoubleTap(context, person)),
          ),
        ));
  }
}

Color? _rowColor(DaviRow<Person> row) {
  if (row.data.age < 20) {
    return Colors.green[50]!;
  } else if (row.data.age > 30 && row.data.age < 50) {
    return Colors.orange[50]!;
  }
  return null;
}

void _onRowTap(BuildContext context, Person person) {}

void _onRowSecondaryTap(BuildContext context, Person person) {}

void _onRowSecondaryTapUp(
    BuildContext context, Person person, TapUpDetails detail) {}

void _onRowDoubleTap(BuildContext context, Person person) {}
void _onHover(int? rowIndex) {}
