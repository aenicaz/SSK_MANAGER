import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';

import '../widgets/left_side_menu.dart';

class GraphicPage extends StatefulWidget {
  const GraphicPage({Key? key}) : super(key: key);

  @override
  State<GraphicPage> createState() => _GraphicPageState();
}

class _GraphicPageState extends State<GraphicPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSK Resource / GraphicPage'),
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(null),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const LeftSideMenu(func: null),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    children: [
                      Text('Таблица моделей ПК'),
                      Expanded(
                        child: Chart(
                          data: [
                            {
                              'Model': 'HP ProDesk 490 G3 MT Business PC',
                              'sold': 15
                            },
                            {
                              'Model': 'Системный блок ДЦСС + KB + M',
                              'sold': 3
                            },
                            {'Model': 'DEPO Neos 481S_MNZ', 'sold': 4},
                            {'Model': 'LENOVO S510', 'sold': 20},
                            {'Model': 'Depo', 'sold': 5},
                          ],
                          variables: {
                            'Model': Variable(
                              accessor: (Map map) => map['Model'] as String,
                            ),
                            'sold': Variable(
                              accessor: (Map map) => map['sold'] as num,
                            ),
                          },
                          marks: [IntervalMark()],
                          axes: [
                            Defaults.horizontalAxis,
                            Defaults.verticalAxis,
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
