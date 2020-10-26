# MKDropDownMenu

Tap a widget wrapped with MKDropDownMenu to show a drop down menu. The header and menu are completely customizable.

# Features

- Completely Customizable: Header and Menu.
- Auto show below the Header Widget.
- Using Controller to build complex Menu.

# Demo

<div style="text-align: center">
    <table>
        <tr>
            <td style="text-align: center">
                <a href="https://raw.githubusercontent.com/malikwang/mk_drop_down_menu/master/images/1.png">
                    <img src="https://raw.githubusercontent.com/malikwang/mk_drop_down_menu/master/images/1.png" width="200"/>
                </a>
            </td>            
            <td style="text-align: center">
                <a href="https://raw.githubusercontent.com/malikwang/mk_drop_down_menu/master/images/2.png">
                    <img src="https://raw.githubusercontent.com/malikwang/mk_drop_down_menu/master/images/2.png" width="200"/>
                </a>
            </td>  
            <td style="text-align: center">
                <a href="https://raw.githubusercontent.com/malikwang/mk_drop_down_menu/master/images/3.png">
                    <img src="https://raw.githubusercontent.com/malikwang/mk_drop_down_menu/master/images/3.png" width="200"/>
                </a>
            </td>  
        </tr>
    </table>
</div>

# Usage

## Basic

```dart
MKDropDownMenu(
  headerBuilder: (bool menuIsShowing) {
    
  },
  menuBuilder: () {
    
  },
)
```

## Complex

```dart
class CustomDropDownMenuController extends MKDropDownMenuController {
  int curSelectedIndex = 0;
}

MKDropDownMenu<CustomDropDownMenuController>(
  controller: CustomDropDownMenuController(),
  headerBuilder: (bool menuIsShowing) {
    
  },
  menuBuilder: () {
    
  },
),
```

# Issue

Before version of 1.0.4, this plugin doesn't immediately hide menu when user press **'Physics Return'** on Android.

In the version of 1.0.4, we use WillPopScope to solve this issue. However, this solution would **disable Swipe Back Gesture** on IOS.

Therefore, In the version of 1.1.0, we the following code [(see in source code)](https://github.com/malikwang/mk_drop_down_menu/blob/master/lib/src/drop_down_menu.dart#L147) to solve this issue:

```dart
if (Platform.isIOS) {
  return child;
} else {
  return WillPopScope(
    onWillPop: () {
      _hideMenu();
      return Future.value(true);
    },
    child: child,
  );
}
```

**If your app also enable Swipe Back Gesture on Android, we suggest u modify this plugin╮(╯_╰)╭**