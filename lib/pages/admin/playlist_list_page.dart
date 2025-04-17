import 'package:flutter/material.dart';
import 'package:woniu_creative/api/mock.dart';
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/pages/admin/playlist_edit_page.dart';

class PlayListListPage extends StatefulWidget {
  const PlayListListPage({super.key, this.selectedPlaylist});

  final PlayList? selectedPlaylist;

  @override
  State<PlayListListPage> createState() => _PlayListListPageState();
}

class _PlayListListPageState extends State<PlayListListPage> {
  static List<PlayList>? list;

  late Future _future;
  List<PlayList> _list = [];

  @override
  void initState() {
    super.initState();
    _future = _fetchPlaylists();
  }

  Future _fetchPlaylists([bool force = false]) async {
    if (force && list != null) {
      _list = list!;
      return;
    }
    // await Future.delayed(Duration(milliseconds: 1000));
    _list = [...playLists];

    list = _list;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_buildHeader(), Expanded(child: _buildBody())],
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildList();
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [CircularProgressIndicator(), Text('加载中...')],
            ),
          );
        }
      },
    );
  }

  Widget _buildHeader() {
    return Wrap(
      children: [
        ElevatedButton.icon(
          onPressed: _addPlayList,
          icon: Icon(Icons.add),
          label: Text('新增'),
        ),
      ],
    );
  }

  Widget _buildList() {
    return _list.isEmpty
        ? Center(child: Text('暂无数据'))
        : SingleChildScrollView(
          child: DataTable(
            columns: [
              DataColumn(label: Text('ID'), numeric: true),
              DataColumn(
                label: Text('名称'),
                columnWidth: MaxColumnWidth(
                  FlexColumnWidth(),
                  IntrinsicColumnWidth(),
                ),
              ),
              DataColumn(label: Text('播放模式')),
              DataColumn(label: Text('默认时长(毫秒)')),
              DataColumn(label: Text('操作')),
            ],
            rows:
                _list
                    .map(
                      (playlist) => DataRow(
                        cells: [
                          DataCell(Text(playlist.id.toString())),
                          DataCell(
                            Text(
                              playlist.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          DataCell(Text(playlist.playMode.getName())),
                          DataCell(Text(playlist.defaultDelay.toString())),
                          DataCell(_buildOperButtons(playlist)),
                        ],
                      ),
                    )
                    .toList(),
          ),
        );
  }

  _addPlayList() => _navigateToEdit();

  _navigateToEdit([PlayList? playlist]) async {
    var newP = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlaylistEditPage(playList: playlist),
      ),
    );

    if (newP != null) {
      if (playlist == null) {
        // todo 调用新增接口
        _list.add(newP);
      } else {
        // todo 调用更新接口
        var index = _list.indexOf(playlist);
        if (index > -1) {
          _list.replaceRange(index, index + 1, [newP]);
        }
      }
      setState(() {});
    }
  }

  _deleteChannel(PlayList playlist) {
    setState(() {
      _list.remove(playlist);
    });
  }

  Widget _buildOperButtons(PlayList playlist) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(Icons.edit_outlined),
          tooltip: '编辑',
          onPressed: () => _navigateToEdit(playlist),
        ),
        IconButton(
          icon: Icon(
            Icons.delete_outlined,
            color: Theme.of(context).colorScheme.error,
          ),
          tooltip: '删除',
          onPressed: () => _deleteChannel(playlist),
        ),
      ],
    );
  }
}
