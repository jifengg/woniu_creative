import 'package:flutter/material.dart';

import 'widgets/simple_dialog.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

String? deviceId;

handleResponseCode(dynamic data) async {
  var code = data["code"];
  if (code == 200) {
    return;
  }
  () async {
    // var context = navigatorKey.currentContext!;
    switch (code) {
      case 402:
        await alert('登录状态已经失效，请重新登录', context: navigatorKey.currentContext!);
        await Navigator.pushNamedAndRemoveUntil(
          navigatorKey.currentContext!,
          '/admin/login',
          (route) => false,
        );
        break;
      default:
    }
  }();
  throw Exception(data);
}
