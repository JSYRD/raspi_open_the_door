import 'package:flutter/material.dart';

class ListSelection extends Theme {
  ListSelection(
      {Key? key,
      required String title,
      required IconData icon,
      required void Function() function})
      : super(
            key: key,
            data: ThemeData(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: TextButton(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        icon,
                        size: 33,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18,
                            letterSpacing: 1,
                            color: Colors.black),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
                  ],
                ),
                onPressed: function,
              ),
            ));
}
