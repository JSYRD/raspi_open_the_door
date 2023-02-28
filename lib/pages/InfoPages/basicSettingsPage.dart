import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raspiopenthedoor/utils/utils.dart';

class BasicSettingsPage extends StatefulWidget {
  const BasicSettingsPage({Key? key}) : super(key: key);
  @override
  State<BasicSettingsPage> createState() => _BasicSettingsPageState();
}

class _BasicSettingsPageState extends State<BasicSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("基本设置"),
        primary: true,
      ),
      body: ListView(
        shrinkWrap: false,
        padding: const EdgeInsets.all(20.0),
        children: [
          ListSelectionColor(
            context: context,
          )
        ],
      ),
    );
  }
}

class ListSelectionColor extends Theme {
  final BuildContext context;
  ListSelectionColor({Key? key, required this.context})
      : super(
            key: key,
            data: ThemeData(),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.colorize,
                      size: 33,
                      color: Colors.black,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      '主题色设置',
                      style: TextStyle(
                          fontSize: 18, letterSpacing: 1, color: Colors.black),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<MainThemeData>(context, listen: false)
                          .changeThemeColor(0);
                    },
                    icon: const Icon(
                      Icons.circle,
                      color: Colors.red,
                    ),
                    constraints: const BoxConstraints(maxWidth: 36),
                    splashRadius: 0.1,
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<MainThemeData>(context, listen: false)
                          .changeThemeColor(1);
                    },
                    icon: const Icon(
                      Icons.circle,
                      color: Colors.blue,
                    ),
                    constraints: const BoxConstraints(maxWidth: 36),
                    splashRadius: 0.1,
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<MainThemeData>(context, listen: false)
                          .changeThemeColor(2);
                    },
                    icon: const Icon(
                      Icons.circle,
                      color: Colors.purple,
                    ),
                    constraints: const BoxConstraints(maxWidth: 36),
                    splashRadius: 0.1,
                  ),
                  IconButton(
                    onPressed: () {
                      Provider.of<MainThemeData>(context, listen: false)
                          .changeThemeColor(3);
                    },
                    icon: const Icon(
                      Icons.circle,
                      color: MainThemeData.pink,
                    ),
                    constraints: const BoxConstraints(maxWidth: 36),
                    splashRadius: 0.1,
                  ),
                ],
              ),
            ));
}
