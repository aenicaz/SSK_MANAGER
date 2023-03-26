import 'package:flutter/foundation.dart';
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
  List<Computer> _computerSortList = [];
  String _filter = '';
  List<String> tmpSelectedList = [];
  Color color = Colors.grey.shade200;

  final List<bool> _selectedComputerList = List.generate(5, (index) => false);

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

  List<DataRow> getDataRow(List<Computer> computerList) {
    //метод возвращает уже отформатированный список записей
    List<DataRow> dataRowList = [];

    if (computerList.isEmpty) {
      //проверка на наличие записей из БД
      getDataFromDb(); //записи с бд в локальный список
      dataRowList = generateDataRow(computerList); //

      return dataRowList;
    } else if (_computerSortList.isEmpty) {
      for (var element in computerList) {

        if (tmpSelectedList.contains(element.model)) {
          _computerSortList.add(element);
        }
      }

      return generateDataRow(_computerSortList);
    } else if (_computerSortList.isNotEmpty) {
      _computerSortList.clear();

      for (var element in computerList) {
        if (tmpSelectedList.contains(element.model)) {
          _computerSortList.add(element);
        }
      }

      return generateDataRow(_computerSortList);
    } else if (tmpSelectedList.isEmpty) {
      return generateDataRow(computerList);
    } else {
      return generateDataRow(computerList);
    }
  }

  List<Padding> getSelectionComputerNameList() {
    List<Padding> filteredList = [];

    for (var element in filterList) {
      filteredList.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(element!),
      ));
    }

    return filteredList;
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
              LeftSideMenu(func: null),
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
                                dataRowList: getDataRow(_computerList));
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(30.0),
                      child: Text('Фильтры'),
                    ),
                    ToggleButtons(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      direction: Axis.vertical,
                      isSelected: _selectedComputerList,
                      focusColor: Colors.green,
                      children: getSelectionComputerNameList(),
                      onPressed: (index) {
                        setState(() {
                          _selectedComputerList[index] =
                              !_selectedComputerList[index];

                          if (tmpSelectedList.isEmpty) {
                            tmpSelectedList.add(filterList[index]!);
                          } else {
                            if (tmpSelectedList.contains(filterList[index]!)) {
                              tmpSelectedList.remove(filterList[index]!);
                            } else {
                              tmpSelectedList.add(filterList[index]!);
                            }
                          }
                          if(tmpSelectedList.length == 0){
                            tmpSelectedList.clear();
                          }
                          debugPrint(tmpSelectedList.length.toString());
                        });
                      },
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
