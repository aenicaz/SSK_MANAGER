import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../widgets/left_side_menu.dart';

class IncomePage extends StatefulWidget {
  const IncomePage({super.key});

  @override
  State<IncomePage> createState() => _IncomePageState();
}

class _IncomePageState extends State<IncomePage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controllerNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSK Resource / IncomePage'),
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
                                tabs: [
                                  Tab(
                                    text: 'Cоздать поступление',
                                  ),
                                  Tab(
                                    text: 'Создать списание',
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
                                                left: 10, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
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
                                                left: 10, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
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
                                                left: 10, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
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
                                                left: 10, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Цена"),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 700),
                                            child: TextFormField(
                                              onChanged: (value) =>
                                                  {_controller.text = value},
                                              textAlign: TextAlign.center,
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
                                              controller: _controller,
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
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _controllerNumber
                                                        .text = (int.parse(
                                                                _controllerNumber
                                                                    .text) +
                                                            1)
                                                        .toString();
                                                    debugPrint(
                                                        _controllerNumber.text);
                                                  });
                                                },
                                                child: Text('Coхранить')),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("Дата"),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Номер техники"),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Текущий пользователь"),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text("Причина списания"),
                                          Expanded(
                                              child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 700),
                                            child: TextFormField(
                                              textAlign: TextAlign.center,
                                            ),
                                          )),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    _controllerNumber
                                                        .text = (int.parse(
                                                                _controllerNumber
                                                                    .text) +
                                                            1)
                                                        .toString();
                                                    debugPrint(
                                                        _controllerNumber.text);
                                                  });
                                                },
                                                child: Text('Coхранить')),
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
                                                label:
                                                    Text('Бухгалтерский номер'),
                                                size: ColumnSize.S,
                                              ),
                                              DataColumn2(
                                                label:
                                                    Text('Имя пользователся'),
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
                                                10,
                                                (index) => DataRow(cells: [
                                                      DataCell(Text(
                                                          index.toString())),
                                                      DataCell(Text('B' *
                                                          (10 -
                                                              (index + 5) %
                                                                  10))),
                                                      DataCell(Text('C' *
                                                          (15 -
                                                              (index + 5) %
                                                                  10))),
                                                      DataCell(Text('D' *
                                                          (15 -
                                                              (index + 10) %
                                                                  10))),
                                                      DataCell(Text(
                                                          ((index + 0.1) * 25.4)
                                                              .toString())),
                                                      DataCell(Text(
                                                          ((index + 0.1) * 25.4)
                                                              .toString())),
                                                      DataCell(Text(
                                                          ((index + 0.1) * 25.4)
                                                              .toString())),
                                                      DataCell(Text(
                                                          ((index + 0.1) * 25.4)
                                                              .toString()))
                                                    ]))),
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
