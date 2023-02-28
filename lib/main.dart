// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspiopenthedoor/pages/homePage.dart';
import 'package:raspiopenthedoor/utils/utils.dart';


void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: ((context) => MainThemeData())),
    ChangeNotifierProvider(create: ((context) => LoginState()))
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Raspi_FBI',
      theme: ThemeData(
          primarySwatch:
              Provider.of<MainThemeData>(context, listen: true).getThemeColor),
      home: MyHomePage(title: 'Raspi_FBI'),
    );
  }
}
