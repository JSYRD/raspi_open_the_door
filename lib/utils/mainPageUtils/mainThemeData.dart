import 'package:flutter/material.dart';

class MainThemeData with ChangeNotifier {
  static const MaterialColor pink = MaterialColor(0xFFF06292, <int, Color>{
    50: Color(0xFFF06292),
    100: Color(0xFFF06292),
    200: Color(0xFFF06292),
    300: Color(0xFFF06292),
    400: Color(0xFFF06292),
    500: Color(0xFFF06292),
    600: Color(0xFFF06292),
    700: Color(0xFFF06292),
    800: Color(0xFFF06292),
    900: Color(0xFFF06292),
  });
  int _currentIndex = 3;
  List<MaterialColor> colors = <MaterialColor>[
    Colors.red,
    Colors.blue,
    Colors.purple,
    MainThemeData.pink
  ];
  MaterialColor _themeColor = Colors.red;
  MaterialColor get getThemeColor => _themeColor;
  int get getCurrentIndex => _currentIndex;
  void changeThemeColor(int index) {
    _themeColor = colors[index];
    notifyListeners();
  }

  mainThemeData() {
    _themeColor = colors[3];
  }
}
