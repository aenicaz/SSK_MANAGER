import 'package:flutter/material.dart';
import 'package:ssk_manager/src/database_provider/database_provider.dart';
import 'package:ssk_manager/src/models/supply.dart';
import 'package:ssk_manager/src/widgets/tables/inventory_table.dart';
import 'package:ssk_manager/src/widgets/left_side_menu.dart';

import '../models/computers.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  Color color = Colors.grey.shade200;
  List<Computer> _computerList = [];
  String _filter = '';

  TextEditingController invNumberTextController = TextEditingController();

  /*Map фильтров для списка*/
  Map<String, String> sortBy = {
    'User name': '',
    'Inv number': '',
    'Buh number': '',
    'Storage': '',
    'Model': '',
    'Supply id': '',
  };

  Future getDataFromDb() async {
    if (_computerList.isEmpty) {
      _computerList = await DatabaseProvider.getComputerDataFromDatabase();
      return _computerList;
    } else {
      return _computerList;
    }
  }

  /*Генерирует List строк для таблиц из исходного List компьютеров*/
  List<DataRow> generateDataRow(List<Computer> dataSource) {
    List<DataRow> dataList = [];
    int iterator = 1;

    for (var element in dataSource) {
      if (element.model == _filter) {
        color = Colors.green;
      } else {
        if (iterator.isEven) {
          color = Colors.grey.shade200;
        } else {
          color = Colors.white;
        }
      }

      dataList
          .add(DataRow(color: MaterialStateProperty.all<Color>(color), cells: [
        DataCell(onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              List<TextEditingController> tmp =
              List.generate(10, (index) => TextEditingController());
              return Computer.editDialog(element, tmp, context, () {
                try {
                  setState(() {
                    var tmpComputer = Computer(
                        id: element.id,
                        model: tmp[0].text,
                        invNumber: tmp[1].text,
                        sealNumber: tmp[2].text,
                        productNumber: tmp[3].text,
                        buhNumber: tmp[4].text,
                        supplyId: tmp[5].text,
                        userName: tmp[6].text,
                        storage: tmp[7].text,
                        serialNumber: tmp[8].text,
                        cleanDate: tmp[9].text,
                        buhName: element.buhName,
                        comment: element.comment);
                    var index = element.id! - 1;
                    _computerList[index] = tmpComputer;

                    DatabaseProvider.rawDatabaseQuery(
                        Computer.updateDatabaseQuery(tmpComputer));
                    Navigator.pop(context);
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Ошибка: заполните все доступные поля"),
                  ));
                }
              }, () {
                setState(() {
                  _computerList.remove(element);
                  DatabaseProvider.rawDatabaseQuery(
                      Computer.removeDatabaseQuery(element));
                });
              });
            },
          );
        }, showEditIcon: true, Text('')),
        DataCell(Text(iterator.toString())),
        DataCell(onTap: () {
          setState(() {
            if (_filter == element.model) {
              _filter = '';
            } else {
              _filter = element.model!;
            }
          });
        }, Text(element.model.toString())),
        DataCell(Text(element.invNumber.toString())),
        DataCell(Text(element.sealNumber.toString())),
        DataCell(Text(element.productNumber.toString())),
        DataCell(Text(element.buhName.toString())),
        DataCell(Text(element.supplyId.toString())),
        DataCell(Text(element.userName.toString())),
        DataCell(Text(element.storage.toString())),
        DataCell(Text(element.sealNumber.toString())),
        DataCell(Text(element.comment.toString())),
      ]));

      iterator++;
    }
    return dataList;
  }

  List<DataRow> getDataRow(List<Computer> dataSource,
      Map<String, String> sortRule) {
    if (dataSource.isEmpty) {
      getDataFromDb();
      return generateDataRow(Computer.sort(dataSource, sortRule));
    } else {
      return generateDataRow(Computer.sort(dataSource, sortRule));
    }
  }

  @override
  initState() {
    getDataFromDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSK Resource / InventoryPage'),
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(null),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const LeftSideMenu(func: null),
              Expanded(
                child: FutureBuilder(
                  future: getDataFromDb(),
                  builder: (context, snapshot) {
                    if (_computerList.isNotEmpty) {
                      return Row(
                        children: [
                          InventoryTable(
                              dataRowList: getDataRow(_computerList, sortBy)),
                          buildRightSideMenu(),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded buildRightSideMenu() {
    return Expanded(
      child: ListView(
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const Text('Инвентарный номер'),
                    TextField(
                      controller: invNumberTextController,
                      onChanged: (value) {
                        setState(() {
                          sortBy['Inv number'] = value;
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
                    const Text('Модель'),
                    DropdownButton(
                      isExpanded: true,
                      focusColor: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: sortBy['Model'],
                      items: List<DropdownMenuItem<String>>.generate(
                          Computer
                              .getUniqueValue(_computerList, 'Model')
                              .length, (index) {
                        var tmp =
                        Computer.getUniqueValue(_computerList, 'Model');
                        return DropdownMenuItem(
                            value: tmp[index], child: Text(tmp[index]));
                      }),
                      onChanged: (Object? value) {
                        setState(() {
                          debugPrint(value.toString());
                          sortBy['Model'] = value.toString();
                        });
                      },
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Имя пользователя'),
                    DropdownButton(
                      isExpanded: true,
                      focusColor: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: sortBy['User name'],
                      items: List<DropdownMenuItem<String>>.generate(
                          Computer
                              .getUniqueValue(_computerList, 'User name')
                              .length, (index) {
                        var tmp =
                        Computer.getUniqueValue(_computerList, 'User name');
                        return DropdownMenuItem(
                            value: tmp[index], child: Text(tmp[index]));
                      }),
                      onChanged: (Object? value) {
                        setState(() {
                          sortBy['User name'] = value.toString();
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
                    const Text('Бухгалтерский номер'),
                    DropdownButton(
                      isExpanded: true,
                      focusColor: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: sortBy['Buh number'],
                      items: List<DropdownMenuItem<String>>.generate(
                          Computer
                              .getUniqueValue(_computerList, 'Buh number')
                              .length, (index) {
                        var tmp = Computer.getUniqueValue(
                            _computerList, 'Buh number');
                        return DropdownMenuItem(
                            value: tmp[index], child: Text(tmp[index]));
                      }),
                      onChanged: (Object? value) {
                        setState(() {
                          sortBy['Buh number'] = value.toString();
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
                    const Text('Номер поставки'),
                    DropdownButton(
                      isExpanded: true,
                      focusColor: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: sortBy['Supply id'],
                      items: List<DropdownMenuItem<String>>.generate(
                          Computer
                              .getUniqueValue(_computerList, 'Supply id')
                              .length, (index) {
                        var tmp =
                        Computer.getUniqueValue(_computerList, 'Supply id');
                        return DropdownMenuItem(
                            value: tmp[index], child: Text(tmp[index]));
                      }),
                      onChanged: (Object? value) {
                        setState(() {
                          sortBy['Supply id'] = value.toString();
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
                    const Text('Место хранения'),
                    DropdownButton(
                      isExpanded: true,
                      focusColor: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: sortBy['Storage'],
                      items: List<DropdownMenuItem<String>>.generate(
                          Computer
                              .getUniqueValue(_computerList, 'Storage')
                              .length, (index) {
                        var tmp =
                        Computer.getUniqueValue(_computerList, 'Storage');
                        return DropdownMenuItem(
                            value: tmp[index], child: Text(tmp[index]));
                      }),
                      onChanged: (Object? value) {
                        setState(() {
                          sortBy['Storage'] = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    bottom: 10, top: 10, right: 30, left: 30),
                child: Divider(),
              ),
              MaterialButton(
                child: Text("Добавить запись"),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context){
                        List<TextEditingController> tmp =
                        List.generate(10, (index) => TextEditingController());
                        return Computer.addDialog(tmp, context, () {
                          var tmpComputer = Computer(
                            model: tmp[0].text,
                            invNumber: tmp[1].text,
                            serialNumber: tmp[2].text,
                            productNumber: tmp[3].text,
                            buhNumber: tmp[4].text,
                            supplyId: tmp[5].text,
                            userName: tmp[6].text,
                            storage: tmp[7].text,
                            sealNumber: tmp[8].text,
                            comment: tmp[9].text,
                          );
                          try {
                            setState(() {
                              DatabaseProvider.rawDatabaseQuery(Computer.insertDatabaseQuery(tmpComputer));
                              _computerList.add(tmpComputer);
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text("Запись добавлена"),
                              ));
                            });
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Ошибка: заполните все доступные поля"),
                            ));
                          };
                        });
                      },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
