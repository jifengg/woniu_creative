import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/pages/admin/admin_register_page.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _agreed = false;
  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _agreed = _prefs?.getBool('agreed') ?? false;
    });
  }

  bool get isPC => MediaQuery.of(context).size.width > 600;

  void _login() {
    if (_formKey.currentState!.validate() && _agreed) {
      _prefs?.setBool('agreed', true);
      // // 模拟登录成功
      // ScaffoldMessenger.of(
      //   context,
      // ).showSnackBar(SnackBar(content: Text('登录成功')));
      Navigator.of(context).popAndPushNamed('/admin');
    }
  }

  void _navigateToRegister() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AdminRegisterPage()),
    );

    if (result != null && result['username'] != null) {
      _usernameController.text = result['username'];
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('管理员登录')),
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
            if (!isPC) SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text('蜗牛创意 - 管理端', style: TextStyle(fontSize: 24)),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: '账号'),
              validator: (value) => value!.isEmpty ? '请输入账号' : null,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: '密码'),
              obscureText: true,
              validator: (value) => value!.isEmpty ? '请输入密码' : null,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _agreed,
                  onChanged: (value) => setState(() => _agreed = value!),
                ),
                GestureDetector(
                  onTap: () => _showAgreementDialog(),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: '同意'),
                        TextSpan(
                          text: '用户协议',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: _login,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Text('登录'),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextButton(onPressed: _navigateToRegister, child: Text('注册新账号')),
            TextButton(onPressed: () {}, child: Text('忘记密码？')),
          ],
        ),
      ),
    );
  }

  void _showAgreementDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('用户协议'),
            content: Text('这里是用户协议内容...'),
            actions: [
              TextButton(
                onPressed: Navigator.of(context).pop,
                child: Text('关闭'),
              ),
            ],
          ),
    );
  }
}
