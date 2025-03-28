import 'package:flutter/material.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/widgets/state_extension.dart';

/// 选择设备页面
class SelectDevicesPage extends StatefulWidget {
  const SelectDevicesPage({super.key, required this.selectedDeviceIds});

  final List<Device> selectedDeviceIds;

  @override
  State<SelectDevicesPage> createState() => _SelectDevicesPageState();
}

class _SelectDevicesPageState extends State<SelectDevicesPage> {
  List<Device> _allDevices = [];
  final List<Device> _selectedDevices = [];
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
      await Future.delayed(Duration(seconds: 1));
      _allDevices = [
        Device(id: 1, deviceName: '设备1', deviceId: 'DEV001'),
        Device(id: 2, deviceName: '设备2', deviceId: 'DEV002'),
        Device(id: 3, deviceName: '设备3', deviceId: 'DEV003'),
      ];
      _selectedDevices.addAll(
        _allDevices.where(
          (d) => widget.selectedDeviceIds.any((i) => i.id == d.id),
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _toggleDevice(Device device) {
    setState(() {
      if (_selectedDevices.contains(device)) {
        _selectedDevices.remove(device);
      } else {
        _selectedDevices.add(device);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择设备'),
        actions: [
          TextButton(
            onPressed:
                _selectedDevices.isNotEmpty
                    ? () => Navigator.pop(context, _selectedDevices)
                    : null,
            child: Text('确认'),
          ),
        ],
      ),
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : isPC
              ? _buildTable()
              : _buildList(),
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      child: DataTable(
        columns: [
          DataColumn(label: Text('选择')),
          DataColumn(label: Text('设备ID')),
          DataColumn(label: Text('设备名称'), columnWidth: FlexColumnWidth()),
        ],
        rows:
            _allDevices
                .map(
                  (device) => DataRow(
                    cells: [
                      DataCell(
                        Checkbox(
                          value: _selectedDevices.contains(device),
                          onChanged: (value) => _toggleDevice(device),
                        ),
                      ),
                      DataCell(Text(device.id.toString())),
                      DataCell(Text(device.deviceName!)),
                    ],
                  ),
                )
                .toList(),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: _allDevices.length,
      itemBuilder: (context, index) {
        final device = _allDevices[index];
        return CheckboxListTile(
          title: Text(device.deviceName!),
          subtitle: Text('Code: ${device.deviceId}'),
          value: _selectedDevices.contains(device),
          onChanged: (value) => _toggleDevice(device),
        );
      },
    );
  }
}
