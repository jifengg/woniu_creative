import 'package:flutter/material.dart';
import 'package:woniu_creative/models/play_item.dart';
import 'package:woniu_creative/models/play_list.dart';
import 'package:woniu_creative/widgets/material_widget.dart';

class PlayListPage extends StatefulWidget {
  const PlayListPage({super.key, required this.playList});
  final PlayList playList;
  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  PlayList get playList => widget.playList;
  PlayItem get currentItem => playList.items[currentIndex];
  int currentIndex = 0;

  nextItem() {
    currentIndex = (currentIndex + 1) % playList.items.length;
    play();
  }

  play([bool first = false]) {
    var duration =
        currentItem.material.duration ??
        currentItem.duration ??
        playList.defaultDelay;
    Future.delayed(Duration(milliseconds: duration), () {
      if (mounted) {
        nextItem();
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    play(true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialWidget(
      key: ValueKey(currentItem.material.id),
      material: currentItem.material,
    );
  }
}
