// 新增DashboardPage实现
import 'package:flutter/material.dart';
import 'package:woniu_creative/widgets/pc_small_container.dart';
import 'package:woniu_creative/widgets/state_extension.dart';

// 新增DeviceRegisterPage实现
class DeviceRegisterPage extends StatefulWidget {
  const DeviceRegisterPage({super.key});

  @override
  State<DeviceRegisterPage> createState() => _DeviceRegisterPageState();
}

class _DeviceRegisterPageState extends State<DeviceRegisterPage>
    with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  bool _isLoading = false;
  String? _scanResult;

  Future<void> _scanQRCode() async {
    // 模拟扫码结果
    setState(() {
      _scanResult = 'REGISTER-CODE-123456';
      _codeController.text = _scanResult!;
    });
  }

  Future<void> _registerDevice() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // 模拟API调用
        await Future.delayed(Duration(seconds: 2));
        if (_codeController.text == 'REGISTER-CODE-123456') {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('设备注册成功')));
          Navigator.pop(context);
        } else {
          throw Exception('无效的注册码');
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('注册失败: ${e.toString()}')));
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: isPC ? null : AppBar(title: Text('设备注册')),
      body: Center(child: PcSmallContainer(child: _buildForm())),
    );
  }

  Padding _buildForm() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: '设备注册码',
                suffixIcon: IconButton(
                  icon: Icon(Icons.qr_code_scanner),
                  onPressed: _scanQRCode,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return '请输入或扫描设备注册码';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _registerDevice,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('注册设备'),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
