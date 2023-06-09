import 'package:flutter/material.dart';

const String armTableName = 'Arm';

class ArmFields {
  static final List<String> values = [
    id,
    armNumber,
    equipmentId,
    userId,
    receiveDate,
    returnDate,
    armModel,
    workplace,
    room
  ];

  static const String id = 'id';
  static const String armNumber = 'armNumber';
  static const String armModel = 'model';
  static const String equipmentId = 'equipment_id';
  static const String userId = 'name';
  static const String receiveDate = 'receiveDate';
  static const String returnDate = 'returnDate';
  static const String workplace = 'workplace';
  static const String room = 'room';
}

class Arm {
  int? id;
  int? armNumber;
  int? equipmentId;
  String? userId;
  String? receiveDate;
  String? returnDate;
  String? armModel;
  String? workplace;
  String? room;

  Arm({
    this.id,
    this.armNumber,
    this.equipmentId,
    this.userId,
    this.receiveDate,
    this.returnDate,
    this.armModel,
    this.workplace,
    this.room,
  });

  @override
  String toString() {
    return '''Recod: {id: $id, armNumber: $armNumber, equipmentId: $equipmentId, 
    userId: $userId, receiveDate: $receiveDate, returnDate: $returnDate, workplace: $workplace,
    room: $room, arm: $armModel}''';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'armNumber': armNumber,
      'equipmentId': equipmentId,
      'name': userId,
      'receiveDate': receiveDate,
      'returnDate': returnDate,
      'model': armModel,
      'workplace': workplace,
      'room': room,
    };
  }

  static String updateDatabaseQuery(Arm arm) {
    return ''' update $armTableName
    set
	    ${ArmFields.armNumber} = "${arm.armNumber}",
	    ${ArmFields.equipmentId} = "${arm.equipmentId}",
	    ${ArmFields.userId} = "${arm.userId}",
	    ${ArmFields.receiveDate} = "${arm.receiveDate}",
	    ${ArmFields.returnDate} = "${arm.returnDate}",
	    ${ArmFields.workplace} = "${arm.workplace}",
	    ${ArmFields.armModel} = "${arm.armModel}",
	    ${ArmFields.room} = "${arm.room}"
	  where ${ArmFields.id} = ${arm.id}
  ''';
  }

  static String insertDatabaseQuery(Arm arm) {
    return '''
  INSERT INTO $armTableName (
    ${ArmFields.armNumber},
    ${ArmFields.equipmentId},
    ${ArmFields.userId},
    ${ArmFields.receiveDate},
    ${ArmFields.returnDate},
    ${ArmFields.armModel},
    ${ArmFields.workplace},
    ${ArmFields.room}
  )
  VALUES (
    "${arm.armNumber}",
    "${arm.equipmentId}",
    "${arm.userId}",
    "${arm.receiveDate}",
    "${arm.returnDate}",
    "${arm.armModel}",
    "${arm.workplace}",
    "${arm.room}"
  )
  ''';
  }

  static String removeDatabaseQuery(Arm arm) {
    return '''
      delete from $armTableName
      where ${ArmFields.id} = ${arm.id} 
    ''';
  }

  Map<String, Object?> toJson() => {
        ArmFields.id: id,
        ArmFields.armNumber: armNumber,
        ArmFields.equipmentId: equipmentId,
        ArmFields.userId: userId,
        ArmFields.receiveDate: receiveDate,
        ArmFields.returnDate: returnDate,
        ArmFields.armModel: armModel,
        ArmFields.workplace: workplace,
        ArmFields.room: room
      };

  static Arm fromJson(Map<String, Object?> json) => Arm(
      id: json[ArmFields.id] as int?,
      armNumber: json[ArmFields.armNumber] as int?,
      equipmentId: json[ArmFields.equipmentId] as int?,
      userId: json[ArmFields.userId] as String?,
      receiveDate: json[ArmFields.receiveDate] as String?,
      returnDate: json[ArmFields.returnDate] as String?,
      armModel: json[ArmFields.armModel] as String?,
      room: json[ArmFields.room] as String?,
      workplace: json[ArmFields.workplace] as String?);

  static List<Arm> sort(List<Arm> dataSource, Map<String, String> sortRule) {
    List<Arm> exitValue = []; /*Выходной список*/
    List<String> rules = []; /*Генерируемыей из Map список фильтров*/
    /*Тут конвертится Map в List*/
    for (var element in sortRule.values) {
      if (element.isNotEmpty) rules.add(element);
    }
    if (sortRule['Arm number']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.armNumber == int.parse(sortRule['Arm number']!)) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Arm number']!.isNotEmpty) {
      List<Arm> newSortedList = [];

      for (var element in exitValue) {
        if (element.armNumber == int.parse(sortRule['Arm number']!)) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }
    if (sortRule['Model']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.armModel == sortRule['Model']!) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Model']!.isNotEmpty) {
      List<Arm> newSortedList = [];

      for (var element in exitValue) {
        if (element.armModel == sortRule['Model']!) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }
    if (sortRule['Equipment id']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.equipmentId == int.parse(sortRule['Equipment id']!)) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Equipment id']!.isNotEmpty) {
      List<Arm> newSortedList = [];

      for (var element in exitValue) {
        if (element.equipmentId == int.parse(sortRule['Equipment id']!)) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }
    if (sortRule['User id']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.userId == sortRule['User id']!) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['User id']!.isNotEmpty) {
      List<Arm> newSortedList = [];

      for (var element in exitValue) {
        if (element.userId == sortRule['User id']!) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }
    if (sortRule['ReceiveDate']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.receiveDate == sortRule['ReceiveDate']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['ReceiveDate']!.isNotEmpty) {
      List<Arm> newSortedList = [];

      for (var element in exitValue) {
        if (element.receiveDate == sortRule['ReceiveDate']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }
    if (sortRule['ReturnDate']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.returnDate == sortRule['ReturnDate']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['ReturnDate']!.isNotEmpty) {
      List<Arm> newSortedList = [];

      for (var element in exitValue) {
        if (element.returnDate == sortRule['ReturnDate']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }
    if (sortRule['Workplace']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.workplace == sortRule['Workplace']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Workplace']!.isNotEmpty) {
      List<Arm> newSortedList = [];

      for (var element in exitValue) {
        if (element.workplace == sortRule['Workplace']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }
    if (sortRule['Room']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.room == sortRule['Room']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Room']!.isNotEmpty) {
      List<Arm> newSortedList = [];

      for (var element in exitValue) {
        if (element.room == sortRule['Room']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (rules.isEmpty) exitValue = dataSource;
    return exitValue;
  }

  static List getUniqueValue(List<Arm> dataSource, String useCase) {
    List<String?> storageList = [];

    switch (useCase) {
      case "Arm number":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.armNumber.toString())) {
            storageList.add(element.armNumber.toString());
          }
        }
        break;
      case "Equipment id":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.equipmentId.toString())) {
            storageList.add(element.equipmentId.toString());
          }
        }
        break;
      case "User id":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.userId.toString())) {
            storageList.add(element.userId.toString());
          }
        }
        break;
      case "ReceiveDate":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.receiveDate)) {
            storageList.add(element.receiveDate);
          }
        }
        break;
      case "ReturnDate":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.returnDate)) {
            storageList.add(element.returnDate);
          }
        }
        break;
      case "Arm model":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.armModel)) {
            storageList.add(element.armModel);
          }
        }
        break;
      case "Workplace":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.workplace)) {
            storageList.add(element.workplace);
          }
        }
        break;
      case "Room":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.room)) {
            storageList.add(element.room);
          }
        }
        break;
    }
    storageList.sort();
    return storageList;
  }

  static AlertDialog addDialog(
      List<TextEditingController> tmp, BuildContext context, Function()? func) {
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
                                hintText: 'Имя',
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
                              decoration:
                                  const InputDecoration(hintText: 'Статус'),
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
                              decoration:
                                  const InputDecoration(hintText: 'Должность'),
                              controller: tmp[2],
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

  static AlertDialog editDialog(Arm element, List<TextEditingController> tmp,
      BuildContext context, Function()? func, Function()? func2) {
    tmp[0].text = element.armNumber!.toString();
    tmp[1].text = element.equipmentId!.toString();
    tmp[2].text = element.userId!.toString();

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
