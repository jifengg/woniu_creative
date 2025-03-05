import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:woniu_creative/models/channel.dart';
import 'package:woniu_creative/models/enums.dart';
import 'package:woniu_creative/models/layer.dart';
import 'package:woniu_creative/models/layout_config.dart';
import 'package:woniu_creative/models/material_info.dart';
import 'package:woniu_creative/models/period.dart';
import 'package:woniu_creative/models/play_item.dart';
import 'package:woniu_creative/models/play_list.dart';
import 'package:woniu_creative/models/position.dart';
import 'package:woniu_creative/models/program.dart';
import 'package:woniu_creative/models/time_config.dart';
import 'package:woniu_creative/pages/play_list_page.dart';
import 'package:woniu_creative/widgets/current_time_widget.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({super.key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  Channel channel = Channel(
    id: 1,
    channelName: "测试频道1",
    programs: [
      Program(
        id: 1,
        programName: "programName",
        priority: 999,
        timeConfig: TimeConfig(
          type: TimeConfigType.daily,
          start: DateTime(2000),
          end: DateTime(2099),
          periods: [Period(start: 0, end: 86400)],
        ),
        layers: [
          Layer(
            id: 1,
            layerName: "bg",
            layoutConfigs: [
              LayoutConfig(
                position: Position(x: 0, y: 0, w: 1, h: 1),
                playList: PlayList(
                  items: [
                    PlayItem(
                      material: MaterialInfo(
                        id: 3,
                        type: MaterialTypes.image,
                        url:
                            "https://img1.baidu.com/it/u=2786614520,3496145671&fm=253&fmt=auto&app=120&f=JPEG?w=1422&h=800",
                      ),
                    ),
                    PlayItem(
                      material: MaterialInfo(
                        id: 4,
                        type: MaterialTypes.image,
                        url:
                            "https://i0.hdslb.com/bfs/archive/63d70f20eb05f89deb14d2be0599e9625c131380.jpg",
                      ),
                      duration: 10000,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Layer(
            id: 2,
            layerName: "xx1",
            layoutConfigs: [
              LayoutConfig(
                position: Position(x: 0.02, y: 0.02, w: 0.32, h: 0.75),
                playList: PlayList(
                  items: [
                    PlayItem(
                      material: MaterialInfo(
                        id: 1,
                        type: MaterialTypes.link,
                        url:
                            "https://i.tianqi.com/?c=code&a=getcode&id=82&site=16&icon=3&py=wuxi1",
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.white.toARGB32(),
              ),
              LayoutConfig(
                position: Position(x: 0.35, y: 0.02, w: 0.32, h: 0.15),
                playList: PlayList(
                  items: [
                    PlayItem(
                      material: MaterialInfo(
                        id: 2,
                        type: MaterialTypes.text,
                        content: "标题1",
                      ),
                    ),
                    PlayItem(
                      material: MaterialInfo(
                        id: 2,
                        type: MaterialTypes.text,
                        content: "这是另一个标题",
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.lightBlueAccent.toARGB32(),
              ),
              LayoutConfig(
                position: Position(x: 0.35, y: 0.50, w: 0.35, h: 0.25),
                playList: PlayList(
                  items: [
                    PlayItem(
                      material: MaterialInfo(
                        id: 3,
                        type: MaterialTypes.video,
                        url:
                            "C:/Users/xuxiaodong/Pictures/ffmpeg/素材/big_buck_bunny_10s.avi",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      Program(
        id: 21,
        programName: "programName",
        priority: 1999,
        timeConfig: CustomTimeConfig(
          start: DateTime(2000),
          end: DateTime(2099),
          periods: [Period(start: 0, end: 86400)],
          dateRanges: [
            DateTimeRange(
              start: DateTime.parse("2025-03-05 16:25"),
              end: DateTime.parse("2025-03-05 16:25:20"),
            ),
          ],
        ),
        layers: [
          Layer(
            id: 201,
            layerName: "layerName",
            layoutConfigs: [
              LayoutConfig(
                position: Position(x: 0, y: 0, w: 1, h: 1),
                playList: PlayList(
                  items: [
                    PlayItem(
                      material: MaterialInfo(
                        id: 2,
                        type: MaterialTypes.image,
                        url:
                            "https://img0.baidu.com/it/u=3217812679,2585737758&fm=253&fmt=auto&app=138&f=JPEG?w=889&h=500",
                      ),
                    ),
                  ],
                ),
              ),
              LayoutConfig(
                position: Position(x: 0.1, y: 0.1, w: 0.5, h: 0.1),
                playList: PlayList(
                  items: [
                    PlayItem(
                      material: MaterialInfo(
                        id: 3,
                        type: MaterialTypes.text,
                        content: "现在是节目2",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  int currentIndex = 0;

  Program? get program =>
      currentIndex == -1 ? null : channel.programs[currentIndex];

  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // 确定当前时间应该播放的节目
      var now = DateTime.now();
      Program? topP;
      int index = -1;
      for (var i = 0; i < channel.programs.length; i++) {
        var program = channel.programs[i];
        if (program.timeConfig.isTimeMatch(now)) {
          if (topP == null || topP.priority < program.priority) {
            topP = program;
            index = i;
          }
        }
      }
      setState(() {
        if (topP != null) {
          currentIndex = index;
        } else {
          currentIndex = -1;
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var str = '''
[{
    "type": 1,
    "start": "2023-01-01T00:00:00Z",
    "end": "2023-12-31T23:59:59Z",
    "periods": [
      {
        "start": 32400,
        "end": 75600
      }
    ]
  },
  {
    "type": 2,
    "start": "2023-01-01T00:00:00Z",
    "end": "2023-12-31T23:59:59Z",
    "daysOfWeek": [1, 3, 5],
    "periods": [
      {
        "start": 28800,
        "end": 43200
      },
      {
        "start": 54000,
        "end": 64800
      }
    ]
  },
  {
    "type": 3,
    "start": "2023-01-01T00:00:00Z",
    "end": "2023-12-31T23:59:59Z",
    "daysOfMonth": [10, 15, 20],
    "periods": [
      {
        "start": 43200,
        "end": 50400
      }
    ]
  },
  {
    "type": 4,
    "start": "2023-01-01T00:00:00Z",
    "end": "2023-12-31T23:59:59Z",
    "monthDays": [
      {
        "month":2,"day":14
      }
    ],
    "periods": [
      {
        "start": 43200,
        "end": 50400
      }
    ]
  },
  {
    "type": 9,
    "start": "2023-01-01T00:00:00Z",
    "end": "2023-12-31T23:59:59Z",
    "date_ranges": [
      {
        "start": "2023-02-14T00:00:00Z",
        "end": "2023-02-14T23:59:59Z"
      },
      {
        "start": "2023-12-25T00:00:00Z",
        "end": "2023-12-26"
      }
    ],
    "periods": [
      {
        "start": 32400,
        "end": 36000
      }
    ]
  }
]
''';
    var list = jsonDecode(str) as List;
    var tlist = list.map((e) => TimeConfig.fromJson(e)).toList();
    var nstr = jsonEncode(tlist);
    return Scaffold(
      body:
          program == null
              ? getEmptyProgram()
              : Stack(
                children: program!.layers.map((i) => buildLayer(i)).toList(),
              ),
    );
  }

  double width(double r) {
    return r * MediaQuery.of(context).size.width;
  }

  double height(double r) {
    return r * MediaQuery.of(context).size.height;
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
      key: ValueKey(layer.id),
      children:
          list.map((item) {
            var p = item.position;
            var l = item.playList;
            var bgc =
                item.backgroundColor == null
                    ? null
                    : Color(item.backgroundColor!);
            return Positioned(
              left: width(p.x),
              top: height(p.y),
              width: width(p.w),
              height: height(p.h),
              child: Container(color: bgc, child: PlayListPage(playList: l)),
            );
          }).toList(),
    );
  }
}
