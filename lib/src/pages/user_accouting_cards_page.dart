import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ssk_manager/src/database_provider/databace_provider.dart';

import '../widgets/left_side_menu.dart';

class UserAccoutiongCardPage extends StatefulWidget {
  const UserAccoutiongCardPage({super.key});

  @override
  State<UserAccoutiongCardPage> createState() => _UserAccoutiongCardPageState();
}

class _UserAccoutiongCardPageState extends State<UserAccoutiongCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSK Resource / UserAccoutiongCardPage'),
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
