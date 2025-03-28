import 'package:flutter/material.dart';
import 'package:woniu_creative/models/models.dart';

/// 频道编辑页面
class ChannelEditPage extends StatefulWidget {
  final Channel? channel;

  const ChannelEditPage({super.key, this.channel});

  @override
  State<ChannelEditPage> createState() => _ChannelEditPageState();
}

class _ChannelEditPageState extends State<ChannelEditPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.channel?.channelName ?? '',
    );
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      // 模拟保存操作
      final newChannel = Channel(
        id: widget.channel?.id ?? DateTime.now().microsecondsSinceEpoch,
        channelName: _nameController.text,
      );
      Navigator.pop(context, newChannel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.channel == null ? '新建频道' : '编辑频道')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: '频道名称'),
                validator: (value) => value!.isEmpty ? '请输入频道名称' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: _save, child: Text('保存')),
            ],
          ),
        ),
      ),
    );
  }
}
