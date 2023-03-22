import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class UserTable extends StatelessWidget {
  final List<DataRow> dataRowList;

  const UserTable({super.key, required this.dataRowList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DataTable2(
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: 100,
            columns: [
              DataColumn2(
                  label: Text('ID'),
                  fixedWidth: 30
              ),
              DataColumn2(
                label: Text('Имя'),
              ),
              DataColumn2(
                label: Text('Статус'),
              ),
              DataColumn2(
                label: Text('Должность'),
                size: ColumnSize.S,
              ),
            ],
            rows: dataRowList,
          dividerThickness: 1,
          dataRowHeight: 60,
        ),
    );
  }
}
