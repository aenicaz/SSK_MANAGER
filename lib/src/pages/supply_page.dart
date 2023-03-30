import 'package:flutter/material.dart';
import 'package:ssk_manager/src/models/supply.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../database_provider/database_provider.dart';
import '../widgets/tables/supply_table.dart';
import '../widgets/left_side_menu.dart';

class SupplyPage extends StatefulWidget {
  const SupplyPage({super.key});

  @override
  State<SupplyPage> createState() => _SupplyPageState();
}

class _SupplyPageState extends State<SupplyPage> {
  List<Supply> _supplyList = [];
  Color color = Colors.grey.shade200;
  static var selectedRange = const RangeValues(1, 1000);
  SfRangeValues _values = SfRangeValues(0.0, 10000.0);
  bool flag = false;
  Map<String, String> sortBy = {
    'Supplier': '',
    'Tech type': '',
    'Date': '',
    'Count': '',
    'Price min': '',
    'Price max': ''
  };

  List getUniqueValue(List<Supply> dataSource, String useCase) {
    List<String?> storageList = [];

    switch (useCase) {
      case "Supplier":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.supplier)) {
            storageList.add(element.supplier);
          }
        }
        break;
      case "Tech type":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.techType)) {
            storageList.add(element.techType);
          }
        }
        break;
      case "Date":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.date)) {
            storageList.add(element.date);
          }
        }
        break;
      case "Count":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.count)) {
            storageList.add(element.count.toString());
          }
        }
        break;
    }
    storageList.sort();
    return storageList;
  }

  List<DataRow> getDataRow(List<Supply> dataSource,
      [Map<String, String>? sortRule]) {
    if (dataSource.isEmpty) {
      getDataFromDb();
      return generateDataRow(dataSource);
    } else {
      return generateDataRow(dataSource);
    }
  }

  Future getDataFromDb() async {
    if (_supplyList.isEmpty) {
      _supplyList = await InventoryListDatabase.getSupplyDataFromDatabase();
      return _supplyList;
    } else {
      return _supplyList;
    }
  }

  /*Генерирует List строк для таблиц из исходного List компьютеров*/
  List<DataRow> generateDataRow(List<Supply> dataSource) {
    List<DataRow> dataList = [];
    int iterator = 1;

    for (var element in dataSource) {
      if (iterator.isEven) {
        color = Colors.grey.shade200;
      } else {
        color = Colors.white;
      }
      dataList
          .add(DataRow(color: MaterialStateProperty.all<Color>(color), cells: [
        DataCell(showEditIcon: true, Text('')),
        DataCell(Text(iterator.toString())),
        DataCell(Text(element.supplier.toString())),
        DataCell(Text(element.techType.toString())),
        DataCell(Text(element.date.toString())),
        DataCell(Text(element.count.toString())),
        DataCell(Text(element.pricePerPos.toString())),
        DataCell(Text((element.pricePerPos * element.count).toString())),
      ]));

      iterator++;
    }
    return dataList;
  }

  List<Supply> sort(List<Supply> dataSource, Map<String, String> sortRule) {
    List<Supply> exitValue = []; /*Выходной список*/
    List<String> rules = []; /*Генерируемыей из Map список фильтров*/
    /*Тут конвертится Map в List*/
    for (var element in sortRule.values) {
      if (element.isNotEmpty) rules.add(element);
    }
    /*Проверка наличия фильтра и пустотый выходного списка*/
    if (sortRule['Supplier']!.isNotEmpty && exitValue.isEmpty) {
      /*Если входной список пустой, значит фильтрации до этого небыло - это первая
      * итерация фильтрации и следует сразу добавлять подходящие под критерий отбора записи
      * в выходной список*/
      for (var element in dataSource) {
        if (element.supplier == sortRule['Supplier']) {
          exitValue.add(element);
        }
      }
      /*Сюда попадаем только есть выходной список имеет какие-то значения, то есть
      * до этого он уже был отфильтрован по другому фильтру*/
    } else if (sortRule['Supplier']!.isNotEmpty) {
      /*Временный список для хранения значений под заданный фильтр. В целом нужен только
      * для того, чтобы не конфликтовал Итератор*/
      List<Supply> newSortedList = [];
      for (var element in exitValue) {
        /*Добавляем в newSortedList удовлетворяющие поиску записи*/
        if (element.supplier == sortRule['Supplier']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Tech type']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.techType == sortRule['Tech type']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Tech type']!.isNotEmpty) {
      List<Supply> newSortedList = [];

      for (var element in exitValue) {
        if (element.techType == sortRule['Tech type']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Date']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.date == sortRule['Date']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Date']!.isNotEmpty) {
      List<Supply> newSortedList = [];

      for (var element in exitValue) {
        if (element.date == sortRule['Date']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }
    if (sortRule['Price min']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.pricePerPos >= _values.start &&
            element.pricePerPos <= _values.end) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Price min']!.isNotEmpty) {
      List<Supply> newSortedList = [];

      for (var element in exitValue) {
        if (element.pricePerPos >= _values.start &&
            element.pricePerPos <= _values.end) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }
    if (rules.isEmpty) exitValue = dataSource;
    return exitValue;
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
              DefaultTabController(
                length: 2,
                child: Expanded(
                  flex: 5,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TabBar(labelColor: Colors.black87, tabs: [
                          Tab(text: 'Создать поступление'),
                          Tab(text: 'Таблица поступлений')
                        ]),
                        Expanded(
                          child: TabBarView(children: [
                            FutureBuilder(
                              future: null,
                              builder: (context, snapshot) {
                                if (true) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text('Поставщик'),
                                            Text('Тип техники'),
                                            Text('Дата'),
                                            Text('Количество'),
                                            Text('Стоимость за шт., руб.'),
                                            Text('Общая стоимость, руб.'),
                                            Switch(value: flag,

                                              onChanged: (value) {
                                              setState(() {
                                                flag = !flag;
                                              });
                                            },)
                                          ],
                                        ),
                                      ),
                                      Divider(thickness: 2),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: TextFormField(),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: TextFormField(),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: TextFormField(),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: TextFormField(),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: TextFormField(),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(6.0),
                                                child: TextFormField(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.blue.shade700,
                                    ),
                                  );
                                }
                              },
                            ),
                            FutureBuilder(
                              future: getDataFromDb(),
                              builder: (context, snapshot) {
                                if (_supplyList.isNotEmpty) {
                                  return Row(
                                    children: [
                                      SupplyTable(
                                          dataRowList: getDataRow(
                                              sort(_supplyList, sortBy))),
                                      Expanded(
                                        child: buildRightSideMenu(),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.blue.shade700,
                                    ),
                                  );
                                }
                              },
                            ),
                          ]),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView buildRightSideMenu() {
    return ListView(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(30.0),
              child: Text('Фильтры'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Поставщик'),
                  DropdownButton(
                    isExpanded: true,
                    focusColor: Colors.grey.shade200,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    value: sortBy['Supplier'],
                    items: List<DropdownMenuItem<String>>.generate(
                        getUniqueValue(_supplyList, 'Supplier').length,
                        (index) {
                      var tmp = getUniqueValue(_supplyList, 'Supplier');
                      return DropdownMenuItem(
                          value: tmp[index], child: Text(tmp[index]));
                    }),
                    onChanged: (Object? value) {
                      setState(() {
                        debugPrint(value.toString());
                        sortBy['Supplier'] = value.toString();
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Тип техники'),
                  DropdownButton(
                    isExpanded: true,
                    focusColor: Colors.grey.shade200,
                    value: sortBy['Tech type'],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    items: List<DropdownMenuItem<String>>.generate(
                        getUniqueValue(_supplyList, 'Tech type').length,
                        (index) {
                      var tmp = getUniqueValue(_supplyList, 'Tech type');
                      return DropdownMenuItem(
                          value: tmp[index], child: Text(tmp[index]));
                    }),
                    onChanged: (Object? value) {
                      setState(() {
                        debugPrint(value.toString());
                        sortBy['Tech type'] = value.toString();
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Дата'),
                  DropdownButton(
                    isExpanded: true,
                    focusColor: Colors.grey.shade200,
                    value: sortBy['Date'],
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    items: List<DropdownMenuItem<String>>.generate(
                        getUniqueValue(_supplyList, 'Date').length, (index) {
                      var tmp = getUniqueValue(_supplyList, 'Date');
                      return DropdownMenuItem(
                          value: tmp[index], child: Text(tmp[index]));
                    }),
                    onChanged: (Object? value) {
                      setState(() {
                        debugPrint(value.toString());
                        sortBy['Date'] = value.toString();
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Cтоимость'),
                  SfRangeSlider(
                    min: 0.0,
                    max: 10000.0,
                    stepSize: 100,
                    interval: 2500,
                    values: _values,
                    showTicks: true,
                    showLabels: true,
                    enableTooltip: true,
                    onChanged: (SfRangeValues values) {
                      setState(() {
                        _values = values;
                        sortBy['Price min'] = _values.start.toString();
                        sortBy['Price max'] = _values.end.toString();
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
