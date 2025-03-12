import 'package:flutter/material.dart';

/// 端口选择页面。
class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.headlineLarge!,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('选择要使用的功能'),
              SizedBox(height: 40),
              Wrap(
                children: [
                  getCard('广告展示', () {
                    //
                    Navigator.of(context).pushNamed('/display');
                  }),
                  getCard('广告管理', () {
                    //
                    Navigator.of(context).pushNamed('/admin');
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding getCard(String text, Function()? onTap) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          child: Padding(
            padding: const EdgeInsets.all(80.0),
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
