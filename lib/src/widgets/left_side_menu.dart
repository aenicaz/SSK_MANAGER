import 'package:flutter/material.dart';

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
              Navigator.pushNamed(context, '/');
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
              Navigator.pushNamed(context, '/incomePage');
              print('Поступления');
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
