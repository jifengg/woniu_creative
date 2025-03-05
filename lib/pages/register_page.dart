import 'package:flutter/material.dart';
import 'dart:async';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  State createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // 模拟设备信息
  final String _machineCode = 'SN20231001001';
  final String _deviceModel = 'SM-G975F';
  final String _osVersion = 'Android 13';
  final String _networkStatus = 'Wi-Fi 已连接';

  // 注册状态管理
  bool _isRegistering = false;
  bool _registrationFailed = false;
  late Timer _retryTimer;

  @override
  void initState() {
    super.initState();
    _startRegistration();
  }

  @override
  void dispose() {
    _retryTimer.cancel();
    super.dispose();
  }

  void _startRegistration() async {
    setState(() => _isRegistering = true);

    // 模拟网络请求
    await Future.delayed(Duration(seconds: 3));

    // 模拟20%失败概率
    if (DateTime.now().millisecond % 5 == 0) {
      setState(() {
        _isRegistering = false;
        _registrationFailed = true;
      });
      _startRetryTimer();
    } else {
      // 跳转到主页面
      // Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  void _startRetryTimer() {
    _retryTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _startRegistration();
    });
  }

  void _retryRegistration() {
    setState(() => _registrationFailed = false);
    _startRegistration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFf5f7fa), Color(0xFFc3cfe2)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 机器码卡片
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Text(
                          '设备注册码',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(
                          _machineCode,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 32),

                // 设备信息卡片
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        _buildInfoRow('设备型号', _deviceModel),
                        Divider(),
                        _buildInfoRow('系统版本', _osVersion),
                        Divider(),
                        _buildInfoRow('网络状态', _networkStatus),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 32),

                // // 二维码区域
                // QrImage(
                //   data: 'https://api.example.com/register?code=$_machineCode',
                //   version: QrVersions.auto,
                //   size: 180,
                //   gapless: false,
                //   embeddedImage: AssetImage('assets/icon.png'),
                //   embeddedImageStyle: QrEmbeddedImageStyle(
                //     size: Size(40, 40)
                //   ),
                // ),
                SizedBox(height: 24),

                // 状态提示区域
                _buildStatusSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildStatusSection() {
    if (_isRegistering) {
      return Column(
        children: [
          CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          SizedBox(height: 16),
          Text(
            '正在等待注册...',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      );
    }

    if (_registrationFailed) {
      return Column(
        children: [
          Icon(Icons.error_outline, color: Colors.red, size: 48),
          SizedBox(height: 16),
          Text('注册失败，请检查网络', style: TextStyle(fontSize: 16, color: Colors.red)),
          SizedBox(height: 16),
          ElevatedButton(onPressed: _retryRegistration, child: Text('重试')),
        ],
      );
    }

    return SizedBox();
  }
}
