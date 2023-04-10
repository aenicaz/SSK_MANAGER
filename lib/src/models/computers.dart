import 'package:flutter/material.dart';

final String computersTableName = 'Computers';

class ComputerFields {
  static final List<String> values = [
    id,
    model,
    buhName,
    serialNumber,
    productNumber,
    buhNumber,
    invNumber,
    supplyId,
    userName,
    storage,
    sealNumber,
    cleanDate,
    comment
  ];

  static final String id = 'id';
  static final String model = 'model';
  static final String buhName = 'buhName';
  static final String serialNumber = 'serialNumber';
  static final String productNumber = 'productNumber';
  static final String buhNumber = 'buhNumber';
  static final String invNumber = 'invNumber';
  static final String supplyId = 'supply_id';
  static final String userName = 'userName';
  static final String storage = 'storage';
  static final String sealNumber = 'sealNumber';
  static final String cleanDate = 'cleanDate';
  static final String comment = 'comment';
}

class Computer {
  int? id;
  String? buhName;
  String? model;
  String? serialNumber;
  String? productNumber;
  String? buhNumber;
  String? invNumber;
  String? supplyId;
  String? userName;
  String? storage;
  String? sealNumber;
  String? cleanDate;
  String? comment;

  Computer({
    this.id,
    this.model,
    this.buhName,
    this.serialNumber,
    this.productNumber,
    this.buhNumber,
    this.invNumber,
    this.supplyId,
    this.userName,
    this.storage,
    this.sealNumber,
    this.cleanDate,
    this.comment,
  });

