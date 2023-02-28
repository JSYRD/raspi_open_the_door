import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/pages/InfoPages/infoPages.dart';
import 'package:raspiopenthedoor/utils/lockUtils/lockUtils.dart';

class OperatingPage extends StatefulWidget {
  const OperatingPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<OperatingPage> createState() => _OperatingPageState();
}

class _OperatingPageState extends State<OperatingPage> {
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
          pressed: OpenTheDoor.tryOpenTheDoor));
    }
    setState(() {
      children = _children;
    });
  }

  void _lockManage() async {
    await Navigator.push(
        context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return const LockManagePage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            }));
    buildChildren();
  }

  void _guestsManage() {
    Navigator.push(
        context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return const GuestsManagePage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            }));
  }

  void _monthlyReport() {
    Navigator.push(
        context,
        PageRouteBuilder(
            opaque: false,
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return const MonthlyReportPage();
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            }));
  }

  @override
  void initState() {
    buildChildren();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Open The Door"),
        primary: true,
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Image.asset("assets/headImage.jpeg"),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  _lockManage();
                },
                child: Column(
                  children: const [Icon(Icons.lock), Text("锁管理")],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(100, 100))),
              ),
              TextButton(
                onPressed: _monthlyReport,
                child: Column(
                  children: const [Icon(Icons.book), Text("服务月报")],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(100, 100))),
              ),
              TextButton(
                onPressed: _guestsManage,
                child: Column(
                  children: const [Icon(Icons.people), Text("租户管理")],
                  mainAxisAlignment: MainAxisAlignment.center,
                ),
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(const Size(100, 100))),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              "快捷开锁",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
                children: children.isEmpty
                    ? [const Text("暂无锁！", style: TextStyle(fontSize: 20.0))]
                    : children),
          )
          // ListView(
          //   children: [
          //     ListSelection(
          //         title: "锁0", icon: Icons.lock_sharp, function: () {})
          //   ],
          // )
        ],
      ),
    );
  }
}
