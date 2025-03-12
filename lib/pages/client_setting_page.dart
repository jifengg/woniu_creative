import 'package:flutter/material.dart';

/// 客户端设置页面
class ClientSettingPage extends StatefulWidget {
  const ClientSettingPage({super.key});

  @override
  State<ClientSettingPage> createState() => _ClientSettingPageState();
}

class _ClientSettingPageState extends State<ClientSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('设置'), centerTitle: true),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(mainAxisSize: MainAxisSize.min, children: [ListTile()]),
    );
  }
}
