import 'dart:convert';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ssk_manager/src/database_provider/databace_provider.dart';
import 'package:ssk_manager/src/widgets/left_side_menu.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List computers = [];

  Future readJson() async {
    final String responce = await rootBundle.loadString('assets/dataset.json');
    final data = await json.decode(responce);

    setState(() {
      computers = data;
      debugPrint(computers.length.toString());
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSK Resource / InventoryPage'),
        actions: [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(null),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              LeftSideMenu(func: readJson()),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    newMethod(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded newMethod() {
    return Expanded(
      child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: [
            DataColumn2(
              label: Text('Модель'),
              size: ColumnSize.S,
              tooltip: AutofillHints.birthday,
            ),
            DataColumn2(
              label: Text('Серийный номер'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Номер продукта'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Бухгалтерский номер'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Имя пользователся'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Место хранения'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Номер пломбы'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Примечание'),
              size: ColumnSize.S,
            ),
          ],
          rows: List<DataRow>.generate(
              100,
              (index) => DataRow(cells: [
                    DataCell(Text(index.toString())),
                    DataCell(Text('B' * (10 - (index + 5) % 10))),
                    DataCell(Text('C' * (15 - (index + 5) % 10))),
                    DataCell(Text('D' * (15 - (index + 10) % 10))),
                    DataCell(Text(((index + 0.1) * 25.4).toString())),
                    DataCell(Text(((index + 0.1) * 25.4).toString())),
                    DataCell(Text(((index + 0.1) * 25.4).toString())),
                    DataCell(Text(((index + 0.1) * 25.4).toString()))
                  ]))),
    );
  }
}
