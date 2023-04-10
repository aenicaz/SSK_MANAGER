import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class SupplyTable extends StatelessWidget {
  final List<DataRow> dataRowList;

  const SupplyTable({super.key, required this.dataRowList});

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
          DataColumn2(label: Text('ID'), fixedWidth: 30),
          DataColumn2(
            label: Text('Поставщик'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Тип техники'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Модель'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Дата'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Количество, шт.'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Стоимость, руб.'),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Общая стоимость, руб.'),
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
