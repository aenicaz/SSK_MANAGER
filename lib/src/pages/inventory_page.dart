import 'package:flutter/material.dart';
import 'package:ssk_manager/src/database_provider/database_provider.dart';
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
                List<TextEditingController> tmp = List.generate(10, (index) =>
                TextEditingController());
              return AlertDialog(
                title: Text('Редактировать запись'),
                content: Container(
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(element.model.toString()),
                                    TextField(
                                      controller: tmp[0],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(element.invNumber.toString()),
                                    TextField(
                                      controller: tmp[1],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(element.serialNumber.toString()),
                                    TextField(
                                      controller: tmp[2],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(element.productNumber.toString()),
                                    TextField(
                                      controller: tmp[3],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(element.buhNumber.toString()),
                                    TextField(
                                      controller: tmp[4],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(element.supplyId.toString()),
                                    TextField(
                                      controller: tmp[5],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(element.userName.toString(),),
                                    TextField(
                                      controller: tmp[6],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(element.storage.toString()),
                                    TextField(
                                      controller: tmp[7],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(element.sealNumber.toString()),
                                    TextField(
                                      controller: tmp[8],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(element.cleanDate.toString()),
                                    TextField(
                                      controller: tmp[9],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MaterialButton(
                                  onPressed: () {
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
                                          comment: element.comment
                                      );
                                      var index = element.id! - 1;
                                      _computerList[index] = tmpComputer;
                                    });
                                    Navigator.pop(context);
                                    },
                                  child: Text('Сохранить'),
                                ),
                                MaterialButton(
                                  onPressed: () {Navigator.pop(context);},
                                  child: Text('Закрыть'),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
          },);
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

  /*Метод сортирует список по заданным правилам и возвращает уже отсортированный список*/
  List<Computer> sort(List<Computer> dataSource, Map<String, String> sortRule) {
    List<Computer> exitValue = []; /*Выходной список*/
    List<String> rules = []; /*Генерируемыей из Map список фильтров*/
    /*Тут конвертится Map в List*/
    for (var element in sortRule.values) {
      if (element.isNotEmpty) rules.add(element);
    }
    /*Проверка наличия фильтра и пустотый выходного списка*/
    if (sortRule['User name']!.isNotEmpty && exitValue.isEmpty) {
      /*Если входной список пустой, значит фильтрации до этого небыло - это первая
      * итерация фильтрации и следует сразу добавлять подходящие под критерий отбора записи
      * в выходной список*/
      for (var element in dataSource) {
        if (element.userName == sortRule['User name']) {
          exitValue.add(element);
        }
      }
      /*Сюда попадаем только есть выходной список имеет какие-то значения, то есть
      * до этого он уже был отфильтрован по другому фильтру*/
    } else if (sortRule['User name']!.isNotEmpty) {
      /*Временный список для хранения значений под заданный фильтр. В целом нужен только
      * для того, чтобы не конфликтовал Итератор*/
      List<Computer> newSortedList = [];
      for (var element in exitValue) {
        /*Добавляем в newSortedList удовлетворяющие поиску записи*/
        if (element.userName == sortRule['User name']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Model']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.model == sortRule['Model']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Model']!.isNotEmpty) {
      List<Computer> newSortedList = [];

      for (var element in exitValue) {
        if (element.model == sortRule['Model']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Storage']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.storage == sortRule['Storage']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Storage']!.isNotEmpty) {
      List<Computer> newSortedList = [];

      for (var element in exitValue) {
        if (element.storage == sortRule['Storage']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Buh number']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.buhNumber == sortRule['Buh number']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Buh number']!.isNotEmpty) {
      List<Computer> newSortedList = [];

      for (var element in exitValue) {
        if (element.buhNumber == sortRule['Buh number']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Supply id']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.supplyId == sortRule['Supply id']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Supply id']!.isNotEmpty) {
      List<Computer> newSortedList = [];

      for (var element in exitValue) {
        if (element.supplyId == sortRule['Supply id']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Inv number']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.invNumber!
            .startsWith(sortRule['Inv number'].toString(), 0)) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Inv number']!.isNotEmpty) {
      List<Computer> newSortedList = [];

      for (var element in exitValue) {
        if (element.invNumber!
            .startsWith(sortRule['Inv number'].toString(), 0)) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (rules.isEmpty) exitValue = dataSource;
    return exitValue;
  }

  List<DataRow> getDataRow(
      List<Computer> dataSource, Map<String, String> sortRule) {
    if (dataSource.isEmpty) {
      getDataFromDb();
      return generateDataRow(sort(dataSource, sortRule));
    } else {
      return generateDataRow(sort(dataSource, sortRule));
    }
  }

  List getUniqueValue(List<Computer> dataSource, String useCase) {
    List<String?> storageList = [];

    switch (useCase) {
      case "Storage":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.storage)) {
            storageList.add(element.storage);
          }
        }
        break;
      case "User name":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.userName)) {
            storageList.add(element.userName);
          }
        }
        break;
      case "Buh number":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.buhNumber)) {
            storageList.add(element.buhNumber);
          }
        }
        break;
      case "Model":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.model)) {
            storageList.add(element.model);
          }
        }
        break;
        case "Supply id":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.supplyId)) {
            storageList.add(element.supplyId);
          }
        }
        break;
    }
    storageList.sort();
    return storageList;
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
                              dataRowList:
                                  getDataRow(_computerList, sortBy)),
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
                          getUniqueValue(_computerList, 'Model').length,
                          (index) {
                        var tmp = getUniqueValue(_computerList, 'Model');
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
                          getUniqueValue(_computerList, 'User name').length,
                          (index) {
                        var tmp = getUniqueValue(_computerList, 'User name');
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
                          getUniqueValue(_computerList, 'Buh number').length,
                          (index) {
                        var tmp = getUniqueValue(_computerList, 'Buh number');
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
                          getUniqueValue(_computerList, 'Supply id').length,
                          (index) {
                        var tmp = getUniqueValue(_computerList, 'Supply id');
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
                          getUniqueValue(_computerList, 'Storage').length,
                          (index) {
                        var tmp = getUniqueValue(_computerList, 'Storage');
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
            ],
          ),
        ],
      ),
    );
  }
}
