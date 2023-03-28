import 'package:flutter/material.dart';
import 'package:ssk_manager/src/consts/data.dart';
import 'package:ssk_manager/src/database_provider/databace_provider.dart';
import 'package:ssk_manager/src/widgets/custom_table.dart';
import 'package:ssk_manager/src/widgets/left_side_menu.dart';

import '../models/computers.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<Computer> _computerList = [];
  String _filter = '';
  List<String> tmpSelectedList = [];
  TextEditingController serialNumberTextController = TextEditingController();
  Map<String, String> sortBy = {
    'User name': '',
    'Buh number': '',
    'Storage': '',
    'Model': ''
  };

  bool flag = false;

  Future getDataFromDb() async {
    if (_computerList.isEmpty) {
      _computerList = await InventoryListDatabase.getComputerDataFromDatabase();

      for (var element in _computerList) {
        if (!filterList.contains(element.model)) {
          filterList.add(element.model);
        }
      }
    } else {
      return _computerList;
    }
  }

  List<DataRow> generateDataRow(List<Computer> dataSource) {
    List<DataRow> dataList = [];
    int iteraitor = 1;

    for (var element in dataSource) {
      if (element.model == _filter) {
        color = Colors.green;
      } else {
        if (iteraitor.isEven) {
          color = Colors.grey.shade300;
        } else {
          color = Colors.white;
        }
      }

      dataList
          .add(DataRow(color: MaterialStateProperty.all<Color>(color), cells: [
        DataCell(onTap: () {}, Text(iteraitor.toString())),
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
        DataCell(Text(element.userName.toString())),
        DataCell(Text(element.storage.toString())),
        DataCell(Text(element.sealNumber.toString())),
        DataCell(Text(element.comment.toString())),
      ]));

      iteraitor++;
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
      for (var element in exitValue) { /*Добавляем в newSortedList удовлетворяющие поиску записи*/
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
      List<Computer> tmp = [];

      for (var element in exitValue) {
        if (element.model == sortRule['Model']) {
          tmp.add(element);
        }
      }
      exitValue = tmp;
    }

    if (sortRule['Storage']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.storage == sortRule['Storage']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Storage']!.isNotEmpty) {
      List<Computer> tmp = [];

      for (var element in exitValue) {
        if (element.storage == sortRule['Storage']) {
          tmp.add(element);
        }
      }
      exitValue = tmp;
    }

    if (sortRule['Buh number']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.buhNumber == sortRule['Buh number']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Buh number']!.isNotEmpty) {
      List<Computer> tmp = [];

      for (var element in exitValue) {
        if (element.buhNumber == sortRule['Buh number']) {
          tmp.add(element);
        }
      }
      exitValue = tmp;
    }

    if(exitValue.isEmpty) return dataSource;
    return exitValue;
  }

  List<DataRow> getDataRow(
      List<Computer> dataSource, Map<String, String> sortRule) {
    if(flag) return generateDataRow(sort(dataSource, sortRule));
    else return generateDataRow(dataSource);
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
    }
    return storageList;
  }

  @override
  initState(){
    getDataFromDb();
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
              const LeftSideMenu(func: null),
              Expanded(
                flex: 5,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: getDataFromDb(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return CustomTable(
                                dataRowList: getDataRow(_computerList, sortBy));
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue.shade700,
                              ),
                            );
                          }
                        },
                      )
                    ]),
              ),
              Expanded(
                flex: 1,
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Модель'),
                              DropdownButton(
                                isExpanded: true,
                                focusColor: Colors.grey.shade200,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                value: sortBy['Model'],
                                items: List<DropdownMenuItem<String>>.generate(
                                    getUniqueValue(_computerList, 'Model')
                                        .length, (index) {
                                  var tmp =
                                      getUniqueValue(_computerList, 'Model');
                                  return DropdownMenuItem(
                                      value: tmp[index],
                                      child: Text(tmp[index]));
                                }),
                                onChanged: (Object? value) {
                                  setState(() {
                                    flag = true;
                                    sortBy['Model'] = value.toString();
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
                              const Text('Имя пользователя'),
                              DropdownButton(
                                isExpanded: true,
                                focusColor: Colors.grey.shade200,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                value: sortBy['User name'],
                                items: List<DropdownMenuItem<String>>.generate(
                                    getUniqueValue(_computerList, 'User name')
                                        .length, (index) {
                                  var tmp = getUniqueValue(
                                      _computerList, 'User name');
                                  return DropdownMenuItem(
                                      value: tmp[index],
                                      child: Text(tmp[index]));
                                }),
                                onChanged: (Object? value) {
                                  setState(() {
                                    flag = true;
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                value: sortBy['Buh number'],
                                items: List<DropdownMenuItem<String>>.generate(
                                    getUniqueValue(_computerList, 'Buh number')
                                        .length, (index) {
                                  var tmp = getUniqueValue(
                                      _computerList, 'Buh number');
                                  return DropdownMenuItem(
                                      value: tmp[index],
                                      child: Text(tmp[index]));
                                }),
                                onChanged: (Object? value) {
                                  setState(() {
                                    flag = true;
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
                              const Text('Место хранения'),
                              DropdownButton(
                                isExpanded: true,
                                focusColor: Colors.grey.shade200,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                value: sortBy['Storage'],
                                items: List<DropdownMenuItem<String>>.generate(
                                    getUniqueValue(_computerList, 'Storage')
                                        .length, (index) {
                                  var tmp =
                                      getUniqueValue(_computerList, 'Storage');
                                  return DropdownMenuItem(
                                      value: tmp[index],
                                      child: Text(tmp[index]));
                                }),
                                onChanged: (Object? value) {
                                  setState(() {
                                    flag = true;
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
