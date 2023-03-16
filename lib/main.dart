import 'package:flutter/material.dart';
import 'package:ssk_manager/src/pages/equipment_accounting_cards_%20page.dart';
import 'package:ssk_manager/src/pages/income_page.dart';
import 'package:ssk_manager/src/pages/inventory_page.dart';
import 'package:ssk_manager/src/pages/user_accouting_cards_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute:  '/',
      routes: {
        '/' : (context) => const InventoryPage(),
        '/incomePage' : (context) => const IncomePage(),
        '/equipmentAccountingCardPage' : (context) => const EquipmentAccountingCardPage(),
        '/userAccoutiongCardPage' : (context) => const UserAccoutiongCardPage(),
      },
    );
  }
}
