import 'package:flutter/material.dart';

import '../models/computers.dart';

class RightSideMenu extends StatelessWidget {
  final List<Computer> computerList;
  static List<bool> checkList = List.generate(4, (index) => false);

  const RightSideMenu({
    super.key,
    required this.computerList,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(30.0),
          child: Text('Фильтры'),
        ),
        ToggleButtons(
          isSelected: checkList,
          focusColor: Colors. green,
          children: [
            Icon(Icons.add),
            Icon(Icons.add),
            Icon(Icons.add),
            Icon(Icons.add),
          ],
          onPressed: (index) {

          },
        ),
      ],
    );
  }
}
