import 'package:flutter/material.dart';
import 'package:ssk_manager/src/pages/inventory_page.dart';
import 'package:ssk_manager/src/pages/supply_page.dart';


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
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const InventoryPage(),
        '/supplyPage' : (context) => const SupplyPage(),
      },
    );
  }
}
