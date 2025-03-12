import 'package:flutter/material.dart';
import 'package:woniu_creative/global.dart';
import 'package:woniu_creative/utils/deivce_id.dart';

/// 客户端设置页面
class ClientSettingPage extends StatefulWidget {
  const ClientSettingPage({super.key});

  @override
  State<ClientSettingPage> createState() => _ClientSettingPageState();
}

class _ClientSettingPageState extends State<ClientSettingPage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    deviceId = await getDeviceId();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('设置'), centerTitle: true),
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Text('设备注册码'),
                  title: Text(deviceId ?? '', textAlign: TextAlign.end),
                ),
                ListTile(
                  leading: Text('注册状态'),
                  title: Text('已注册', textAlign: TextAlign.end),
                  subtitle: Text('点击进入注册页面', textAlign: TextAlign.end),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                ),
                ListTile(
                  leading: Text('设备注册商'),
                  title: Text('jifengge', textAlign: TextAlign.end),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: Text('节目管理'),
                  title: Text('在线节目', textAlign: TextAlign.end),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
                ListTile(
                  leading: Text('本地缓存'),
                  title: Text('34.56M', textAlign: TextAlign.end),
                  subtitle: Text('点击清理缓存', textAlign: TextAlign.end),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {},
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Center(child: getUnregisterButton()),
        ],
      ),
    );
  }

  ElevatedButton getUnregisterButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.red)),
      child: Text('注销已注册的信息', style: TextStyle(color: Colors.white)),
    );
  }
}
