import 'package:flutter/material.dart';

class AdminRegisterPage extends StatefulWidget {
  const AdminRegisterPage({super.key});

  @override
  State<AdminRegisterPage> createState() => _AdminRegisterPageState();
}

class _AdminRegisterPageState extends State<AdminRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool get isPC => MediaQuery.of(context).size.width > 600;

  void _register() {
    if (_formKey.currentState!.validate()) {
      // 模拟注册成功
      Navigator.pop(context, {'username': _usernameController.text});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('注册')),
      body:
          isPC
              ? Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 500),
                  child: _buildForm(context),
                ),
              )
              : SingleChildScrollView(child: _buildForm(context)),
    );
  }

  Widget _buildForm(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: '新账号'),
              validator: (value) => value!.isEmpty ? '请输入账号' : null,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: '密码'),
              obscureText: true,
              validator: (value) => value!.isEmpty ? '请输入密码' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: '确认密码'),
              obscureText: true,
              validator: (value) {
                if (value != _passwordController.text) {
                  return '密码不一致';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _register, child: Text('注册')),
          ],
        ),
      ),
    );
  }
}
