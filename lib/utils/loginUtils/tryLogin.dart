import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspiopenthedoor/utils/utils.dart';

class TryLogin {
  ///Trys to login using [userName] and [userPassword], shows `LoadingDialog` at the same time and
  ///handles possible exceptions.
  static void tryLogin(
      BuildContext context, String userName, String userPassword) async {
    //尝试登录，到这里context还是有效的
    String _userName = userName;
    String _userPassword = userPassword;
    int loginState = 0;
    if (_userName == '') {
      // consider super user with no passwd
      MyToast.showToast("请输入正确的用户名和密码！");
    } else {
      Provider.of<LoginState>(context, listen: false).reset();
      await LoadingDialog.showAlertDialog(context, _userName, _userPassword)
          .then(
        (value) {
          loginState = value;
        },
      );
      //发送请求，返回token
    }
    // if (loginState) {
    // } else {}
  }
}
