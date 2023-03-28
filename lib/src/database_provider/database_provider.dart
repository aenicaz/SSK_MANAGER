import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:ssk_manager/src/consts/ulr.dart';
import 'package:ssk_manager/src/models/computers.dart';

import '../models/user.dart';

class InventoryListDatabase {
  static var databaseData = [];

  static Future getComputerDataFromDatabase() async {
    sqfliteFfiInit();
    List<Computer> computerList = [];

    int _iterater = 1;
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(databaseUrl);

    databaseData = await db.rawQuery('select * from "$computersTableName"');

    await db.close();
    
    for(var i = 0; i < databaseData.asMap().length; i++){
      computerList.add(Computer.fromJson(databaseData.asMap()[i]));
      computerList[i].id = _iterater;

      _iterater++;
    }

    return computerList;
  }
  static Future getUserDataFromDatabase() async {
    sqfliteFfiInit();
    List<User> userList = [];

    int _iterater = 1;
    var databaseFactory = databaseFactoryFfi;
    var db = await databaseFactory.openDatabase(databaseUrl);

    databaseData = await db.rawQuery('select * from "$userTableName"');

    await db.close();

    for(var i = 0; i < databaseData.asMap().length; i++){
      userList.add(User.fromJson(databaseData.asMap()[i]));
      userList[i].id = _iterater;

      _iterater++;
    }

    return userList;
  }
}
