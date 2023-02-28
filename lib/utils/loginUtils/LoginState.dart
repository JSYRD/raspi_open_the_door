import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/utils/userState.dart';

class LoginState with ChangeNotifier {
  int _state = 0;
  int get getState => _state;

  ///Login and set [UserState.token] to [token], [_state] to [statusCode].
  ///[statusCode] comes from http response.statusCode. Temporarily:
  ///```
  ///{
  ///  200:Normal
  ///  401:Wrong account or passwd
  ///}
  ///```
  bool login(String token, int statusCode, int userId, String name) {
    if (token != UserState.token) {
      UserState.name = name;
      UserState.token = token;
      UserState.userId = userId;
      _state = statusCode;
      notifyListeners();
      return true;
    }
    return false;
  }

  ///ONLY SET [_state] to [statusCode]. This function exist for transport param [_state]
  ///to `LoadingDialog`.
  void loginFailed(int statusCode) {
    _state = statusCode;
    notifyListeners();
  }

  ///Logout and reset [_state] and [UserState.token].
  void logout() {
    _state = 0;
    UserState.token = 'error';
    notifyListeners();
  }

  ///RESET [_state] ONLY. This function exist for transport param [_state] to `LoadingDialog`.
  void reset() {
    _state = 0;
    UserState.token = 'error';
  }
}
