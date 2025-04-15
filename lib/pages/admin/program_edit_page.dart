import 'package:flutter/material.dart' hide DateTimeRange;
import 'package:woniu_creative/models/models.dart';
import 'package:woniu_creative/widgets/checkbox_group_widget.dart';
import 'package:woniu_creative/widgets/radio_group_widget.dart';
import 'package:woniu_creative/widgets/simple_table_view.dart';

class ProgramEditPage extends StatefulWidget {
  const ProgramEditPage({super.key, this.program});

  final Program? program;
  @override
  State<ProgramEditPage> createState() => _ProgramEditPageState();
}

class _ProgramEditPageState extends State<ProgramEditPage> {
  Program? get program => widget.program;

  final _formKey = GlobalKey<FormState>();

  List<RadioGroupItem<TimeConfigType>> timeConfigTypeItems =
      TimeConfigType.values.map((v) {
        return RadioGroupItem(v, v.getName());
      }).toList();

  List<CheckboxGroupItem<int>> weeklyItems = [
    CheckboxGroupItem(0, '日'),
    CheckboxGroupItem(1, '一'),
    CheckboxGroupItem(2, '二'),
    CheckboxGroupItem(3, '三'),
    CheckboxGroupItem(4, '四'),
    CheckboxGroupItem(5, '五'),
    CheckboxGroupItem(6, '六'),
  ];

  List<CheckboxGroupItem<int>> monthlyItems = List.generate(
    31,
    (i) => CheckboxGroupItem(i + 1, '${i + 1}'),
  );

  TextEditingController programNameController = TextEditingController();
  TextEditingController priorityController = TextEditingController();

  DateTimeRange? _selectedDateRange;

  TimeConfigType _selectedTimeConfigType = TimeConfigType.daily;

  List<int> _selectedWeeklydays = [];
  List<int> _selectedMonthlydays = [];
  List<MonthDay> _selectedYearlydays = [
    MonthDay(month: 2, day: 28),
    MonthDay(month: 3, day: 15),
  ];
  List<DateTimeRange> _selectedCustomdays = [];

