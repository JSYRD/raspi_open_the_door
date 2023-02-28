import 'package:flutter/material.dart';

class ListInfo extends Padding {
  ListInfo({Key? key, required String title, required String data})
      : super(
            key: key,
            padding: const EdgeInsets.only(bottom: 20),
            child: OutlinedButton(
                onPressed: () {},
                child: Row(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            title,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Text(
                            data,
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
// class ListInfo extends Column {
//   ListInfo({Key? key, required String title, required String data})
//       : super(
//           key: key,
//           children: [
//             OutlinedButton(
//                 onPressed: () {},
//                 child: Row(
//                   children: [
//                     Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(top: 16),
//                           child: Text(
//                             title,
//                             style: TextStyle(color: Colors.black, fontSize: 20),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(bottom: 16),
//                           child: Text(
//                             data,
//                             style: TextStyle(color: Colors.grey, fontSize: 15),
//                             textAlign: TextAlign.left,
//                           ),
//                         ),
//                       ],
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                     ),
//                   ],
//                 ))
//           ],
//         );
// }
