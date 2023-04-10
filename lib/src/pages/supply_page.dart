import 'package:flutter/material.dart';
import 'package:ssk_manager/src/consts/ulr.dart';
import 'package:ssk_manager/src/models/supply.dart';
import 'package:ssk_manager/src/widgets/supply_input_field.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import '../database_provider/database_provider.dart';
import '../models/computers.dart';
import '../widgets/tables/supply_table.dart';
import '../widgets/left_side_menu.dart';

class SupplyPage extends StatefulWidget {
  const SupplyPage({super.key});

  @override
  State<SupplyPage> createState() => _SupplyPageState();
}

class _SupplyPageState extends State<SupplyPage> {
  var supplierTextEditionController = TextEditingController();
  var modelTextEditionController = TextEditingController();
  var dataTextEditionController = TextEditingController();
  var countTextEditionController = TextEditingController();
  var pricePerPosTextEditionController = TextEditingController();
  List<Supply> _supplyList = [];
  Color color = Colors.grey.shade200;
  SfRangeValues _values = SfRangeValues(0.0, 50000.0);
  bool flag = false;
  String techTypeValue = 'Системный блок';

  Map<String, String> sortBy = {
    'Supplier': '',
    'Tech type': '',
    'Date': '',
    'Count': '',
    'Price min': '',
    'Price max': ''
  };