  @override
  String toString() {
    return '''Recod: {id: $id, name: $model, buhName: $buhName, serial number: $serialNumber, product number: $productNumber, 
      inventory number: $invNumber, supply id: $supplyId user name: $userName, storage: $storage, seal number: $sealNumber, clean date: $cleanDate,
      comment: $comment
    }''';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'model': model,
      'buhName': buhName,
      'serialNumber': serialNumber,
      'productNumber': productNumber,
      'buhNumber': buhNumber,
      'invNumber': invNumber,
      'supplyId': supplyId,
      'userName': userName,
      'storage': storage,
      'sealNumber': sealNumber,
      'cleanDate': cleanDate,
      'comment': comment
    };
  }

  Map<String, Object?> toJson() => {
        ComputerFields.id: id,
        ComputerFields.model: model,
        ComputerFields.buhName: buhName,
        ComputerFields.serialNumber: serialNumber,
        ComputerFields.productNumber: productNumber,
        ComputerFields.buhNumber: buhNumber,
        ComputerFields.invNumber: invNumber,
        ComputerFields.supplyId: supplyId,
        ComputerFields.userName: userName,
        ComputerFields.storage: storage,
        ComputerFields.sealNumber: sealNumber,
        ComputerFields.cleanDate: cleanDate,
        ComputerFields.comment: comment,
      };

  static String updateDatabaseQuery (Computer computer){
    return ''' update $computersTableName
    set
	    ${ComputerFields.invNumber} = "${computer.invNumber}",
	    ${ComputerFields.model} = "${computer.model}",
	    ${ComputerFields.buhName} = "${computer.buhName}",
	    ${ComputerFields.serialNumber} = "${computer.serialNumber}",
	    ${ComputerFields.productNumber} = "${computer.productNumber}",
	    ${ComputerFields.buhNumber} = "${computer.buhNumber}",
	    ${ComputerFields.userName} = "${computer.userName}",
	    ${ComputerFields.storage} = "${computer.storage}",
	    ${ComputerFields.sealNumber} = "${computer.sealNumber}",
	    ${ComputerFields.cleanDate} = "${computer.cleanDate}",
	    ${ComputerFields.supplyId} = "${computer.supplyId}",
	    ${ComputerFields.comment} = "${computer.comment}"
	  where ${ComputerFields.id} = ${computer.id}
  ''';
  }
  static String insertDatabaseQuery(Computer computer) {
    return '''
  INSERT INTO $computersTableName (
    ${ComputerFields.invNumber},
    ${ComputerFields.model},
    ${ComputerFields.buhName},
    ${ComputerFields.serialNumber},
    ${ComputerFields.productNumber},
    ${ComputerFields.buhNumber},
    ${ComputerFields.userName},
    ${ComputerFields.storage},
    ${ComputerFields.sealNumber},
    ${ComputerFields.cleanDate},
    ${ComputerFields.supplyId},
    ${ComputerFields.comment}
  )
  VALUES (
    "${computer.invNumber}",
    "${computer.model}",
    "${computer.buhName}",
    "${computer.serialNumber}",
    "${computer.productNumber}",
    "${computer.buhNumber}",
    "${computer.userName}",
    "${computer.storage}",
    "${computer.sealNumber}",
    "${computer.cleanDate}",
    "${computer.supplyId}",   
    "${computer.comment}"
  )
  ''';
  }
  static String removeDatabaseQuery(Computer computer) {
    return '''
      delete from $computersTableName
      where ${ComputerFields.id} = ${computer.id} 
    ''';
  }

  static Computer fromJson(Map<String, Object?> json) => Computer(
        id: json[ComputerFields.id] as int?,
        model: json[ComputerFields.model] as String,
        buhName: json[ComputerFields.buhName] as String,
        serialNumber: json[ComputerFields.serialNumber] as String,
        productNumber: json[ComputerFields.productNumber] as String,
        buhNumber: json[ComputerFields.buhNumber] as String,
        invNumber: json[ComputerFields.invNumber] as String,
        supplyId: json[ComputerFields.supplyId] as String,
        userName: json[ComputerFields.userName] as String,
        storage: json[ComputerFields.storage] as String,
        sealNumber: json[ComputerFields.sealNumber] as String,
        cleanDate: json[ComputerFields.cleanDate] as String,
        comment: json[ComputerFields.comment] as String,
      );

  /*Метод сортирует список по заданным правилам и возвращает уже отсортированный список*/
  static List<Computer> sort(
      List<Computer> dataSource, Map<String, String> sortRule) {
    List<Computer> exitValue = []; /*Выходной список*/
    List<String> rules = []; /*Генерируемыей из Map список фильтров*/
    /*Тут конвертится Map в List*/
    for (var element in sortRule.values) {
      if (element.isNotEmpty) rules.add(element);
    }
    /*Проверка наличия фильтра и пустотый выходного списка*/
    if (sortRule['User name']!.isNotEmpty && exitValue.isEmpty) {
      /*Если входной список пустой, значит фильтрации до этого небыло - это первая
      * итерация фильтрации и следует сразу добавлять подходящие под критерий отбора записи
      * в выходной список*/
      for (var element in dataSource) {
        if (element.userName == sortRule['User name']) {
          exitValue.add(element);
        }
      }
      /*Сюда попадаем только есть выходной список имеет какие-то значения, то есть
      * до этого он уже был отфильтрован по другому фильтру*/
    } else if (sortRule['User name']!.isNotEmpty) {
      /*Временный список для хранения значений под заданный фильтр. В целом нужен только
      * для того, чтобы не конфликтовал Итератор*/
      List<Computer> newSortedList = [];
      for (var element in exitValue) {
        /*Добавляем в newSortedList удовлетворяющие поиску записи*/
        if (element.userName == sortRule['User name']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Model']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.model == sortRule['Model']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Model']!.isNotEmpty) {
      List<Computer> newSortedList = [];

      for (var element in exitValue) {
        if (element.model == sortRule['Model']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Storage']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.storage == sortRule['Storage']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Storage']!.isNotEmpty) {
      List<Computer> newSortedList = [];

      for (var element in exitValue) {
        if (element.storage == sortRule['Storage']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Buh number']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.buhNumber == sortRule['Buh number']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Buh number']!.isNotEmpty) {
      List<Computer> newSortedList = [];

      for (var element in exitValue) {
        if (element.buhNumber == sortRule['Buh number']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Supply id']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.supplyId == sortRule['Supply id']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Supply id']!.isNotEmpty) {
      List<Computer> newSortedList = [];

      for (var element in exitValue) {
        if (element.supplyId == sortRule['Supply id']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Inv number']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.invNumber!
            .startsWith(sortRule['Inv number'].toString(), 0)) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Inv number']!.isNotEmpty) {
      List<Computer> newSortedList = [];

      for (var element in exitValue) {
        if (element.invNumber!
            .startsWith(sortRule['Inv number'].toString(), 0)) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (rules.isEmpty) exitValue = dataSource;
    return exitValue;
  }

  static List getUniqueValue(List<Computer> dataSource, String useCase) {
    List<String?> storageList = [];

    switch (useCase) {
      case "Storage":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.storage)) {
            storageList.add(element.storage);
          }
        }
        break;
      case "User name":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.userName)) {
            storageList.add(element.userName);
          }
        }
        break;
      case "Buh number":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.buhNumber)) {
            storageList.add(element.buhNumber);
          }
        }
        break;
      case "Model":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.model)) {
            storageList.add(element.model);
          }
        }
        break;
      case "Supply id":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.supplyId)) {
            storageList.add(element.supplyId);
          }
        }
        break;
    }
    storageList.sort();
    return storageList;
  }

  static AlertDialog editDialog(
      Computer element, List<TextEditingController> tmp, BuildContext context,
      Function()? func, Function()? func2) {
    tmp[0].text = element.model!;
    tmp[1].text = element.invNumber!;
    tmp[2].text = element.serialNumber!;
    tmp[3].text = element.productNumber!;
    tmp[4].text = element.buhNumber!;
    tmp[5].text = element.supplyId!;
    tmp[6].text = element.userName!;
    tmp[7].text = element.storage!;
    tmp[8].text = element.serialNumber!;
    tmp[9].text = element.cleanDate!;
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
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextField(
                              controller: tmp[6],
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
                              controller: tmp[7],
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
                              controller: tmp[8],
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
                              controller: tmp[9],
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

  static AlertDialog addDialog(
      List<TextEditingController> tmp, BuildContext context,
      Function()? func) {
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
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'Модель',
                              ),
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
                               style: const TextStyle(
                                fontSize: 12,
                              ),
                               decoration: const InputDecoration(
                                hintText: 'Инв. номер'
                              ),
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
                               style: const TextStyle(
                                fontSize: 12,
                              ),
                               decoration: const InputDecoration(
                                hintText: 'Серийный номер'
                              ),
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
                               style: const TextStyle(
                                fontSize: 12,
                              ),
                               decoration: const InputDecoration(
                                hintText: 'Прод. номер'
                              ),
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
                               style: const TextStyle(
                                fontSize: 12,
                              ),
                               decoration: const InputDecoration(
                                hintText: 'Бух. номер'
                              ),
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
                               style: const TextStyle(
                                fontSize: 12,
                              ),
                               decoration: const InputDecoration(
                                hintText: 'Номер поставки'
                              ),
                              controller: tmp[5],
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
                               style: const TextStyle(
                                fontSize: 12,
                              ),
                               decoration: const InputDecoration(
                                hintText: 'Имя пользователя'
                              ),
                              controller: tmp[6],
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
                               style: const TextStyle(
                                fontSize: 12,
                              ),
                               decoration: const InputDecoration(
                                hintText: 'Место хранения'
                              ),
                              controller: tmp[7],
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
                               style: const TextStyle(
                                fontSize: 12,
                              ),
                               decoration: const InputDecoration(
                                hintText: 'Серийный номер'
                              ),
                              controller: tmp[8],
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
                               style: const TextStyle(
                                fontSize: 12,
                              ),
                               decoration: const InputDecoration(
                                hintText: 'Дата чистки'
                              ),
                              controller: tmp[9],
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
                        child: const Text('Добавить'),
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
