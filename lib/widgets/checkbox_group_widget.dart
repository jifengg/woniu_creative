import 'package:flutter/material.dart';

class CheckboxGroupWidget<T> extends StatelessWidget {
  const CheckboxGroupWidget({
    super.key,
    required this.items,
    required this.selectedValues,
    required this.onChange,
  }) : assert(items.length != 0, 'items must not be empty');

  final List<CheckboxGroupItem<T>> items;
  final List<T> selectedValues;
  final void Function(List<T> selectedValues) onChange;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children:
          items.map((item) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Checkbox.adaptive(
                  value: selectedValues.contains(item.value),
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

  void handleChange(CheckboxGroupItem<T> item) {
    var list = [...selectedValues];
    if (list.contains(item.value)) {
      list.remove(item.value);
    } else {
      list.add(item.value);
    }
    onChange.call(list);
  }
}

// class CheckboxGroupWidget<T> extends StatefulWidget {
//   const CheckboxGroupWidget({
//     super.key,
//     required this.items,
//     required this.selectedValues,
//     required this.onChange,
//   }) : assert(items.length != 0, 'items must not be empty');

//   final List<CheckboxGroupItem<T>> items;
//   final List<T> selectedValues;
//   final void Function(List<T> selectedValues) onChange;

//   @override
//   State<CheckboxGroupWidget<T>> createState() => _CheckboxGroupWidgetState<T>();
// }

// class _CheckboxGroupWidgetState<T> extends State<CheckboxGroupWidget<T>> {
//   late List<T> selectedValues;
//   @override
//   void initState() {
//     super.initState();
//     // clone原数组，避免修改到原数组
//     selectedValues = [...widget.selectedValues];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       children:
//           widget.items.map((item) {
//             return Row(
//               mainAxisSize: MainAxisSize.min,
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Checkbox.adaptive(
//                   value: selectedValues.contains(item.value),
//                   onChanged: (v) => handleChange(item),
//                 ),
//                 InkWell(
//                   onTap: () => handleChange(item),
//                   child: Text(item.label),
//                 ),
//                 SizedBox(width: 4),
//               ],
//             );
//           }).toList(),
//     );
//   }

//   void handleChange(CheckboxGroupItem<T> item) {
//     if (selectedValues.contains(item.value)) {
//       selectedValues.remove(item.value);
//     } else {
//       selectedValues.add(item.value);
//     }
//     setState(() {});
//     widget.onChange.call(selectedValues);
//   }
// }

class CheckboxGroupItem<T> {
  final String label;
  final T value;

  CheckboxGroupItem(this.value, this.label);
}
