import 'package:flutter/material.dart';

class ListDivider extends Divider {
  const ListDivider({Key? key})
      : super(
          key: key,
          indent: 5.0,
          endIndent: 5.0,
          thickness: 0.3,
          color: Colors.grey,
        );
}
