import 'package:raspiopenthedoor/utils/utils.dart';
import 'package:http/http.dart' as http;

class OpenTheDoor {
  static Future<int> _openRequest(String token, int id) async {
    var url = '${Utils.url}/locks/$id/unlock';
    var _client = http.Client();
    var uri = Uri.parse("http://$url");
    try {
      var response =
          await _client.post(uri, headers: {'token': token}); //need body
      return response.statusCode;
      // print(response);
      // return 0;
      // if (responseData['code'] == '0') {
      //   return 0; //success
      // } else {
      //   return 1; //connected, but failed adding.
      // }
    } catch (error) {
      return -1; //network error
    }
  }

  static void tryOpenTheDoor(dynamic id) async {
    switch (await _openRequest(UserState.token, id)) {
      case 200:
        MyToast.showToast("成功开锁！");
        break;
      case 401:
        MyToast.showToast("验证失败！");
        break;
      case 404:
        MyToast.showToast("网络连接错误！");
        break;
      default:
        MyToast.showToast("发生未知错误，请联系管理员！");
        break;
    }
  }
}
