export 'package:raspiopenthedoor/utils/lockUtils/lockListInfo.dart';
export 'package:raspiopenthedoor/utils/lockUtils/openTheDoor.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:raspiopenthedoor/utils/utils.dart';

class Lock {
  int? id;
  String description;
  int userId;
  String addr; //0.0.0.0
  Lock(
      {this.id,
      required this.description,
      required this.userId,
      required this.addr});
  static Lock getEmptyLock() =>
      Lock(id: -1, userId: -1, addr: "", description: "一个新锁");
}

class LockUtils {
  static Future<List<Lock>> getLockList() async {
    var _client = http.Client();
    var locks = <Lock>[];
    var uri = Uri.parse("http://${Utils.url}/locks");
    try {
      var response = await _client.get(uri, headers: {
        'Content-Type': 'application/json',
        'token': UserState.token
      });
      final List<dynamic> responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var element in responseData) {
          locks.add(Lock(
              id: element['id'],
              description: element['description'],
              userId: element['user_id'],
              addr: element['addr']));
        }
      }
    } catch (error) {
      MyToast.showToast("网络连接失败！请检查是否连接到局域网！");
    }
    return locks;
  }

  static Future<Lock> getSingleLock(int id) async {
    Lock lock = Lock.getEmptyLock();
    var url = '${Utils.url}/locks/$id';
    var _client = http.Client();
    var uri = Uri.parse("http://$url");
    try {
      var response = await _client.get(
        uri,
        headers: {'Content-Type': 'applicaiton/json', 'token': UserState.token},
      );
      final Map<String, dynamic> responseData = json.decode(response.body);
      Lock _lock = Lock(
          id: responseData['id'],
          userId: responseData['user_id'],
          description: responseData['description'],
          addr: responseData['addr']);
      lock = _lock;
    } catch (error) {
      MyToast.showToast("发生未知错误");
    }
    return lock;
  }

  static Future<int> addLock(Lock lock) async {
    var url = '${Utils.url}/locks';
    var _client = http.Client();
    var lockUserId = lock.userId;
    var lockAddr = lock.addr;
    var uri = Uri.parse("http://$url");
    try {
      var temp = json.encode({
        "user_id": lockUserId,
        "addr": lockAddr,
        "description": lock.description
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

  static Future<int> deleteLock(int id) async {
    var url = '${Utils.url}/locks/$id';
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
