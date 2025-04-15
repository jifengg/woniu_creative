import 'package:flutter/material.dart';

class RadioGroupWidget<T> extends StatefulWidget {
  const RadioGroupWidget({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  }) : assert(items.length != 0, 'items must not be empty');

  final List<RadioGroupItem<T>> items;
  final T selectedValue;
  final void Function(T value) onChanged;

  @override
  State<RadioGroupWidget<T>> createState() => _RadioGroupWidgetState<T>();
}

class _RadioGroupWidgetState<T> extends State<RadioGroupWidget<T>> {
  late T selectedValue;
  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children:
          widget.items.map((item) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio.adaptive(
                  value: item.value,
                  groupValue: selectedValue,
                  onChanged: (v) => handleChange(item),
                ),
                InkWell(
                  onTap: () => handleChange(item),
                  child: Text(item.label),
                ),
                SizedBox(width: 4),
              ],
            );
          }).toList(),
    );
  }

  handleChange(RadioGroupItem<T> item) {
    selectedValue = item.value;
    setState(() {});
    widget.onChanged.call(item.value);
  }
}

class RadioGroupItem<T> {
  final String label;
  final T value;

  RadioGroupItem(this.value, this.label);
}
