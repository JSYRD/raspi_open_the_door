// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
//
//                       _oo0oo_
//                      o8888888o
//                      88" . "88
//                      (| -_- |)
//                      0\  =  /0
//                    ___/`---'\___
//                  .' \\|     |// '.
//                 / \\|||  :  |||// \
//                / _||||| -:- |||||- \
//               |   | \\\  -  /// |   |
//               | \_|  ''\---/''  |_/ |
//               \  .-\__  '-'  ___/-. /
//             ___'. .'  /--.--\  `. .'___
//          ."" '<  `.___\_<|>_/___.' >' "".
//         | | :  `- \`.;`\ _ /`;.`/ - ` : | |
//         \  \ `_.   \_ __\ /__ _/   .-` /  /
//     =====`-.____`.___ \_____/___.-`___.-'=====
//                       `=---='
//
//
//     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//
//               佛祖保佑         永无BUG
//
//
//
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspiopenthedoor/pages/homePage.dart';
import 'package:raspiopenthedoor/utils/utils.dart';

// void main() {
//   runApp(const MyApp());
// }
// void main() {
//   runApp(ChangeNotifierProvider<mainThemeData>.value(
//       value: mainThemeData(), child: MyApp()));
// }
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
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch:
              Provider.of<MainThemeData>(context, listen: true).getThemeColor),
      home: MyHomePage(title: 'Raspi_FBI'),
      // routes: <String, WidgetBuilder>{
      //   '/bottomNavigatorWidget': (context) =>
      //       BottomNavigatorWidget(title: 'FBI')
      // },
    );
  }
}
