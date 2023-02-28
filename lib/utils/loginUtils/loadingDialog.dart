import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspiopenthedoor/utils/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingDialog extends StatefulWidget {
  const LoadingDialog({Key? key}) : super(key: key);
  @override
  State<LoadingDialog> createState() => LoadingDialogState();

  ///Try to login using [userName] and [userPassword].Time limitation is 3 seconds.
  ///Returns statusCode if successfully connected to [utils.URL], else throws `TimeoutException`
  ///or other possible Exceptions. It will also try to call the function:
  ///```
  ///Provider.of<LoginState>(context, listen: false)
  ///  .login(responseData['token'], response.statusCode);
  ///```
  static Future<int> loginRequest(
      String userName, String userPassword, BuildContext context) async {
    try {
      var _client = http.Client();
      var uri = Uri.parse("http://${Utils.url}/login");
      // var requestBody = {'userName': userName, 'userPassword': userPassword};
      // http.Response response;
      var response = await _client
          .post(uri,
              headers: {'content-type': 'application/json'},
              body: json.encode({'name': userName, 'password': userPassword}))
          .timeout(const Duration(seconds: 3));
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        Provider.of<LoginState>(context, listen: false).login(
            responseData['token'],
            response.statusCode,
            responseData['user_id'],
            userName);
      } else {
        Provider.of<LoginState>(context, listen: false)
            .loginFailed(response.statusCode);
      }
      _client.close();
      return response.statusCode;
    } catch (error) {
      rethrow;
    } finally {
      try {
        // _client.close();
      } catch (_) {}
    }
  }

  ///Shows the `LoadingDialog` and trys to login at the same time. If login succesfully, it will
  ///call
  ///```
  ///Navigator.pushReplacement(...
  ///```
  ///to navigate to `BottomNavigatorWidget`,else pop itself.
  ///
  ///Returns http statusCode.
  static Future<int> showAlertDialog(
      BuildContext context, String userName, String userPassword) async {
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
            builder: ((context, setState) => const LoadingDialog()))); //先显示

    try {
      int state =
          await loginRequest(userName, userPassword, context).then((value) {
        //发请求并返回结果
        return value;
      });
      return state;
    } catch (error) {
      Provider.of<LoginState>(context, listen: false).loginFailed(-1);
      return -1;
    } finally {
      Future.delayed(const Duration(seconds: 1), () {
        var statusCode =
            Provider.of<LoginState>(context, listen: false).getState;
        if (statusCode != 200) {
          Navigator.pop(context);
        } else {
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return const BottomNavigatorWidget(title: "FBI");
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
        }
      });
    }
  }
}

class LoadingDialogState extends State<LoadingDialog> {
  int statusCode = 0;

  @override
  Widget build(BuildContext context) {
    statusCode = Provider.of<LoginState>(context, listen: true).getState;
    return Center(
      child: Material(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                ///点击事件
                onTap: () {},
              ),
              _dialog(context)
            ],
          )),
    );
  }

  Widget _stateIcon(int statusCode) {
    return statusCode == 0
        ? const CircularProgressIndicator()
        : statusCode == 200
            ? const Icon(Icons.check)
            : const Icon(Icons.close);
  }

  Widget _stateText(int statusCode) {
    return Text(
        statusCode == 0
            ? "正在登录"
            : statusCode == 200
                ? "登录成功"
                : statusCode == -1
                    ? "网络连接失败"
                    : "用户名或密码错误",
        style: const TextStyle(fontSize: 16.0));
  }

  Widget _dialog(BuildContext context) {
    return Center(
      ///弹框大小
      child: SizedBox(
        width: 150.0,
        height: 150.0,
        child: Container(
          ///弹框背景和圆角
          decoration: const ShapeDecoration(
            color: Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _stateIcon(statusCode),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: _stateText(statusCode),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
