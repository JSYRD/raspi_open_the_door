import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/utils/utils.dart';

class AddGuestPage extends StatefulWidget {
  const AddGuestPage({Key? key}) : super(key: key);
  @override
  State<AddGuestPage> createState() => _AddGuestPageState();
}

class _AddGuestPageState extends State<AddGuestPage> {
  final TextEditingController _getGuestName = TextEditingController();
  final TextEditingController _getGuestPassword = TextEditingController();
  String _value = "super";
  bool _passwordVisiable = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("添加访客"),
      scrollable: true,
      content: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _getGuestName,
                maxLines: 1,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: '用户名',
                    hintText: '用户名',
                    icon: Icon(Icons.person)),
              )),
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: _getGuestPassword,
                maxLines: 1,
                obscureText: _passwordVisiable,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        borderSide: BorderSide(color: Colors.blue)),
                    labelText: '密码',
                    hintText: '密码',
                    suffixIcon: IconButton(
                        icon: Icon(_passwordVisiable
                            ? (Icons.visibility)
                            : (Icons.visibility_off)),
                        onPressed: () {
                          setState(() {
                            _passwordVisiable = !_passwordVisiable;
                          });
                        }),
                    icon: const Icon(Icons.lock)),
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: DropdownButtonFormField(
                value: _value,
                items: const [
                  DropdownMenuItem(
                    child: Text("Super"),
                    value: "super",
                  ),
                  DropdownMenuItem(
                    child: Text("Admin"),
                    value: "admin",
                  ),
                  DropdownMenuItem(
                    child: Text("User"),
                    value: "user",
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    _value = value ?? "unknown";
                  });
                }),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              User guest = User(
                  name: _getGuestName.text,
                  password: _getGuestPassword.text,
                  userType: _value);
              Navigator.pop(context, guest);
            },
            child: const Text("确定"))
      ],
    );
  }
}
