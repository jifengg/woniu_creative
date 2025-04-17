import 'package:flutter/material.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/widgets/radio_group_widget.dart';
import 'package:woniu_creative/widgets/simple_table_view.dart';

class PlaylistEditPage extends StatefulWidget {
  const PlaylistEditPage({super.key, this.playList});

  final PlayList? playList;

  @override
  State<PlaylistEditPage> createState() => _PlaylistEditPageState();
}

class _PlaylistEditPageState extends State<PlaylistEditPage> {
  PlayList? get playList => widget.playList;

  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final delayController = TextEditingController();
  PlayMode playMode = PlayMode.order;

  List<PlayItem> items = [];

  @override
  void initState() {
    super.initState();
    if (playList != null) {
      nameController.text = playList!.name;
      delayController.text = playList!.defaultDelay.toString();
      playMode = playList!.playMode;
      loadPlayListItems(playList!);
    }
  }

  loadPlayListItems(PlayList playList) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(playList == null ? '新建播放列表' : '编辑播放列表')),
      body: Form(key: _formKey, child: _buildBody()),
    );
  }

  final _playModeRadio =
      PlayMode.values.map((v) => RadioGroupItem(v, v.getName())).toList();

  Widget _buildBody() {
    return Column(
      children: [
        _buildBaseInfo(),
        Expanded(child: _buildMaterialList()),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildBaseInfo() {
    return SimpleTableView(
      data: [
        if (playList != null)
          SimpleTableRowData('ID', Text(playList!.id.toString())),
        SimpleTableRowData(
          '名称',
          TextFormField(
            controller: nameController,
            onSaved: (value) {},
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入名称';
              }
              return null;
            },
          ),
        ),
        SimpleTableRowData(
          '播放模式',
          RadioGroupWidget(
            items: _playModeRadio,
            selectedValue: playMode,
            onChanged: (value) {
              setState(() {
                playMode = value;
              });
            },
          ),
        ),
        SimpleTableRowData(
          '默认播放时长',
          TextFormField(
            controller: delayController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '请输入默认播放时长';
              }
              var v = int.tryParse(value);
              if (v == null || v < 0) {
                return '请输入正确的非负整数';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMaterialList() {
    return SingleChildScrollView(child: Container());
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        onPressed: save,
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Text('保存'),
        ),
        icon: Icon(Icons.save),
      ),
    );
  }

  save() async {
    var form = _formKey.currentState!;
    if (form.validate()) {
      // 全部验证通过
      var newPlaylist = PlayList(
        id: playList?.id,
        ownerId: playList?.ownerId,
        name: nameController.text,
        playMode: playMode,
        defaultDelay: int.parse(delayController.text),
        items: items,
      );
      Navigator.of(context).pop(newPlaylist);
    }
  }
}
