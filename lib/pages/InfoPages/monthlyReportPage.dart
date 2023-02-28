import 'package:flutter/material.dart';
import 'package:raspiopenthedoor/utils/generalUtils/listInfo.dart';

class MonthlyReportPage extends StatefulWidget {
  const MonthlyReportPage({Key? key}) : super(key: key);
  @override
  State<MonthlyReportPage> createState() => _MonthlyReportPageState();
}

class _MonthlyReportPageState extends State<MonthlyReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("服务月报")),
      body: ListView(
        children: [
          ListInfo(title: "故障次数", data: "0"),
          ListInfo(title: "开锁次数", data: "114"),
          ListInfo(title: "用电量", data: "21%"),
        ],
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }
}
