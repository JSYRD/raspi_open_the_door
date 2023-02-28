// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/pages/operatingPage.dart';
import 'package:raspiopenthedoor/pages/userInfoPage.dart';

class BottomNavigatorWidget extends StatefulWidget {
  const BottomNavigatorWidget({Key? key, required this.title})
      : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() => _BottomNavigatorWidgetState();
}

class _BottomNavigatorWidgetState extends State<BottomNavigatorWidget> {
  int _currentIndex = 0;
  List<Widget> pages = <Widget>[];
  @override
  void initState() {
    super.initState();
    pages
      ..add(OperatingPage(title: 'OperatingPage'))
      ..add(UserInfoPage(title: 'UserInfoPage'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.business), label: '操作'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '我的'),
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
