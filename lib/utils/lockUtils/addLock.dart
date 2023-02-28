import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/utils/utils.dart';

class AddLockPage extends StatefulWidget {
  const AddLockPage({Key? key}) : super(key: key);
  @override
  State<AddLockPage> createState() => _AddLockPageState();
}

class _AddLockPageState extends State<AddLockPage> {
  final TextEditingController _getLockAddr = TextEditingController();
  final TextEditingController _getLockDesc = TextEditingController();
  String _value = "-1";
  List<DropdownMenuItem<String>>? itemList = [];
  bool _passwordVisiable = false;

  void buildUserList() async {
    List<User> users = await UserUtils.getUserList();
    List<DropdownMenuItem<String>> _children = [];
    for (var element in users) {
      _children.add(DropdownMenuItem(
        child: Text("${element.name} id:${element.id}"),
        value: element.id.toString(),
      ));
    }
    setState(() {
      itemList = _children;
    });
  }

  @override
  void initState() {
    buildUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("新注册锁"),
      scrollable: true,
      content: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _getLockAddr,
                maxLines: 1,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: '锁序列号',
                    hintText: '例如：1145141919810',
                    icon: Icon(Icons.numbers)),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _getLockDesc,
                maxLines: 1,
                obscureText: _passwordVisiable,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: '描述',
                    hintText: '例如：卧室',
                    suffixIcon: IconButton(
                        icon: Icon(_passwordVisiable
                            ? (Icons.visibility)
                            : (Icons.visibility_off)),
                        onPressed: () {
                          setState(() {
                            _passwordVisiable = !_passwordVisiable;
                          });
                        }),
                    icon: const Icon(Icons.note_add)),
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: DropdownButtonFormField<String>(
                value: null,
                items: itemList,
                onChanged: (String? value) {
                  setState(() {
                    _value = value ?? "-1";
                  });
                }),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Lock lock = Lock(
                  addr: _getLockAddr.text,
                  description: _getLockDesc.text,
                  userId: int.parse(_value));
              Navigator.pop(context, lock);
            },
            child: const Text("确定"))
      ],
    );
  }
}
