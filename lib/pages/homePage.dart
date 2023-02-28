// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/utils/utils.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _getUserName = TextEditingController();
  final TextEditingController _getUserPassword = TextEditingController();
  bool _passwordVisiable = true;
  bool _passwordRemembered = false;
  bool _autoLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            'Login',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
        ),
        primary: true,
        // centerTitle: true,

        backgroundColor: Colors.white,
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Text(
            'RPi-FBI登录',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                decoration: TextDecoration.none),
          ),
          Column(
            children: const <Widget>[Text('\n\n')],
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _getUserName,
                maxLines: 1,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: '用户名',
                    hintText: '用户名',
                    icon: Icon(Icons.person)),
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: _getUserPassword,
                maxLines: 1,
                obscureText: _passwordVisiable,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: '密码',
                    hintText: '密码',
                    suffixIcon: IconButton(
                        icon: Icon(_passwordVisiable
                            ? (Icons.visibility)
                            : (Icons.visibility_off)),
                        onPressed: () {
                          setState(() {
                            _passwordVisiable = !_passwordVisiable;
                          });
                        }),
                    icon: Icon(Icons.lock)),
              )),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        "记住密码",
                      ),
                      Checkbox(
                        value: _passwordRemembered,
                        onChanged: (value) {
                          setState(() {
                            _passwordRemembered = !_passwordRemembered;
                          });
                        },
                      )
                    ],
                  )),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text("自动登录"),
                      Checkbox(
                        value: _autoLogin,
                        onChanged: (value) {
                          setState(() {
                            _autoLogin = !_autoLogin;
                          });
                        },
                      )
                    ],
                  )),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        TryLogin.tryLogin(
                            context, _getUserName.text, _getUserPassword.text);
                      },
                      child: Text('登录'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          alignment: Alignment.center))),
              Padding(
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation) {
                                  return BottomNavigatorWidget(
                                    title: 'FBI',
                                  );
                                },
                                transitionsBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation,
                                    Widget child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                }));
                      },
                      child: Text('试用'),
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(100, 50),
                          alignment: Alignment.center))),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      )),
    );
  }
}
