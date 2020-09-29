import 'package:flutter/material.dart';

class MKDropDownMenuController extends ChangeNotifier {
  bool menuIsShowing = false;

  void showMenu() {
    menuIsShowing = true;
    notifyListeners();
  }

  void hideMenu() {
    menuIsShowing = false;
    notifyListeners();
  }

  void toggleMenu() {
    menuIsShowing = !menuIsShowing;
    notifyListeners();
  }
}

class MKDropDownMenu<T extends MKDropDownMenuController>
    extends StatefulWidget {
  MKDropDownMenu({
    this.barrierColor = Colors.black12,
    this.controller,
    this.headerBuilder,
    this.menuBuilder,
  })  : assert(headerBuilder != null),
        assert(menuBuilder != null);

  final Color barrierColor;
  final T controller;
  final Widget Function(bool menuIsShowing) headerBuilder;
  final Widget Function() menuBuilder;
  @override
  _MKDropDownMenuState createState() => _MKDropDownMenuState();
}

class _MKDropDownMenuState extends State<MKDropDownMenu> {
  var _controller;
  OverlayEntry _overlayEntry;
  GlobalKey _headerKey = GlobalKey();

  _updateView() {
    if (_controller.menuIsShowing) {
      _showMenu();
    } else {
      _hideMenu();
    }
    setState(() {});
  }

  _buildOverlay() {
    if (_headerKey == null) return;
    RenderBox renderBox = _headerKey.currentContext.findRenderObject();
    Offset offset = renderBox.localToGlobal(Offset.zero);
    double top = renderBox.size.height + offset.dy;
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: _controller.hideMenu,
                child: Container(
                  height: top,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Material(
                  child: widget.menuBuilder(),
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: _controller.hideMenu,
                  child: Container(
                    color: widget.barrierColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _showMenu() {
    _buildOverlay();
    Overlay.of(context).insert(_overlayEntry);
  }

  _hideMenu() {
    _overlayEntry?.remove();
  }

  @override
  void initState() {
    _controller = widget.controller;
    if (_controller == null) _controller = MKDropDownMenuController();
    _controller.addListener(_updateView);
    super.initState();
  }

  @override
  void dispose() {
    _hideMenu();
    _controller.removeListener(_updateView);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _controller.toggleMenu,
      child: Container(
        key: _headerKey,
        child: widget.headerBuilder(_controller.menuIsShowing),
      ),
    );
  }
}
