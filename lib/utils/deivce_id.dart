import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';

var storageKey = 'device_id';

String? _v;

Future<String> getDeviceId() async {
  if (_v != null) {
    return _v!;
  }
  var sp = await SharedPreferences.getInstance();
  var v = sp.getString(storageKey);
  if (v == null) {
    int min = 1_0000_0000;
    var newid =
        Random(DateTime.now().millisecondsSinceEpoch).nextInt(min * 9) + min;
    v = newid.toString();
    await sp.setString(storageKey, v);
  }
  _v = v;
  return v;
}
