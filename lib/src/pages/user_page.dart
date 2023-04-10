import 'package:flutter/material.dart';
import 'package:ssk_manager/src/models/user.dart';
import 'package:ssk_manager/src/widgets/tables/user_table.dart';

import '../database_provider/database_provider.dart';
import '../widgets/left_side_menu.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> _userList = [];
  Color color = Colors.grey.shade200;
  Map<String, String> sortBy = {
    'Name': '',
    'Status': '',
    'Job title': '',
  };

  TextEditingController nameTextController = TextEditingController();

  List<DataRow> generateDataRow(List<User> dataSource) {
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
        DataCell(onTap: () {
           showDialog(
            context: context,
            builder: (context) {
              List<TextEditingController> tmp =
                  List.generate(10, (index) => TextEditingController());
              return User.editDialog(element, tmp, context, () {
                try {
                  setState(() {
                    var tmpUser = User(
                        name : tmp[0].text,
                        status : tmp[1].text,
                        jobTitle : tmp[2].text
                    );
                    var index = element.id! - 1;
                    _userList[index] = tmpUser;

                    DatabaseProvider.rawDatabaseQuery(
                        User.updateDatabaseQuery(tmpUser));
                    Navigator.pop(context);
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Ошибка: заполните все доступные поля"),
                  ));
                }
              }, () {
                setState(() {
                  _userList.remove(element);
                  DatabaseProvider.rawDatabaseQuery(
                      User.removeDatabaseQuery(element));
                });
              });
            },
          );
        }, showEditIcon: true, Text('')),
        DataCell(Text(iterator.toString())),
        DataCell(Text(element.name.toString())),
        DataCell(Text(element.status.toString())),
        DataCell(Text(element.jobTitle.toString()))
      ]));

      iterator++;
    }
    return dataList;
  }

  List<DataRow> getDataRow(
      List<User> dataSource, Map<String, String> sortRule) {
    if (dataSource.isEmpty) {
      getDataFromDb();
      return generateDataRow(User.sort(dataSource, sortRule));
    } else {
      return generateDataRow(User.sort(dataSource, sortRule));
    }
  }

  Future getDataFromDb() async {
    if (_userList.isEmpty) {
      _userList = await DatabaseProvider.getUserDataFromDatabase();
      return _userList;
    } else {
      return _userList;
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
        title: const Text('SSK Resource / UserPage'),
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
                    if (_userList.isNotEmpty) {
                      return Row(
                        children: [
                          UserTabel(dataRowList: getDataRow(_userList, sortBy)),
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
                    const Text('Имя'),
                    TextField(
                      controller: nameTextController,
                      onChanged: (value) {
                        setState(() {
                          sortBy['Name'] = value;
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
                    const Text('Статус'),
                    DropdownButton(
                      isExpanded: true,
                      focusColor: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: sortBy['Status'],
                      items: List<DropdownMenuItem<String>>.generate(
                          User.getUniqueValue(_userList, 'Status').length,
                          (index) {
                        var tmp = User.getUniqueValue(_userList, 'Status');
                        return DropdownMenuItem(
                            value: tmp[index], child: Text(tmp[index]));
                      }),
                      onChanged: (Object? value) {
                        setState(() {
                          debugPrint(value.toString());
                          sortBy['Status'] = value.toString();
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
                    const Text('Должность'),
                    DropdownButton(
                      isExpanded: true,
                      focusColor: Colors.grey.shade200,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      value: sortBy['Job title'],
                      items: List<DropdownMenuItem<String>>.generate(
                          User.getUniqueValue(_userList, 'Job title').length,
                          (index) {
                        var tmp = User.getUniqueValue(_userList, 'Job title');
                        return DropdownMenuItem(
                            value: tmp[index], child: Text(tmp[index]));
                      }),
                      onChanged: (Object? value) {
                        setState(() {
                          sortBy['Job title'] = value.toString();
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
              MaterialButton(
                child: Text("Добавить запись"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context){
                      List<TextEditingController> tmp =
                      List.generate(10, (index) => TextEditingController());
                      return User.addDialog(tmp, context, () {
                        var tmpUser = User(
                          name : tmp[0].text,
                          status : tmp[1].text,
                          jobTitle : tmp[2].text
                        );
                        try {
                          setState(() {
                            DatabaseProvider.rawDatabaseQuery(User.insertDatabaseQuery(tmpUser));
                            _userList.add(tmpUser);
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
