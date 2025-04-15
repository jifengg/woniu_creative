import 'package:flutter/material.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/widgets/state_extension.dart';

import 'select_device_page.dart';

/// 频道关联设备页面
class ChannelDevicesPage extends StatefulWidget {
  final int channelId;

  const ChannelDevicesPage({super.key, required this.channelId});

  @override
  State<ChannelDevicesPage> createState() => _ChannelDevicesPageState();
}

class _ChannelDevicesPageState extends State<ChannelDevicesPage> {
  List<Device> _devices = [];
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
      _devices = [
        Device(id: 1, deviceName: '设备1', deviceId: 'DEV001'),
        Device(id: 2, deviceName: '设备2', deviceId: 'DEV002'),
      ];
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _removeDevice(Device device) {
    setState(() => _devices.remove(device));
  }

  void _addDevices() async {
    final selected = await Navigator.push<List<Device>>(
      context,
      MaterialPageRoute(
        builder: (context) => SelectDevicesPage(selectedDeviceIds: _devices),
      ),
    );

    if (selected != null) {
      setState(() => _devices = selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('关联设备列表')),
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
          label: Text('新增关联设备'),
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
            label: Text('操作'),
            headingRowAlignment: MainAxisAlignment.center,
          ),
        ],
        rows:
            _devices
                .map(
                  (device) => DataRow(
                    cells: [
                      DataCell(Text(device.id.toString())),
                      DataCell(Text(device.deviceName!)),
                      DataCell(_buildOperButtons(device)),
                    ],
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: _devices.length,
      itemBuilder: (context, index) {
        final device = _devices[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            title: Text(device.deviceName!),
            subtitle: Text('Code: ${device.deviceId}'),
            trailing: _buildOperButtons(device),
          ),
        );
      },
    );
  }

  Widget _buildOperButtons(Device device) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _removeDevice(device),
        ),
      ],
    );
  }
}
