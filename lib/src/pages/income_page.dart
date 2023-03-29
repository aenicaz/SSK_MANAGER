import 'dart:ffi';

import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../consts/data.dart';
import '../widgets/left_side_menu.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _providerController = TextEditingController();
  final TextEditingController _techTypeController = TextEditingController();
  final TextEditingController _buhNumberController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();

  @override
  void initState() {
    getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSK Resource / IncomePage'),
        actions: const [],
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(null),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              LeftSideMenu(),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: DefaultTabController(
                          length: 3,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              TabBar(
                                labelColor: Colors.black87,
                                indicatorColor: Colors.amber,
                                tabs: const [
                                  Tab(
                                    text: 'Cоздать поступление',
                                  ),
                                  Tab(
                                    text: 'История поступлений',
                                  ),
                                ],
                              ),
                              Expanded(
                                  child: TabBarView(
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Дата"),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 95, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              controller: _dataController,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Поставщик"),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 55, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              controller: _providerController,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Тип техники"),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50, right: 700),
                                            child:  TextFormField(
                                              textAlign: TextAlign.center,
                                              controller: _techTypeController,
                                            ),
                                              ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Бухгалтерский номер"),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50, right: 700),
                                              child:  TextFormField(
                                                textAlign: TextAlign.center,
                                                controller: _buhNumberController,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Цена            "),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              controller: _priceController,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Количество"),
                                          Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 55, right: 700),
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  onChanged: (value) {
                                                   var tmp1 = int.parse(value);
                                                   var tmp2 = int.parse(_priceController.text);
                                                   _totalPriceController.text = (tmp1 * tmp2).toString();
                                                   debugPrint(_totalPriceController.text);
                                                  },
                                                  controller: _countController,
                                                ),
                                              )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Общаяя стоимость"),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              enabled: false,
                                              controller: _totalPriceController,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Карточка учёта №"),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                              initialValue: '1',
                                              enabled: false,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 140),
                                              child: TextButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      incomeList.add(
                                                          DataRow(cells: [
                                                            DataCell(Text(_dataController.text)),
                                                            DataCell(Text(_providerController.text)),
                                                            DataCell(Text(_techTypeController.text)),
                                                            DataCell(Text(_buhNumberController.text)),
                                                            DataCell(Text(_countController.text)),
                                                            DataCell(Text(_priceController.text)),
                                                            DataCell(Text(_totalPriceController.text)),
                                                            DataCell(Text(incomeList.length.toString())),
                                                          ])
                                                      );
                                                    });
                                                  },
                                                  child: Text('Coхранить')),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Expanded(
                                        child: DataTable2(
                                            columnSpacing: 12,
                                            horizontalMargin: 12,
                                            minWidth: 600,
                                            columns: const [
                                              DataColumn2(
                                                label: Text('Дата'),
                                                size: ColumnSize.S
                                              ),
                                              DataColumn2(
                                                label: Text('Поставщик'),
                                                size: ColumnSize.S,
                                              ),
                                              DataColumn2(
                                                label: Text('Тип техники'),
                                                size: ColumnSize.S,
                                              ),
                                              DataColumn2(
                                                label:
                                                    Text('Бухгалтерский номер'),
                                                size: ColumnSize.S,
                                              ),
                                              DataColumn2(
                                                label:
                                                    Text('Количество'),
                                                size: ColumnSize.S,
                                              ),
                                              DataColumn2(
                                                label: Text('Цена руб.'),
                                                size: ColumnSize.S,
                                              ),
                                              DataColumn2(
                                                label: Text('Общая стоимость руб.'),
                                                size: ColumnSize.S,
                                              ),
                                              DataColumn2(
                                                label: Text('Карточка учёта №'),
                                                size: ColumnSize.S,
                                              ),
                                            ],
                                            rows: incomeList
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              )),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