  @override
  void initState() {
    super.initState();
    if (program != null) {
      var p = program!;
      programNameController.text = p.programName;
      priorityController.text = p.priority.toString();
      if (p.timeConfig != null) {
        var tc = p.timeConfig!;
        _selectedTimeConfigType = tc.type;
        _selectedDateRange = DateTimeRange(start: tc.start, end: tc.end);
        if (tc is WeeklyTimeConfig) {
          _selectedWeeklydays = tc.daysOfWeek;
        } else if (tc is MonthlyTimeConfig) {
          _selectedMonthlydays = tc.daysOfMonth;
        } else if (tc is YearlyTimeConfig) {
          _selectedYearlydays = tc.monthDays;
        } else if (tc is CustomTimeConfig) {
          _selectedCustomdays = tc.dateRanges ?? [];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          program == null ? '新增节目' : '编辑节目',
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildBaseInfo(),
              _buildTimeConfig(),
              _buildSaveButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBaseInfo() {
    var p = program;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SimpleTableView(
          cellPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 18),
          data: [
            if (p != null) SimpleTableRowData('ID', p.id),
            SimpleTableRowData('名称', _buildProgramNameForm()),
            SimpleTableRowData('优先级', _buildPriorityForm()),
          ],
        ),
      ),
    );
  }

  Widget _buildProgramNameForm() {
    return TextFormField(
      maxLength: 30,
      controller: programNameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '节目名称不能为空';
        }
        return null;
      },
    );
  }

  Widget _buildPriorityForm() {
    return TextFormField(
      maxLength: 30,
      controller: priorityController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '优先级不能为空';
        }
        var v = int.tryParse(value);
        if (v == null) {
          return '优先级必须为整数';
        }
        return null;
      },
    );
  }

  Widget _buildTimeConfig() {
    return Card(
      child: SimpleTableView(
        data: [
          SimpleTableRowData(
            '起止日期',
            InkWell(
              onTap: () async {
                var v = await showDateRangePicker(
                  context: context,
                  saveText: '确定',
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2999),
                );
                if (v != null) {
                  setState(() {
                    _selectedDateRange = DateTimeRange(
                      start: v.start,
                      end: v.end,
                    );
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  _selectedDateRange == null
                      ? '请选择'
                      : _selectedDateRange.toString(),
                ),
              ),
            ),
          ),
          SimpleTableRowData(
            '重复类型',
            RadioGroupWidget(
              items: timeConfigTypeItems,
              selectedValue: _selectedTimeConfigType,
              onChanged: (value) {
                setState(() {
                  _selectedTimeConfigType = value;
                });
              },
            ),
          ),
          if (_selectedTimeConfigType != TimeConfigType.daily)
            _buildTimeConfigExt(_selectedTimeConfigType),
        ],
      ),
    );
  }

  SimpleTableRowData _buildTimeConfigExt(TimeConfigType type) {
    switch (type) {
      case TimeConfigType.weekly:
        return SimpleTableRowData(
          '每周',
          CheckboxGroupWidget(
            items: weeklyItems,
            selectedValues: _selectedWeeklydays,
            onChange: (selectedValues) {
              setState(() {
                _selectedWeeklydays = selectedValues;
              });
            },
          ),
        );
      case TimeConfigType.monthly:
        return SimpleTableRowData(
          '每月',
          CheckboxGroupWidget(
            items: monthlyItems,
            selectedValues: _selectedMonthlydays,
            onChange: (selectedValues) {
              _selectedMonthlydays = selectedValues;
            },
          ),
        );
      case TimeConfigType.yearly:
        return SimpleTableRowData('每年', _buildYearlyConfig());
      case TimeConfigType.custom:
        return SimpleTableRowData('自定义', Container());
      default:
        return SimpleTableRowData('每天', Container());
    }
  }

  Widget _buildYearlyConfig() {
    return Wrap(
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            var old = _selectedYearlydays.map((v) => v.toString()).join('\n');
            var controller = TextEditingController(text: old);
            var key = GlobalKey<FormState>();
            convertor(String v) {
              return v
                  .split(RegExp('[\n,; ]'))
                  .where((l) => l.isNotEmpty)
                  .map((l) => MonthDay.parse(l))
                  .toList();
            }

            var nv = await showDialog<List<MonthDay>>(
              context: context,
              builder: (context) {
                return AlertDialog.adaptive(
                  title: Text('每年的固定日期'),
                  content: Form(
                    key: key,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        helperText: '每行一个日期，格式为MM-DD，例如：\n1-1\n1-12\n11-3',
                        helperMaxLines: 10,
                      ),
                      controller: controller,
                      minLines: 10,
                      maxLines: 10,
                      validator: (value) {
                        if (value != null) {
                          try {
                            convertor(value);
                          } catch (e) {
                            return e is FormatException
                                ? e.message
                                : e.toString();
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                      child: Text('取消'),
                    ),
                    TextButton(
                      onPressed: () {
                        var form = key.currentState!;
                        if (form.validate()) {
                          var list = convertor(controller.text);
                          Navigator.pop(context, list);
                        }
                      },
                      child: Text('确定'),
                    ),
                  ],
                );
              },
            );
            if (nv != null) {
              setState(() {
                _selectedYearlydays = nv;
              });
            }
          },
          icon: Icon(Icons.edit),
          label: Text('编辑'),
        ),
        ..._selectedYearlydays.map((v) {
          return Padding(
            padding: const EdgeInsets.only(right: 2),
            child: Chip(
              label: Text(v.toString()),
              deleteIcon: Icon(Icons.close),
              onDeleted: () {
                setState(() {
                  _selectedYearlydays.remove(v);
                });
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSaveButton() {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton.icon(
        onPressed: save,
        label: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Text('保存'),
        ),
        icon: Icon(Icons.save),
      ),
    );
  }

  save() async {
    var form = _formKey.currentState!;
    if (form.validate()) {}
  }
}
