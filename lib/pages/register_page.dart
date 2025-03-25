import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:qr_flutter/qr_flutter.dart';
import 'package:woniu_creative/api/api.dart';
import 'package:woniu_creative/global.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/utils/deivce_id.dart';
import 'package:woniu_creative/utils/logger_utils.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  State createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // 模拟设备信息
  String _machineCode = '生成中...';
  String _deviceModel = '获取中...';
  String _osVersion = '获取中...';
  String _networkStatus = '获取中...';
  Map<String, dynamic> _deviceInfo = {};

  // 注册状态管理
  bool _isRegistering = false;
  bool _registrationFailed = false;
  late Timer _retryTimer;

  bool autoRedirect = true;

  Future? initFuture;

  @override
  void initState() {
    super.initState();
    initFuture = init();
  }

  Future init() async {
    _machineCode = await getDeviceId();
    deviceId = _machineCode;
    var diplugin = DeviceInfoPlugin();
    if (kIsWeb) {
      var info = (await diplugin.webBrowserInfo);
      _deviceModel = info.browserName.name;
      _osVersion = info.appVersion ?? '';
      _deviceInfo = info.data;
    } else {
      if (Platform.isAndroid) {
        var info = await diplugin.androidInfo;
        _deviceModel = info.model;
        _deviceInfo = info.data;
      } else if (Platform.isWindows) {
        var info = await diplugin.windowsInfo;
        _deviceModel = info.productName;
        _osVersion = info.displayVersion;
        _deviceInfo = info.data;
      }
    }
    // 将deviceInfo中无法转换成json的处理一下
    _deviceInfo = jsonDecode(
      jsonEncode(
        _deviceInfo,
        toEncodable: (value) {
          if (value is DateTime) {
            return DateTimeConverter().toJson(value);
          } else {
            try {
              return (value as dynamic)?.toJson();
            } catch (e) {
              return value?.toString();
            }
          }
        },
      ),
    );
    _networkStatus = 'Wi-Fi 已连接';
    _startRegistration();
    setState(() {});
  }

  @override
  void dispose() {
    _retryTimer.cancel();
    super.dispose();
  }

  void _startRegistration() async {
    setState(() => _isRegistering = true);
    try {
      var regRes = await register(_machineCode, _deviceModel, _deviceInfo);
      if (regRes.data?.isRegistered == true) {
        //注册成功
        setState(() {
          _isRegistering = false;
          Navigator.of(context).popAndPushNamed('/display');
        });
      } else {
        //未注册
        await Future.delayed(Duration(seconds: 1));
        _startRegistration();
      }
    } catch (e) {
      error('注册时发生异常', e);
      // 出错
      setState(() {
        _isRegistering = false;
        _registrationFailed = true;
      });
    }
  }

  void _retryRegistration() {
    setState(() => _registrationFailed = false);
    _startRegistration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      SizedBox(height: 12),
                      SelectionArea(
                        child: Text(
                          _machineCode,
                          style: Theme.of(context).textTheme.headlineLarge,
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

              // 二维码区域
              QrImageView(
                data: 'wnc:register:$_machineCode',
                version: QrVersions.auto,
                size: 280,
                backgroundColor: Colors.white,
                dataModuleStyle: QrDataModuleStyle(
                  color: Colors.black,
                  dataModuleShape: QrDataModuleShape.square,
                ),
                eyeStyle: QrEyeStyle(
                  color: Colors.black,
                  eyeShape: QrEyeShape.square,
                ),
              ),
              SizedBox(height: 24),

              // 状态提示区域
              _buildStatusSection(),
            ],
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
          CircularProgressIndicator(strokeWidth: 2),
          SizedBox(height: 16),
          Text('正在等待注册，请使用商家端扫码注册...'),
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

    return Center(child: Text('已注册'));
  }
}
