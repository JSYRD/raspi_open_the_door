import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/utils/utils.dart';

class OperateLockPage extends StatefulWidget {
  final int id;
  final String desc;
  final String addr;
  final int userId;
  const OperateLockPage(
      {Key? key,
      required this.id,
      required this.desc,
      required this.addr,
      required this.userId})
      : super(key: key);
  @override
  State<OperateLockPage> createState() => _OperateLockPageState();
}

class _OperateLockPageState extends State<OperateLockPage> {
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
                Text("所有者：${widget.userId}"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.numbers),
                Text("锁序列号：${widget.addr}  id:${widget.id}"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.note_add),
                Text(widget.desc),
              ],
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              LockUtils.deleteLock(widget.id).then((value) {
                switch (value) {
                  case 0:
                    MyToast.showToast("删除成功！");
                    break;
                  case -1:
                    MyToast.showToast("网络错误");
                    break;
                  case 1:
                    MyToast.showToast("删除失败，锁可能不存在。");
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
