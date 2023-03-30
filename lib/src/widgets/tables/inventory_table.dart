import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class InventoryTable extends StatelessWidget {
  final List<DataRow> dataRowList;

  const InventoryTable({super.key, required this.dataRowList});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: DataTable2(
        columnSpacing: 12,
        horizontalMargin: 12,
        columns: const [
          DataColumn2(label: Text(''), fixedWidth: 30),
          DataColumn2(label: Text('ID'), fixedWidth: 30),
          DataColumn2(
            label: Text('Модель'),
          ),
          DataColumn2(
            label: Text('Инв. номер'),
            fixedWidth: 100
          ),
          DataColumn2(
            label: Text('Серийный номер'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Номер продукта'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Бухгалтерский номер'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Имя пользователся'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Место хранения'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Номер пломбы'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Примечание'),
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
