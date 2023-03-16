import 'package:flutter/material.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:ssk_manager/src/consts/ulr.dart';
import 'package:ssk_manager/src/models/computers.dart';


class InventoryListDatabase{
    static var databaseData = [];
    static var databaseData1 = [];
     
    static Future getDataFromDatabase() async {
      sqfliteFfiInit();

      var databaseFactory = databaseFactoryFfi;
      var db = await databaseFactory.openDatabase(databaseUrl);

      databaseData = await db.rawQuery('select * from "$computersTableName"') ;

      await db.close();
    } 
}