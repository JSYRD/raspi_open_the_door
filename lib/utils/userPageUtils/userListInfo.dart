import 'package:flutter/material.dart';

class UserListInfo extends Padding {
  UserListInfo(
      {Key? key,
      required String name,
      required int id,
      required String userType,
      required void Function(dynamic) pressed})
      : super(
          key: key,
          padding: const EdgeInsets.only(bottom: 10),
          child: OutlinedButton(
            onPressed: () {
              pressed(id);
            },
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    name,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text(
                        "用户编号: $id",
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 15),
                        textAlign: TextAlign.left,
                      ),
                      Expanded(
                        child: Text(
                          "用户类型: $userType",
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
}
