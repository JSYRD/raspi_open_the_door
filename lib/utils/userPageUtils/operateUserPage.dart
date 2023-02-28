import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/utils/utils.dart';

class OperateUserPage extends StatefulWidget {
  final int id;
  final String userType;
  final String name;
  const OperateUserPage(
      {Key? key, required this.id, required this.userType, required this.name})
      : super(key: key);
  @override
  State<OperateUserPage> createState() => _OperateUserPageState();
}

class _OperateUserPageState extends State<OperateUserPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("管理"),
      scrollable: true,
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.person),
                Text(widget.name),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.numbers),
                Text(widget.id.toString()),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.group_sharp),
                Text(widget.userType),
              ],
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              UserUtils.deleteUser(widget.id).then((value) {
                switch (value) {
                  case 0:
                    MyToast.showToast("删除成功！");
                    break;
                  case -1:
                    MyToast.showToast("网络错误");
                    break;
                  case 1:
                    MyToast.showToast("删除失败，用户可能不存在。");
                    break;
                  case 2:
                    MyToast.showToast("什么都没发生");
                    break;
                }
              });
              Navigator.pop(context);
            },
            child: const Text("删除")),
        ElevatedButton(onPressed: () {}, child: const Text("修改"))
      ],
    );
  }
}
