import 'package:flutter/material.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/pages/play_list_page.dart';
import 'package:woniu_creative/widgets/current_time_widget.dart';

class ProgramLayoutPreviewWidget extends StatefulWidget {
  const ProgramLayoutPreviewWidget({
    super.key,
    required this.program,
    this.editMode = true,
  });

  final Program program;

  final bool editMode;

  @override
  State<ProgramLayoutPreviewWidget> createState() =>
      _ProgramLayoutPreviewWidgetState();
}

class _ProgramLayoutPreviewWidgetState
    extends State<ProgramLayoutPreviewWidget> {
  Program get program => widget.program;
  BoxConstraints constraints = BoxConstraints();
  @override
  Widget build(BuildContext context) {
    return (program.layers == null || program.layers!.isEmpty)
        ? getEmptyProgram()
        : LayoutBuilder(
          builder: (context, constraints) {
            this.constraints = constraints;
            return Stack(
              children: program.layers!.map((i) => buildLayer(i)).toList(),
            );
          },
        );
  }

  double width(double r) {
    return r * constraints.maxWidth;
  }

  double height(double r) {
    return r * constraints.maxHeight;
  }

  Widget getEmptyProgram() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "暂无节目",
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontSize: width(1 / 10)),
          ),
          SizedBox(height: 10),
          CurrentTimeWidget(
            style: Theme.of(
              context,
            ).textTheme.headlineLarge?.copyWith(fontSize: width(1 / 23)),
          ),
        ],
      ),
    );
  }

  Widget buildLayer(Layer layer) {
    var list = layer.layoutConfigs;
    return Stack(
      key: layer.id == null ? null : ValueKey(layer.id),
      children:
          list.map((item) {
            var p = item.position;
            var l = item.playList;
            var bgc =
                item.backgroundColor == null
                    ? (widget.editMode
                        ? Theme.of(context).colorScheme.outline
                        : null)
                    : Color(item.backgroundColor!);
            return Positioned(
              left: width(p.x),
              top: height(p.y),
              width: width(p.w),
              height: height(p.h),
              child: Container(
                decoration: BoxDecoration(
                  color: widget.editMode ? null : bgc,
                  border:
                      widget.editMode
                          ? Border.all(color: bgc!, width: 3)
                          : null,
                ),
                child: l == null ? null : PlayListPage(playList: l),
              ),
            );
          }).toList(),
    );
  }
}
