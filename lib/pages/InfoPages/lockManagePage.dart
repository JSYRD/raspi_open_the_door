import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/utils/lockUtils/addLock.dart';
import 'package:raspiopenthedoor/utils/lockUtils/operateLockPage.dart';
import 'package:raspiopenthedoor/utils/utils.dart';

class LockManagePage extends StatefulWidget {
  const LockManagePage({Key? key}) : super(key: key);
  @override
  State<LockManagePage> createState() => _LockManagePageState();
}

class _LockManagePageState extends State<LockManagePage> {
  var children = <Widget>[];

  void buildChildren() async {
    List<Lock> locks = await LockUtils.getLockList();
    List<Widget> _children = [];
    for (var element in locks) {
      _children.add(LockListInfo(
          id: element.id ?? -1,
          description: element.description,
          userId: element.userId,
          addr: element.addr,
          pressed: tryOperateLock));
    }
    setState(() {
      children = _children;
    });
  }

  void tryAddLock() async {
    Lock? lock = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AddLockPage();
        });
    if (lock == null) return;
    if (lock.userId == -1 || lock.addr.isEmpty) {
      MyToast.showToast("请填写正确的参数！");
      return;
    } else {
      switch (await LockUtils.addLock(lock)) {
        case 0:
          MyToast.showToast("添加成功！");
          break;
        case 1:
          MyToast.showToast("添加失败,锁已存在！");
          break;
        case 2:
          MyToast.showToast("网络连接错误！");
          break;
        case -1:
          MyToast.showToast("发生未知错误，请尝试联系管理员");
          break;
        default:
          break;
      }
    }
    buildChildren();
  }

  void tryOperateLock(dynamic id) async {
    Lock lock = await LockUtils.getSingleLock(id);
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return OperateLockPage(
              id: id,
              desc: lock.description,
              addr: lock.addr,
              userId: lock.userId);
        });
    buildChildren();
  }

  @override
  void initState() {
    buildChildren();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _c = [
      const Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("所有锁"),
      )
    ];
    _c.addAll(children);
    return Scaffold(
      appBar: AppBar(title: Text("我的锁")),
      body: ListView(
        children: children.isEmpty
            ? [
                const Center(
                    child: Text("暂无锁！", style: TextStyle(fontSize: 20.0)))
              ]
            : _c,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: tryAddLock,
        child: const Icon(Icons.add),
      ),
    );
  }
}
