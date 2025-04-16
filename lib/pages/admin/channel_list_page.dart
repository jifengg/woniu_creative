import 'package:flutter/material.dart';
import 'package:woniu_creative/api/mock.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/pages/admin/channel_programs_page.dart';
import 'package:woniu_creative/widgets/state_extension.dart';

import 'channel_devices_page.dart';
import 'channel_edit_page.dart';

class ChannelListPage extends StatefulWidget {
  const ChannelListPage({super.key});

  @override
  State<ChannelListPage> createState() => _ChannelListPageState();
}

class _ChannelListPageState extends State<ChannelListPage>
    with AutomaticKeepAliveClientMixin {
  List<Channel> _channels = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadChannels();
  }

  Future<void> _loadChannels() async {
    setState(() => _isLoading = true);
    try {
      // 模拟API请求
      // await Future.delayed(Duration(seconds: 1));
      _channels = [
        // Channel(id: 1, channelName: '新闻频道' * 7),
        // Channel(id: 2, channelName: '娱乐频道'),
        channel1,
        channel2,
      ];
      // for (var i = 0; i < 4; i++) {
      //   _channels += _channels;
      // }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToEdit([Channel? channel]) {
    Navigator.of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ChannelEditPage(channel: channel),
          ),
        )
        .then((_) => _loadChannels());
  }

  void _viewDevices(int channelId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChannelDevicesPage(channelId: channelId),
      ),
    );
  }

  void _viewPrograms(Channel channel) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ChannelProgramsPage(channel: channel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: isPC ? null : AppBar(title: Text('频道管理')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isPC)
            Padding(padding: const EdgeInsets.all(18.0), child: _buildHeader()),
          Expanded(
            child:
                _isLoading
                    ? Center(child: CircularProgressIndicator())
                    : isPC
                    ? _buildPCLayout()
                    : _buildMobileLayout(),
          ),
        ],
      ),
      floatingActionButton:
          !isPC
              ? FloatingActionButton(
                onPressed: () => _navigateToEdit(),
                child: Icon(Icons.add),
              )
              : null,
    );
  }

  Widget _buildHeader() {
    return Wrap(
      children: [
        ElevatedButton.icon(
          onPressed: () => _navigateToEdit(),
          icon: Icon(Icons.add),
          label: Text('新建频道'),
        ),
      ],
    );
  }

  Widget _buildPCLayout() {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(label: Text('ID'), numeric: true),
          DataColumn(
            label: Text('频道名称'),
            columnWidth: FlexColumnWidth(),
            onSort: (index, ascending) {},
          ),
          DataColumn(label: Text('操作')),
        ],
        rows:
            _channels
                .map(
                  (channel) => DataRow(
                    cells: [
                      DataCell(Text(channel.id.toString())),
                      DataCell(
                        Text(
                          channel.channelName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      DataCell(_buildOperButtons(channel)),
                    ],
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return ListView.builder(
      itemCount: _channels.length,
      itemBuilder: (context, index) {
        final channel = _channels[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(
              channel.channelName,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text('ID: ${channel.id}'),
            trailing: _buildOperButtons(channel),
          ),
        );
      },
    );
  }

  /// 操作按钮组
  Widget _buildOperButtons(Channel channel) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.devices),
          tooltip: '设备列表',
          onPressed: () => _viewDevices(channel.id!),
        ),
        IconButton(
          icon: Icon(Icons.play_circle_outline),
          tooltip: '节目管理',
          onPressed: () => _viewPrograms(channel),
        ),
        IconButton(
          icon: Icon(Icons.edit_outlined),
          tooltip: '编辑',
          onPressed: () => _navigateToEdit(channel),
        ),
        IconButton(
          icon: Icon(
            Icons.delete_outlined,
            color: Theme.of(context).colorScheme.error,
          ),
          tooltip: '删除',
          onPressed: () => _deleteChannel(channel.id!),
        ),
      ],
    );
  }

  void _deleteChannel(int channelId) async {
    setState(() => _channels.removeWhere((c) => c.id == channelId));
  }

  @override
  bool get wantKeepAlive => true;
}
