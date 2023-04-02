import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

const String supplyTableName = 'Supply';

class SupplyFields {
  static final List<String> values = [
    id,
    date,
    supplier,
    techType,
    model,
    count,
    pricePerPos,
  ];

  static const String id = 'id';
  static const String date = 'date';
  static const String supplier = 'supplier';
  static const String techType = 'type_name';
  static const String count = 'count';
  static const String model = 'model';
  static const String pricePerPos = 'price_per_pos';
}

class Supply {
  int id;
  String? date;
  String? supplier;
  String? techType;
  String? model;
  int count;
  int pricePerPos;

  Supply({
    required this.id,
    this.date,
    this.supplier,
    this.techType,
    this.model,
    required this.count,
    required this.pricePerPos,
  });

  @override
  String toString() {
    return '''Supply is: {id: $id, date: $date, supplier: $supplier, techType: $techType, countr: $count, 
      pricePerPos: $pricePerPos, model: $model
    }''';
  }

  static const Map<int, String> techTypeMap = {
    0: 'Системный блок',
    1: 'Монитор',
    2: 'Ноутбук',
    3: 'Моноблок',
    4: 'Принтер',
    5: 'МФУ',
    6: 'ИБП',
  };

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'supplier': supplier,
      'type_name': techType,
      'model': model,
      'count': count,
      'pricePerPos': pricePerPos,
    };
  }

  Map<String, Object?> toJson() => {
        SupplyFields.id: id,
        SupplyFields.date: date,
        SupplyFields.supplier: supplier,
        SupplyFields.techType: techType,
        SupplyFields.model: model,
        SupplyFields.count: count,
        SupplyFields.pricePerPos: pricePerPos,
      };

  static Supply fromJson(Map<String, Object?> json) => Supply(
        id: json[SupplyFields.id] as int,
        date: json[SupplyFields.date] as String,
        supplier: json[SupplyFields.supplier] as String,
        techType: json[SupplyFields.techType] as String,
        model: json[SupplyFields.model] as String,
        count: json[SupplyFields.count] as int,
        pricePerPos: json[SupplyFields.pricePerPos] as int,
      );
  static const String selectDBQuery =
      '''select Supply.id, Supply.date, Supply.supplier, TechType.type_name, 
      Supply.model, Supply.count, Supply.price_per_pos 
      from Supply 
      INNER JOIN TechType on TechType.id = Supply.tech_type''';

  static String insertDBQuery(Supply data) {
    int techType = 1;
    techTypeMap.forEach((key, value) {
      if (data.model == value) techType = key + 1;
    });

    return '''
  INSERT INTO Supply (date, supplier, tech_type, model, count, price_per_pos)
  VALUES ('${data.date}', '${data.supplier}', ${techType.toString()}, '${data.model}', 
  ${data.count}, ${data.pricePerPos})
  ''';
  }

  static List<DataRow> generateDataRow(
      List<Supply> dataSource, Color rowColor) {
    List<DataRow> dataList = [];
    int iterator = 1;

    for (var element in dataSource) {
      if (iterator.isEven) {
        rowColor = Colors.grey.shade200;
      } else {
        rowColor = Colors.white;
      }
      dataList.add(
          DataRow(color: MaterialStateProperty.all<Color>(rowColor), cells: [
        DataCell(showEditIcon: true, Text('')),
        DataCell(Text(iterator.toString())),
        DataCell(Text(element.supplier.toString())),
        DataCell(Text(element.techType.toString())),
        DataCell(Text(element.model.toString())),
        DataCell(Text(element.date.toString())),
        DataCell(Text(element.count.toString())),
        DataCell(Text(element.pricePerPos.toString())),
        DataCell(Text((element.pricePerPos * element.count).toString())),
      ]));

      iterator++;
    }
    return dataList;
  }

  static List getUniqueValue(List<Supply> dataSource, String useCase) {
    List<String?> storageList = [];

    switch (useCase) {
      case "Supplier":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.supplier)) {
            storageList.add(element.supplier);
          }
        }
        break;
      case "Tech type":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.techType)) {
            storageList.add(element.techType);
          }
        }
        break;
      case "Date":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.date)) {
            storageList.add(element.date);
          }
        }
        break;
      case "Count":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.count)) {
            storageList.add(element.count.toString());
          }
        }
        break;
    }
    storageList.sort();
    return storageList;
  }

  static List<Supply> sort(List<Supply> dataSource,
      Map<String, String> sortRule, SfRangeValues value) {
    List<Supply> exitValue = []; /*Выходной список*/
    List<String> rules = []; /*Генерируемыей из Map список фильтров*/
    /*Тут конвертится Map в List*/
    for (var element in sortRule.values) {
      if (element.isNotEmpty) rules.add(element);
    }
    /*Проверка наличия фильтра и пустотый выходного списка*/
    if (sortRule['Supplier']!.isNotEmpty && exitValue.isEmpty) {
      /*Если входной список пустой, значит фильтрации до этого небыло - это первая
      * итерация фильтрации и следует сразу добавлять подходящие под критерий отбора записи
      * в выходной список*/
      for (var element in dataSource) {
        if (element.supplier == sortRule['Supplier']) {
          exitValue.add(element);
        }
      }
      /*Сюда попадаем только есть выходной список имеет какие-то значения, то есть
      * до этого он уже был отфильтрован по другому фильтру*/
    } else if (sortRule['Supplier']!.isNotEmpty) {
      /*Временный список для хранения значений под заданный фильтр. В целом нужен только
      * для того, чтобы не конфликтовал Итератор*/
      List<Supply> newSortedList = [];
      for (var element in exitValue) {
        /*Добавляем в newSortedList удовлетворяющие поиску записи*/
        if (element.supplier == sortRule['Supplier']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Tech type']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.techType == sortRule['Tech type']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Tech type']!.isNotEmpty) {
      List<Supply> newSortedList = [];

      for (var element in exitValue) {
        if (element.techType == sortRule['Tech type']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Date']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.date == sortRule['Date']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Date']!.isNotEmpty) {
      List<Supply> newSortedList = [];

      for (var element in exitValue) {
        if (element.date == sortRule['Date']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }
    if (sortRule['Price min']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.pricePerPos >= value.start &&
            element.pricePerPos <= value.end) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Price min']!.isNotEmpty) {
      List<Supply> newSortedList = [];

      for (var element in exitValue) {
        if (element.pricePerPos >= value.start &&
            element.pricePerPos <= value.end) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }
    if (rules.isEmpty) exitValue = dataSource;
    return exitValue;
  }
}
