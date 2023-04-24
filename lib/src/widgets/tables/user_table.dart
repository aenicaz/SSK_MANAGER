import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class UserTabel extends StatelessWidget {
  final List<DataRow> dataRowList;

  const UserTabel({super.key, required this.dataRowList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 100,
        columns: const [
          DataColumn2(label: Text(''), fixedWidth: 30),
          DataColumn2(label: Text('ID'), fixedWidth: 60),
          DataColumn2(
            label: Text('Имя'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Статус'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Должность'),
            size: ColumnSize.S,
          )
        ],
        rows: dataRowList,
        dividerThickness: 1,
        dataRowHeight: 60,
      ),
    );
  }
}
