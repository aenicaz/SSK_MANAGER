import 'package:flutter/material.dart';

const String userTableName = 'User';

class UserFields {
  static final List<String> values = [
    id,
    name,
    status,
    jobTitle,
  ];

  static const String id = 'id';
  static const String name = 'name';
  static const String status = 'status';
  static const String jobTitle = 'jobTitle';
}

class User {
  int? id;
  String? name;
  String? status;
  String? jobTitle;

  User({
    this.id,
    this.name,
    this.status,
    this.jobTitle,
  });

  @override
  String toString() {
    return '''Recod: {id: $id, name: $name, status: $status, jobTitle: $jobTitle}''';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'jobTitle': jobTitle,
    };
  }

  static String updateDatabaseQuery(User user) {
    return ''' update $userTableName
    set
	    ${UserFields.name} = "${user.name}",
	    ${UserFields.status} = "${user.status}",
	    ${UserFields.jobTitle} = "${user.jobTitle}"
	  where ${UserFields.id} = ${user.id}
  ''';
  }

  static String insertDatabaseQuery(User user) {
    return '''
  INSERT INTO $userTableName (
    ${UserFields.name},
    ${UserFields.status},
    ${UserFields.jobTitle}
  )
  VALUES (
    "${user.name}",
    "${user.status}",
    "${user.jobTitle}"
  )
  ''';
  }

  static String removeDatabaseQuery(User user) {
    return '''
      delete from $userTableName
      where ${UserFields.id} = ${user.id} 
    ''';
  }

  Map<String, Object?> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.status: status,
        UserFields.jobTitle: jobTitle
      };

  static User fromJson(Map<String, Object?> json) => User(
      id: json[UserFields.id] as int?,
      name: json[UserFields.name] as String,
      status: json[UserFields.status] as String,
      jobTitle: json[UserFields.jobTitle] as String);

  static List<User> sort(List<User> dataSource, Map<String, String> sortRule) {
    List<User> exitValue = []; /*Выходной список*/
    List<String> rules = []; /*Генерируемыей из Map список фильтров*/
    /*Тут конвертится Map в List*/
    for (var element in sortRule.values) {
      if (element.isNotEmpty) rules.add(element);
    }
    if (sortRule['Name']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.name!.startsWith(sortRule['Name'].toString(), 0)) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Name']!.isNotEmpty) {
      List<User> newSortedList = [];

      for (var element in exitValue) {
        if (element.name!.startsWith(sortRule['Name'].toString(), 0)) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Status']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.status == sortRule['Status']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Status']!.isNotEmpty) {
      List<User> newSortedList = [];

      for (var element in exitValue) {
        if (element.status == sortRule['Status']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (sortRule['Job title']!.isNotEmpty && exitValue.isEmpty) {
      for (var element in dataSource) {
        if (element.jobTitle == sortRule['Job title']) {
          exitValue.add(element);
        }
      }
    } else if (sortRule['Job title']!.isNotEmpty) {
      List<User> newSortedList = [];

      for (var element in exitValue) {
        if (element.jobTitle == sortRule['Job title']) {
          newSortedList.add(element);
        }
      }
      exitValue = newSortedList;
    }

    if (rules.isEmpty) exitValue = dataSource;
    return exitValue;
  }

  static List getUniqueValue(List<User> dataSource, String useCase) {
    List<String?> storageList = [];

    switch (useCase) {
      case "Status":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.status)) {
            storageList.add(element.status);
          }
        }
        break;
      case "Job title":
        storageList.add('');
        for (var element in dataSource) {
          if (!storageList.contains(element.jobTitle)) {
            storageList.add(element.jobTitle);
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

  static AlertDialog editDialog(User element, List<TextEditingController> tmp,
      BuildContext context, Function()? func, Function()? func2) {
    tmp[0].text = element.name!;
    tmp[1].text = element.status!;
    tmp[2].text = element.jobTitle!;

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
