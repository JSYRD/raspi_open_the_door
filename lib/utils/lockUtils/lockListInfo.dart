import 'package:flutter/material.dart';

class LockListInfo extends Padding {
  LockListInfo(
      {Key? key,
      required int id,
      required String description,
      required int userId,
      required String addr,
      required void Function(dynamic) pressed})
      : super(
            key: key,
            padding: const EdgeInsets.only(bottom: 20),
            child: OutlinedButton(
                onPressed: () {
                  pressed(id);
                },
                child: Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            description,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            "所有者：$userId",
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ],
                )));
}
