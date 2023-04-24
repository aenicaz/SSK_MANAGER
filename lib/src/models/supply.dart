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

  static String updateDatabaseQuery(Supply supply) {
    return ''' update $supplyTableName
    set
	    ${SupplyFields.date} = "${supply.date}",
	    ${SupplyFields.supplier} = "${supply.supplier}",
	    tech_type = "${supply.techType}",
	    ${SupplyFields.model} = "${supply.model}",
	    ${SupplyFields.count} = "${supply.count}",
	    ${SupplyFields.pricePerPos} = "${supply.pricePerPos}"
	  where ${SupplyFields.id} = ${supply.id}
  ''';
  }

  static String removeDatabaseQuery(Supply supply) {
    return '''
      delete from $supplyTableName
      where ${SupplyFields.id} = ${supply.id} 
    ''';
  }

  static String insertDatabaseQuery(Supply supply) {
    int techType = 1;
    techTypeMap.forEach((key, value) {
      if (supply.model == value) techType = key + 1;
    });
    return '''
  INSERT INTO Supply (date, supplier, tech_type, model, count, price_per_pos)
  VALUES ('${supply.date}', '${supply.supplier}', ${techType.toString()}, '${supply.model}', 
  ${supply.count}, ${supply.pricePerPos})
  ''';
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

  static AlertDialog editDialog(Supply element, List<TextEditingController> tmp,
      BuildContext context, Function()? func, Function()? func2) {
    tmp[0].text = element.supplier!;
    tmp[1].text = element.techType!;
    tmp[2].text = element.model!;
    tmp[3].text = element.date!;
    tmp[4].text = element.count.toString();
    tmp[5].text = element.pricePerPos.toString();
    return AlertDialog(
      title: const Text('Редактировать запись'),
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: tmp[0],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: tmp[1],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: tmp[2],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: tmp[3],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: tmp[4],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: tmp[5],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: func,
                        child: const Text('Сохранить'),
                      ),
                      MaterialButton(
                        onPressed: func2,
                        child: const Text('Удалить'),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Закрыть'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
