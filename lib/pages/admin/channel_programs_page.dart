import 'package:flutter/material.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/pages/admin/program_edit_page.dart';
import 'package:woniu_creative/widgets/state_extension.dart';

/// 频道关联节目页面
class ChannelProgramsPage extends StatefulWidget {
  final int channelId;

  const ChannelProgramsPage({super.key, required this.channelId});

  @override
  State<ChannelProgramsPage> createState() => _ChannelProgramsPageState();
}

class _ChannelProgramsPageState extends State<ChannelProgramsPage> {
  List<Program> _programs = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDevices();
  }

  Future<void> _loadDevices() async {
    setState(() => _isLoading = true);
    try {
      // 模拟API请求
      // await Future.delayed(Duration(seconds: 1));
      _programs = [
        Program(id: 11, programName: '节目1'),
        Program(
          id: 12,
          programName: '节目2',
          priority: 999,
          timeConfig: CustomTimeConfig(
            periods: [],
            start: DateTime(2000, 1, 1),
            end: DateTime(2999),
          ),
        ),
        Program(
          id: 12,
          programName: '节目3',
          priority: 123,
          timeConfig: WeeklyTimeConfig(
            periods: [],
            start: DateTime(2020, 1, 1),
            end: DateTime(2134),
            daysOfWeek: [3, 6],
          ),
        ),
      ];
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _removeProgram(Program program) {
    setState(() => _programs.remove(program));
  }

  void _addDevices() async {
    _navigateToEdit();
  }

  _navigateToEdit([Program? program]) async {
    final newP = await Navigator.push<Program>(
      context,
      MaterialPageRoute(
        builder: (context) => ProgramEditPage(program: program),
      ),
    );

    if (newP != null) {
      if (program == null) {
        _programs.add(newP);
      } else {
        var index = _programs.indexOf(program);
        if (index > -1) {
          _programs.replaceRange(index, index, [newP]);
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('节目列表')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPC) Padding(padding: EdgeInsets.all(18), child: _buildHeader()),
          Expanded(
            child:
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : isPC
                    ? _buildTable()
                    : _buildList(),
          ),
        ],
      ),
      floatingActionButton:
          isPC
              ? null
              : FloatingActionButton(
                onPressed: _addDevices,
                child: Icon(Icons.add),
              ),
    );
  }

  Widget _buildHeader() {
    return Wrap(
      children: [
        ElevatedButton.icon(
          onPressed: _addDevices,
          icon: Icon(Icons.add),
          label: Text('新增节目'),
        ),
      ],
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('ID'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(label: Text('名称'), columnWidth: FlexColumnWidth()),
          DataColumn(
            label: Text('优先级'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(
            label: Text('时间配置'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
          DataColumn(
            label: Text('操作'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
        ],
        rows:
            _programs
                .map(
                  (program) => DataRow(
                    cells: [
                      DataCell(Text(program.id.toString())),
                      DataCell(Text(program.programName)),
                      DataCell(Text(program.priority.toString())),
                      DataCell(
                        Text(
                          program.timeConfig == null
                              ? '-'
                              : program.timeConfig!.toString(),
                        ),
                      ),
                      DataCell(_buildOperButtons(program)),
                    ],
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: _programs.length,
      itemBuilder: (context, index) {
        final device = _programs[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(device.programName),
            subtitle: Text(
              'ID：${device.id}    优先级：${device.priority}\n时间：${device.timeConfig == null ? '-' : device.timeConfig!.toString()}',
            ),
            trailing: _buildOperButtons(device),
          ),
        );
      },
    );
  }

  Widget _buildOperButtons(Program program) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit_outlined),
          tooltip: '编辑',
          onPressed: () => _navigateToEdit(program),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeProgram(program),
        ),
      ],
    );
  }
}
