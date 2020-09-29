import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mk_drop_down_menu/mk_drop_down_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MKDropDownMenu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class CustomDropDownMenuController extends MKDropDownMenuController {
  int curSelectedIndex = 0;
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CustomDropDownMenuController _controller = CustomDropDownMenuController();
  List<String> _itemList = ['One', 'Two', 'Three', 'Four', 'Five'];

  _buildMenu() {
    double itemHeight = 50.0;
    return Column(
      children: _itemList.map((item) {
        int index = _itemList.indexOf(item);
        return GestureDetector(
          onTap: () {
            _controller.curSelectedIndex = index;
            _controller.hideMenu();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: itemHeight,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  width: 1,
                  color: const Color(0xFFEEF0F2),
                ),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Material(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        color: index == _controller.curSelectedIndex
                            ? Colors.blue
                            : Colors.black,
                      ),
                    ),
                    color: Colors.transparent,
                  ),
                ),
                if (index == _controller.curSelectedIndex)
                  Icon(
                    Icons.check,
                    size: 20,
                    color: Colors.blue,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MKDropDownMenu'),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: MKDropDownMenu<CustomDropDownMenuController>(
              controller: _controller,
              headerBuilder: (bool menuIsShowing) {
                return Container(
                  color: Colors.white,
                  height: 40,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Value: ${_itemList[_controller.curSelectedIndex]}',
                        style: TextStyle(
                          color: menuIsShowing ? Colors.blue : Colors.black,
                        ),
                      ),
                      Icon(
                        menuIsShowing ? Icons.expand_less : Icons.expand_more,
                        color: menuIsShowing ? Colors.blue : Colors.black,
                      ),
                    ],
                  ),
                );
              },
              menuBuilder: () => _buildMenu(),
            ),
          ),
          Expanded(
            flex: 1,
            child: MKDropDownMenu(
              headerBuilder: (bool menuIsShowing) {
                return Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFFEEF0F2),
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Header',
                        style: TextStyle(
                          color: menuIsShowing ? Colors.blue : Colors.black,
                        ),
                      ),
                      Icon(
                        menuIsShowing ? Icons.expand_less : Icons.expand_more,
                        color: menuIsShowing ? Colors.blue : Colors.black,
                      ),
                    ],
                  ),
                );
              },
              menuBuilder: () {
                return Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
