import 'package:flutter/material.dart';
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
  List<Computer> computerList = [];

  Future getDataFromDb() async {
    computerList = await InventoryListDatabase.getComputerDataFromDatabase();
  }

  List<DataRow> generateDataRow(List<Computer> computerList) {
    List<DataRow> dataList = [];

    computerList.forEach((element) {
      dataList.add(DataRow(cells: [
        DataCell(
            onTap: () {
          debugPrint(element.toString());
        },
            Text(element.id.toString())),
        DataCell(Text(element.model.toString())),
        DataCell(Text(element.invNumber.toString())),
        DataCell(Text(element.sealNumber.toString())),
        DataCell(Text(element.productNumber.toString())),
        DataCell(Text(element.buhName.toString())),
        DataCell(Text(element.userName.toString())),
        DataCell(Text(element.storage.toString())),
        DataCell(Text(element.sealNumber.toString())),
        DataCell(Text(element.comment.toString())),
      ]));
    });

    return dataList;
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                      future: getDataFromDb(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CustomTable(dataRowList: generateDataRow(computerList));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue.shade700,
                            ),
                          );
                        }
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
