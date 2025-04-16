import 'dart:math';

import 'package:flutter/material.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/pages/admin/program_layout_preview_widget.dart';
import 'package:woniu_creative/widgets/simple_dialog.dart';
import 'package:woniu_creative/widgets/simple_table_view.dart';

class ProgramLayoutEditPage extends StatefulWidget {
  const ProgramLayoutEditPage({super.key, required this.program});

  final Program program;

  @override
  State<ProgramLayoutEditPage> createState() => _ProgramLayoutEditPageState();
}

class _ProgramLayoutEditPageState extends State<ProgramLayoutEditPage> {
  Program get program => widget.program;

  List<Layer> layers = [];

  final Map<Layer, bool> _layerVisible = {};

  @override
  void initState() {
    super.initState();
    layers = program.layers ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('布局管理 - ${program.programName} (${program.id ?? ''})'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Card(child: Text('顶部')),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildPreviewPad(),
                ),
              ),
              Expanded(
                flex: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildRightPad(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewPad() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('预览'),
        Expanded(
          child: Align(
            alignment: Alignment.topCenter,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                child: ProgramLayoutPreviewWidget(
                  program: Program(programName: '', layers: layers),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightPad() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildAddLayerButton(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: layers.reversed.map(_buildLayerCard).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLayerCard(Layer l) {
    var isExpanded = _layerVisible[l] ?? false;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    tooltip: '拖动改变顺序',
                    icon: Icon(Icons.format_line_spacing),
                  ),
                  Expanded(
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(l.layerName),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isExpanded = !isExpanded;
                                _layerVisible[l] = isExpanded;
                              });
                            },
                            icon: Icon(
                              isExpanded
                                  ? Icons.expand_less
                                  : Icons.expand_more,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var ok = await confirm(
                        '确定要删除该层【${l.layerName}】吗？',
                        context: context,
                      );
                      if (ok) {
                        setState(() {
                          layers.remove(l);
                        });
                      }
                    },
                    tooltip: '删除',
                    icon: Icon(
                      Icons.delete_outline,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
              if (isExpanded) ...[
                TextFormField(
                  controller: TextEditingController(text: l.layerName),
                ),
                SizedBox(height: 8),
                Row(children: [Text('显示区域'), _buildAddLayoutButton(l)]),
                ...l.layoutConfigs.map((lc) {
                  return _buildLayoutConfigCard(lc, l);
                }),
              ],
            ],
          ),
        ),
      ),
    );
  }

  IconButton _buildAddLayoutButton(Layer l) {
    return IconButton(
      onPressed: () {
        setState(() {
          l.layoutConfigs.add(
            LayoutConfig(
              position: Position(x: 0.25, y: 0.25, w: 0.5, h: 0.5),
              backgroundColor:
                  Colors.primaries[Random().nextInt(Colors.primaries.length)]
                      .toARGB32(),
            ),
          );
        });
      },
      icon: Icon(Icons.add),
    );
  }

  Widget _buildLayoutConfigCard(LayoutConfig lc, Layer l) {
    var position = lc.position;
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Stack(
          children: [
            SimpleTableView(
              data: [
                SimpleTableRowData(
                  'X：',
                  _buildSliderWidget(
                    value: position.x,
                    onChanged: (v) {
                      setState(() {
                        position.x = v;
                      });
                    },
                  ),
                ),
                SimpleTableRowData(
                  'Y：',
                  _buildSliderWidget(
                    value: position.y,
                    onChanged: (v) {
                      setState(() {
                        position.y = v;
                      });
                    },
                  ),
                ),
                SimpleTableRowData(
                  '宽：',
                  _buildSliderWidget(
                    value: position.w,
                    onChanged: (v) {
                      setState(() {
                        position.w = v;
                      });
                    },
                  ),
                ),
                SimpleTableRowData(
                  '高：',
                  _buildSliderWidget(
                    value: position.h,
                    onChanged: (v) {
                      setState(() {
                        position.h = v;
                      });
                    },
                  ),
                ),
                SimpleTableRowData('播放列表：', lc.playList?.id),
                SimpleTableRowData('背景色：', lc.backgroundColor),
              ],
            ),
            Positioned(
              // : 0,
              child: IconButton(
                onPressed: () async {
                  var ok = await confirm('确定要删除该“显示区域”吗？', context: context);
                  if (ok) {
                    setState(() {
                      l.layoutConfigs.remove(lc);
                    });
                  }
                },
                icon: Icon(
                  Icons.close_outlined,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliderWidget({
    required double value,
    required Function(double) onChanged,
  }) {
    var str = value.toStringAsFixed(2);
    return Row(
      children: [
        Expanded(
          child: Slider(divisions: 100, value: value, onChanged: onChanged),
        ),
        InkWell(
          child: Text(str),
          onTap: () async {
            var v = await prompt(
              context: context,
              title: '输入新的值',
              initValue: str,
            );
            if (v != null) {
              var d = double.tryParse(v);
              if (d != null && d >= 0 && d <= 1) {
                onChanged(d);
              }
            }
          },
        ),
      ],
    );
  }

  Widget _buildAddLayerButton() {
    return ElevatedButton.icon(
      onPressed: () {
        setState(() {
          layers.add(
            Layer(layerName: '新层${layers.length + 1}', layoutConfigs: []),
          );
        });
      },
      label: Padding(padding: const EdgeInsets.all(16.0), child: Text('添加层')),
      icon: Icon(Icons.add),
    );
  }
}
