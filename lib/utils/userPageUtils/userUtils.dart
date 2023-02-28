import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:raspiopenthedoor/utils/utils.dart';

class User {
  int? id;
  String userType;
  String name;
  String password;
  User(
      {this.id,
      required this.name,
      required this.password,
      required this.userType});
  static User getUnknownUser() {
    return User(
        name: "Peter parker", password: "114514", userType: "Super hero");
  }
}

class UserUtils {
  static Future<List<User>> getUserList() async {
    var _client = http.Client();
    var users = <User>[];
    var uri = Uri.parse("http://${Utils.url}/users");
    try {
      var response = await _client.get(uri, headers: {
        'Content-Type': 'application/json',
        'token': UserState.token
      });
      final List<dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var element in responseData) {
          users.add(User(
            id: element['id'],
            name: element['name'],
            password: element['password'],
            userType: element["user_type"],
          ));
        } //success
      }
    } catch (error) {
      MyToast.showToast("网络连接失败！请检查是否连接到局域网！");
    }
    return users;
  }

  static Future<User> getSingleUser(int id) async {
    User user = User.getUnknownUser();
    var url = '${Utils.url}/users/$id';
    var _client = http.Client();
    var uri = Uri.parse("http://$url");
    try {
      var response = await _client.get(
        uri,
        headers: {'Content-Type': 'applicaiton/json', 'token': UserState.token},
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      User _user = User(
          id: responseData['id'],
          name: responseData['name'],
          password: responseData['password'],
          userType: responseData['user_type']);
      user = _user;
    } catch (error) {
      MyToast.showToast("发生未知错误");
    }
    return user;
  }

  static Future<int> addUser(User user) async {
    var url = '${Utils.url}/users';
    var _client = http.Client();
    var guestName = user.name;
    var guestPassword = user.password;
    var uri = Uri.parse("http://$url");
    try {
      var temp = json.encode({
        "user_type": user.userType,
        "name": guestName,
        'password': guestPassword
      });
      var response = await _client.post(uri,
          headers: {
            'Content-Type': 'applicaiton/json',
            'token': UserState.token
          },
          body: temp); //need body
      // final Map<String, dynamic> responseData = json.decode(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return 0; //success
      } else if (response.statusCode >= 500 && response.statusCode < 600) {
        return 1; //connected, but failed adding.
      } else
        return 3; // unknown error
    } catch (error) {
      return 2; //network error
    }
  }

  static Future<int> deleteUser(int id) async {
    var url = '${Utils.url}/users/$id';
    var _client = http.Client();
    var uri = Uri.parse("http://$url");
    try {
      var response = await _client.delete(uri, headers: {
        'Content-Type': 'applicaiton/json',
        'token': UserState.token
      });
      if (response.statusCode >= 200 && response.statusCode < 300)
        return 0; //删除成功
      else
        return 1; //删除失败
    } catch (error) {
      MyToast.showToast("删除失败，请检查网络设置");
      return -1; //网络问题
    }
  }
}
