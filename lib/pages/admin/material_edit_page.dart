import 'package:flutter/material.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/widgets/radio_group_widget.dart';
import 'package:woniu_creative/widgets/simple_table_view.dart';
import 'package:woniu_creative/widgets/upload_widget.dart';

class MaterialEditPage extends StatefulWidget {
  const MaterialEditPage({super.key, this.materialInfo});

  final MaterialInfo? materialInfo;

  @override
  State<MaterialEditPage> createState() => _MaterialEditPageState();
}

class _MaterialEditPageState extends State<MaterialEditPage> {
  MaterialInfo? get materialInfo => widget.materialInfo;

  final typeRadios =
      MaterialTypes.values.map((t) => RadioGroupItem(t, t.getName())).toList();

  MaterialTypes selectedType = MaterialTypes.image;

  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (materialInfo != null) {
      var mi = materialInfo!;
      nameController.text = mi.name ?? '';
      selectedType = mi.type;
      if (selectedType == MaterialTypes.text) {
        contentController.text = mi.content ?? '';
      } else if (selectedType == MaterialTypes.link) {
        urlController.text = mi.url ?? '';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(materialInfo == null ? '新增素材' : '修改素材')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: SimpleTableView(
        labelTableColumnWidth: MaxColumnWidth(
          FixedColumnWidth(90),
          IntrinsicColumnWidth(),
        ),
        data: [
          SimpleTableRowData('类型', _buildTypeField()),
          SimpleTableRowData('名称', _buildNameField()),
          if (selectedType == MaterialTypes.text)
            SimpleTableRowData('内容', _buildTextField()),
          if (selectedType == MaterialTypes.link)
            SimpleTableRowData('链接', _buildUrlField()),
          if (selectedType.isFileType)
            SimpleTableRowData(
              '上传${selectedType.getName()}',
              _buildUploadField(),
            ),
        ],
      ),
    );
  }

  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextFormField(
        decoration: InputDecoration(
          //helperText: '若留空，上传的文件名将做为默认名称'
          hintText: '填写名称可以方便在列表中选择',
        ),
      ),
    );
  }

  Widget _buildTypeField() {
    return RadioGroupWidget(
      items: typeRadios,
      selectedValue: selectedType,
      onChanged: (v) {
        setState(() {
          selectedType = v;
        });
      },
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        minLines: 5,
        maxLines: 5,
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
    );
  }

  Widget _buildUploadField() {
    return Row(
      children: [
        UploadWidget(
          previewUrl:
              'https://img1.baidu.com/it/u=2786614520,3496145671&fm=253',
        ),
      ],
    );
  }

  Widget _buildUrlField() {
    return TextFormField(decoration: InputDecoration(hintText: 'https://'));
  }
}
