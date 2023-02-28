import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);
  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("关于"),
        primary: true,
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: [
          Column(
            children: const [
              Text("软件版本1.0.0beta"),
              Text("Designed by JSYRD"),
              Text("Backend designed by 7rain Fun"),
              Text("JSYRD All right reserved.")
            ],
          )
        ],
      ),
    );
  }
}