  List<DataRow> generateDataRow(
      List<Supply> dataSource, Color rowColor, BuildContext context) {
    List<DataRow> dataList = [];
    int iterator = 1;

    for (var element in dataSource) {
      if (iterator.isEven) {
        rowColor = Colors.grey.shade200;
      } else {
        rowColor = Colors.white;
      }
      dataList.add(
          DataRow(color: MaterialStateProperty.all<Color>(rowColor), cells: [
        DataCell(onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                List<TextEditingController> tmp =
                    List.generate(6, (index) => TextEditingController());
                return Supply.editDialog(element, tmp, context, () {
                  setState(() {
                    var tmpSupply = Supply(
                        id: element.id,
                        count: int.parse(tmp[4].text),
                        pricePerPos: int.parse(tmp[5].text),
                        model: tmp[2].text,
                        techType: tmp[1].text,
                        supplier: tmp[0].text,
                        date: tmp[3].text);
                    var index = element.id! - 1;
                    _supplyList[index] = tmpSupply;
                    try {
                      DatabaseProvider.rawDatabaseQuery(
                          Supply.updateDatabaseQuery(tmpSupply));
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Запись обновлена"),
                      ));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Ошибка: заполните все доступные поля"),
                      ));
                    }
                  });
                }, () => null);
              });
        }, showEditIcon: true, Text('')),
        DataCell(Text(iterator.toString())),
        DataCell(Text(element.supplier.toString())),
        DataCell(Text(element.techType.toString())),
        DataCell(Text(element.model.toString())),
        DataCell(Text(element.date.toString())),
        DataCell(Text(element.count.toString())),
        DataCell(Text(element.pricePerPos.toString())),
        DataCell(Text((element.pricePerPos * element.count).toString())),
      ]));

      iterator++;
    }
    return dataList;
  }

  List<DataRow> getDataRow(List<Supply> dataSource,
      [Map<String, String>? sortRule]) {
    if (dataSource.isEmpty) {
      getDataFromDb();
      return generateDataRow(dataSource, color, context);
    } else {
      return generateDataRow(dataSource, color, context);
    }
  }

  Future getDataFromDb() async {
    if (_supplyList.isEmpty) {
      _supplyList = await DatabaseProvider.getSupplyDataFromDatabase();
      return _supplyList;
    } else {
      return _supplyList;
    }
  }

  Supply validateRecord() {
    late Supply newSupply;
    if (countTextEditionController.text.isNotEmpty &&
        dataTextEditionController.text.isNotEmpty &&
        modelTextEditionController.text.isNotEmpty &&
        supplierTextEditionController.text.isNotEmpty &&
        pricePerPosTextEditionController.text.isNotEmpty) {
      newSupply = Supply(
          id: _supplyList.length + 1,
          count: int.parse(countTextEditionController.text),
          date: dataTextEditionController.text,
          supplier: supplierTextEditionController.text,
          techType: techTypeValue,
          pricePerPos: int.parse(pricePerPosTextEditionController.text),
          model: modelTextEditionController.text);
    }

    return newSupply;
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
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('Поставщик'),
                                          Text('Тип техники'),
                                          Text('Модель'),
                                          Text('Дата'),
                                          Text('Количество'),
                                          Text('Стоимость за шт., руб.'),
                                          Switch(
                                            value: flag,
                                            onChanged: (value) {
                                              setState(() {
                                                flag = !flag;
                                              });
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: () {},
                                            splashRadius: 25,
                                          ),
                                        ],
                                      ),
                                      Divider(thickness: 2),
                                      Row(
                                        children: [
                                          SupplyInputField(
                                              isNumeric: false,
                                              controller:
                                                  supplierTextEditionController,
                                              textHint: 'Поставщик'),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(6.0),
                                              child: DropdownButton(
                                                value: techTypeValue,
                                                isExpanded: true,
                                                focusColor:
                                                    Colors.grey.shade200,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
                                                items: List<
                                                        DropdownMenuItem<
                                                            String>>.generate(
                                                    Supply.techTypeMap.length,
                                                    (index) {
                                                  return DropdownMenuItem(
                                                      value: Supply
                                                          .techTypeMap[index],
                                                      child: Text(
                                                          Supply.techTypeMap[
                                                              index]!));
                                                }),
                                                onChanged: (Object? value) {
                                                  setState(() {
                                                    techTypeValue =
                                                        value.toString();
                                                  });
                                                },
                                              ),
                                            ),
                                          ),
                                          SupplyInputField(
                                              isNumeric: false,
                                              controller:
                                                  modelTextEditionController,
                                              textHint: 'Модель'),
                                          SupplyInputField(
                                              isNumeric: false,
                                              controller:
                                                  dataTextEditionController,
                                              textHint: 'Дата'),
                                          SupplyInputField(
                                              isNumeric: true,
                                              controller:
                                                  countTextEditionController,
                                              textHint: 'Количество'),
                                          SupplyInputField(
                                              isNumeric: true,
                                              controller:
                                                  pricePerPosTextEditionController,
                                              textHint: 'Стоимость за шт.'),
                                          Expanded(
                                            child: TextButton(
                                              child: const Text('Сохранить'),
                                              onPressed: () async {
                                                try {
                                                  var tmpRecord =
                                                  validateRecord();
                                                  for (var i = 0;
                                                  i < tmpRecord.count;
                                                  i++) {
                                                    var tmpComputer = Computer(
                                                        invNumber: lastInvNumber,
                                                        model: tmpRecord.model,
                                                        supplyId: tmpRecord.id
                                                            .toString(),
                                                        cleanDate:
                                                        tmpRecord.date);
                                                    lastInvNumber = (int.parse(lastInvNumber) + 1).toString();
                                                    await DatabaseProvider
                                                        .rawDatabaseQuery(Computer
                                                        .insertDatabaseQuery(
                                                        tmpComputer));
                                                  }
                                                  _supplyList.add(tmpRecord);
                                                  await DatabaseProvider
                                                      .rawDatabaseQuery(Supply
                                                          .insertDatabaseQuery(
                                                              _supplyList
                                                                  .last));
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Записи добавлены"),
                                                  ));
                                                } catch (e) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                    content: Text(
                                                        "Заполните все поля"),
                                                  ));
                                                }
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
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
                                          dataRowList: getDataRow(Supply.sort(
                                              _supplyList, sortBy, _values))),
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
                        Supply.getUniqueValue(_supplyList, 'Supplier').length,
                        (index) {
                      var tmp = Supply.getUniqueValue(_supplyList, 'Supplier');
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
                        Supply.getUniqueValue(_supplyList, 'Tech type').length,
                        (index) {
                      var tmp = Supply.getUniqueValue(_supplyList, 'Tech type');
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
                        Supply.getUniqueValue(_supplyList, 'Date').length,
                        (index) {
                      var tmp = Supply.getUniqueValue(_supplyList, 'Date');
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
                  const Text('Cтоимость за единицу товара'),
                  SfRangeSlider(
                    min: 0.0,
                    max: 50000.0,
                    stepSize: 100,
                    interval: 10000,
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
