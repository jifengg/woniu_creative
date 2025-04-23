import 'package:flutter/material.dart';
import 'package:woniu_creative/api/mock.dart';
import 'package:woniu_creative/models/material_info.dart';
import 'package:woniu_creative/pages/admin/material_edit_page.dart';

class MaterialListPage extends StatefulWidget {
  const MaterialListPage({super.key});

  @override
  State<MaterialListPage> createState() => _MaterialListPageState();
}

class _MaterialListPageState extends State<MaterialListPage> {
  List<MaterialInfo> list = [
    ...materialsImage,
    ...materialsLink,
    ...materialsVideo,
  ];

  List<MaterialInfo> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('素材管理')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildHeader(), Expanded(child: _buildList())],
      ),
    );
  }

  Widget _buildHeader() {
    return Wrap(
      children: [
        ElevatedButton.icon(
          onPressed: _navigateToEdit,
          icon: Icon(Icons.add),
          label: Text('新增'),
        ),
      ],
    );
  }

  Widget _buildList() {
    return SingleChildScrollView(child: _buildTable());
  }

  Widget _buildTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('ID')),
        DataColumn(
          label: Text('名称'),
          columnWidth: MaxColumnWidth(
            FlexColumnWidth(),
            IntrinsicColumnWidth(),
          ),
        ),
        DataColumn(label: Text('类型')),
        DataColumn(label: Text('操作')),
      ],
      rows:
          list.map((m) {
            return DataRow(
              selected: checkIsSelected(m),
              onSelectChanged: (v) {
                if (v == true) {
                  selectedItems.add(m);
                } else {
                  selectedItems.remove(m);
                }
                setState(() {});
              },
              cells: [
                DataCell(Text(m.id.toString())),
                DataCell(Text(m.name ?? '')),
                DataCell(Text(m.type.getName())),
                DataCell(_buildActions(m)),
              ],
            );
          }).toList(),
    );
  }

  bool checkIsSelected(MaterialInfo m) {
    return selectedItems.contains(m);
  }

  _navigateToEdit([MaterialInfo? m]) async {
    var newP = await Navigator.of(context).push<MaterialInfo>(
      MaterialPageRoute(builder: (context) => MaterialEditPage()),
    );
    if (newP != null) {
      if (m == null) {
        setState(() {
          list.add(newP);
        });
      } else {
        setState(() {
          list[list.indexOf(m)] = newP;
        });
      }
    }
  }

  _deleteChannel(MaterialInfo m) {}

  Widget _buildActions(MaterialInfo m) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit_outlined),
          tooltip: '编辑',
          onPressed: () => _navigateToEdit(m),
        ),
        IconButton(
          icon: Icon(
            Icons.delete_outlined,
            color: Theme.of(context).colorScheme.error,
          ),
          tooltip: '删除',
          onPressed: () => _deleteChannel(m),
        ),
      ],
    );
  }
}
