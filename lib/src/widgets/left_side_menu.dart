import 'package:flutter/material.dart';
import 'package:ssk_manager/src/pages/inventory_page.dart';
import 'package:ssk_manager/src/pages/supply_page.dart';

class LeftSideMenu extends StatelessWidget {
  final Future? func;

  const LeftSideMenu({
    super.key,
    this.func,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,  MaterialPageRoute<void>(
                builder: (BuildContext context) => const InventoryPage(),
              ),);
            },
            child: Text('Инвентарная ведомость'),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/userAccoutiongCardPage');
              print('Карточки сотрудников');
            },
            child: Text('Карточки сотрудников'),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/equipmentAccountingCardPage');
              print('Карточки учёта');
            },
            child: Text('Карточки учёта'),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: TextButton(
            onPressed: () {
              Navigator.pushReplacement(context,  MaterialPageRoute<void>(
                builder: (BuildContext context) => const SupplyPage(),
              ),);
            },
            child: Text('Поступления'),
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: TextButton(
            onPressed: () {
              func;
              print('Поступления');
            },
            child: Text('ТЕСТ'),
          ),
        ),
      ],
    );
  }
}
