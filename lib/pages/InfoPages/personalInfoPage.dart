// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/utils/utils.dart';

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);
  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("个人信息"),
        primary: true,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(25.0),
        children: [
          ListInfo(title: "用户名", data: UserState.name),
          ListInfo(
              title: "连接状态", data: UserState.token == 'error' ? '未连接' : '已连接'),
        ],
      ),
    );
  }
}
