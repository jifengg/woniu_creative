import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// 一个显示本地当前时间的控件，实时更新（与帧率相同）
class CurrentTimeWidget extends StatefulWidget {
  const CurrentTimeWidget({super.key, this.style});
  final TextStyle? style;
  @override
  State<CurrentTimeWidget> createState() => _CurrentTimeWidgetState();
}

class _CurrentTimeWidgetState extends State<CurrentTimeWidget> {
  late Ticker _ticker;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _ticker = Ticker((elapsed) {
      _updateTime();
    });
    _ticker.start();
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateTime.now().toString().split('.')[0]; // 格式化时间
    });
  }

  @override
  void dispose() {
    _ticker.dispose(); // 清理 Ticker
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentTime,
      style: widget.style ?? Theme.of(context).textTheme.headlineLarge,
    );
  }
}
