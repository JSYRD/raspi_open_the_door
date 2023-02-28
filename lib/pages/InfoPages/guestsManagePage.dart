import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/utils/utils.dart';

class GuestsManagePage extends StatefulWidget {
  const GuestsManagePage({Key? key}) : super(key: key);
  @override
  State<GuestsManagePage> createState() => _GuestsManagePageState();
}

class _GuestsManagePageState extends State<GuestsManagePage> {
  List<Widget> children = [];

  void buildChildren() async {
    List<User> users = await UserUtils.getUserList();
    List<Widget> _children = [];
    for (var element in users) {
      _children.add(UserListInfo(
          name: element.name,
          id: element.id ?? -1,
          userType: element.userType,
          pressed: tryOperateUser));
    }
    setState(() {
      children = _children;
    });
  }

  void tryAddUser() async {
    User user = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AddGuestPage();
        });
    if (user.name == '') {
      MyToast.showToast("请输入用户名！");
      return;
    } else {
      switch (await UserUtils.addUser(user)) {
        case 0:
          MyToast.showToast("添加成功！");
          break;
        case 1:
          MyToast.showToast("添加失败,用户已存在！");
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
  } //add codes here

  void tryOperateUser(dynamic id) async {
    User user = await UserUtils.getSingleUser(id);
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return OperateUserPage(
            id: id,
            userType: user.userType,
            name: user.name,
          );
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
        child: Text("所有用户"),
      )
    ];
    _c.addAll(children);
    return Scaffold(
      appBar: AppBar(
        title: const Text("访客管理"),
        primary: true,
      ),
      body: ListView(
          // shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: _c),
      floatingActionButton: FloatingActionButton(
        onPressed: tryAddUser,
        child: const Icon(Icons.add),
      ),
    );
  }
}
