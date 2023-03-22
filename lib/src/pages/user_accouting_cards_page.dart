import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ssk_manager/src/database_provider/databace_provider.dart';
import 'package:ssk_manager/src/widgets/custom_table.dart';

import '../models/user.dart';
import '../widgets/left_side_menu.dart';

class UserAccoutiongCardPage extends StatefulWidget {
  const UserAccoutiongCardPage({super.key});

  @override
  State<UserAccoutiongCardPage> createState() => _UserAccoutiongCardPageState();
}

class _UserAccoutiongCardPageState extends State<UserAccoutiongCardPage> {
  List<User> userList = [];

  Future getUserDataFromDb() async {
    userList = await InventoryListDatabase.getUserDataFromDatabase();
  }

  List<DataRow> generateUserDataRow(List<User> userList) {
    List<DataRow> dataList = [];

    userList.forEach((element) {
      dataList.add(DataRow(cells: [
        DataCell(
            onTap: () {
              debugPrint(element.toString());
            },
            Text(element.id.toString())),
        DataCell(Text(element.name.toString())),
        DataCell(Text(element.status.toString())),
        DataCell(Text(element.jobTitle.toString())),
      ]));
      print(element.toString());
    });

    return dataList;
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSK Resource / UserAccoutiongCardPage'),
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
                          length: 2,
                          initialIndex: 0,
                          child: Column(
                            children: [
                              TabBar(
                                labelColor: Colors.black87,
                                indicatorColor: Colors.amber,
                                tabs: [
                                  Tab(
                                    text: 'Начальная страница',
                                  ),
                                  Tab(
                                    text: 'Пользователи',
                                  ),
                                ],
                              ),
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
