import 'dart:math';

import 'package:flutter/material.dart';

List providers = [
  "Provider 1",
  "Provider 2",
  "Provider 3",
  "Provider 4",
];

List techType = [
  'Cистемный блок',
  'Монитор',
  'Ноутбук',
  'Моноблок',
  'Принтер',
  'МФУ',
  'ИБП',
];

int buhNum = 0;
int count = 0;
int price = 0;
int totalPrice = 0;
Color color = Colors.grey.shade200;
int getAll(){
  buhNum = Random().nextInt(9999999);
  count = Random().nextInt(300);
  price = Random().nextInt(400000);
  totalPrice = price * count;
  card = Random().nextInt(20);

  return buhNum;
}

int card = 0;


List<DataRow> incomeList = List<DataRow>.generate(10,
        (index) => DataRow(cells:[
      DataCell(Text(DateTime.now().toString())),
      DataCell(Text(providers[Random().nextInt(3)].toString())),
      DataCell(Text(techType[Random().nextInt(6)].toString())),
      DataCell(Text(getAll().toString())),
      DataCell(Text(count.toString())),
      DataCell(Text(price.toString())),
      DataCell(Text(totalPrice.toString())),
      DataCell(Text(card.toString())),
    ])
);

List<String?> filterList = [];
