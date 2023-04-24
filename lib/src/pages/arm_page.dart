import 'package:flutter/material.dart';
import '../database_provider/database_provider.dart';
import '../models/arm.dart';
import '../widgets/left_side_menu.dart';
import '../widgets/tables/arm_table.dart';

class ArmPage extends StatefulWidget {
  const ArmPage({Key? key}) : super(key: key);

  @override
  State<ArmPage> createState() => _ArmPageState();
}

class _ArmPageState extends State<ArmPage> {
  List<Arm> _armList = [];
  Color color = Colors.grey.shade200;
  Map<String, String> sortBy = {
    'Arm number': '',
    'Equipment id': '',
    'User id': '',
    'ReceiveDate': '',
    'ReturnDate': '',
    'Model': '',
    'Workplace': '',
    'Room': ''
  };

  TextEditingController nameTextController = TextEditingController();

  List<DataRow> generateDataRow(List<Arm> dataSource) {
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
        DataCell(Text(element.id.toString())),
        DataCell(Text(element.armNumber.toString())),
        DataCell(Text(element.armModel.toString())),
        DataCell(Text(element.userId.toString())),
        DataCell(Text(element.receiveDate.toString())),
        DataCell(Text(element.returnDate.toString())),
        DataCell(Text(element.workplace.toString())),
        DataCell(Text(element.room.toString()))
      ]));

      iterator++;
    }
    return dataList;
  }

  List<DataRow> getDataRow(List<Arm> dataSource, Map<String, String> sortRule) {
    if (dataSource.isEmpty) {
      getDataFromDb();
      return generateDataRow(Arm.sort(dataSource, sortRule));
    } else {
      return generateDataRow(Arm.sort(dataSource, sortRule));
    }
  }

  Future getDataFromDb() async {
    if (_armList.isEmpty) {
      _armList = await DatabaseProvider.getArmDataFromDatabase();
      return _armList;
    } else {
      return _armList;
    }
  }

  @override
  void initState() {
    getDataFromDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSK Resource / ArmPage'),
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
              DefaultTabController(
                length: 2,
                child: Expanded(
                  child: Column(
                    children: [
                      const TabBar(labelColor: Colors.black87, tabs: [
                        Tab(text: "Таблица АРМ"),
                        Tab(text: "Добавить АРМ")
                      ]),
                      Expanded(
                          child: TabBarView(
                        children: [
                          FutureBuilder(
                            future: getDataFromDb(),
                            builder: (context, snapshot) {
                              if (_armList.isNotEmpty) {
                                return Row(
                                  children: [
                                    ArmTable(
                                        dataRowList:
                                            getDataRow(_armList, sortBy)),
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
                          const Placeholder(),
                        ],
                      )),
                    ],
                  ),
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
                    const Text('Номер АРМ'),
                    TextField(
                      controller: nameTextController,
                      onChanged: (value) {
                        setState(() {
                          sortBy['Arm number'] = value;
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
                    const Text('Здание'),
                    DropdownButton(
                      isExpanded: true,
                      focusColor: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: sortBy['Workplace'],
                      items: List<DropdownMenuItem<String>>.generate(
                          Arm.getUniqueValue(_armList, 'Workplace').length,
                          (index) {
                        var tmp = Arm.getUniqueValue(_armList, 'Workplace');
                        return DropdownMenuItem(
                            value: tmp[index], child: Text(tmp[index]));
                      }),
                      onChanged: (Object? value) {
                        setState(() {
                          debugPrint(value.toString());
                          sortBy['Workplace'] = value.toString();
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
                    const Text('Кабинет'),
                    DropdownButton(
                      isExpanded: true,
                      focusColor: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: sortBy['Room'],
                      items: List<DropdownMenuItem<String>>.generate(
                          Arm.getUniqueValue(_armList, 'Room').length, (index) {
                        var tmp = Arm.getUniqueValue(_armList, 'Room');
                        return DropdownMenuItem(
                            value: tmp[index], child: Text(tmp[index]));
                      }),
                      onChanged: (Object? value) {
                        setState(() {
                          debugPrint(value.toString());
                          sortBy['Room'] = value.toString();
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
                    const Text('Пользователь'),
                    DropdownButton(
                      isExpanded: true,
                      focusColor: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: sortBy['User id'],
                      items: List<DropdownMenuItem<String>>.generate(
                          Arm.getUniqueValue(_armList, 'User id').length,
                          (index) {
                        var tmp = Arm.getUniqueValue(_armList, 'User id');
                        return DropdownMenuItem(
                            value: tmp[index], child: Text(tmp[index]));
                      }),
                      onChanged: (Object? value) {
                        setState(() {
                          sortBy['User id'] = value.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(bottom: 10, top: 10, right: 30, left: 30),
                child: Divider(),
              ),
              // MaterialButton(
              //   child: Text("Добавить запись"),
              //   onPressed: () {
              //     showDialog(
              //       context: context,
              //       builder: (context) {
              //         List<TextEditingController> tmp =
              //             List.generate(10, (index) => TextEditingController());
              //         return User.addDialog(tmp, context, () {
              //           var tmpUser = User(
              //               name: tmp[0].text,
              //               status: tmp[1].text,
              //               jobTitle: tmp[2].text);
              //           try {
              //             setState(() {
              //               DatabaseProvider.rawDatabaseQuery(
              //                   Arm.insertDatabaseQuery(tmpUser));
              //               _armList.add(tmpUser);
              //               ScaffoldMessenger.of(context)
              //                   .showSnackBar(const SnackBar(
              //                 content: Text("Запись добавлена"),
              //               ));
              //             });
              //           } catch (e) {
              //             ScaffoldMessenger.of(context)
              //                 .showSnackBar(const SnackBar(
              //               content:
              //                   Text("Ошибка: заполните все доступные поля"),
              //             ));
              //           }
              //           ;
              //         });
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
