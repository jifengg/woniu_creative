import 'package:flutter/material.dart';

extension StateExt on State {
  /// 获取当前是否在PC模式
  bool get isPC => MediaQuery.of(context).size.width > 600;
}

extension BuildContextExt on BuildContext {
  /// 获取当前是否在PC模式
  bool get isPC => MediaQuery.of(this).size.width > 600;
}
