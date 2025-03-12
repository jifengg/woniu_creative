import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';
import 'package:woniu_creative/global.dart';
import 'package:woniu_creative/pages/admin/admin_page.dart';
import 'package:woniu_creative/pages/client_setting_page.dart';
import 'package:woniu_creative/pages/display_page.dart';
import 'package:woniu_creative/utils/file_manager.dart';
import 'package:woniu_creative/utils/logger_utils.dart';
import 'pages/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  VideoPlayerMediaKit.ensureInitialized(
    android:
        true, // default: false    -    dependency: media_kit_libs_android_video
    // iOS: true,              // default: false    -    dependency: media_kit_libs_ios_video
    // macOS: true,            // default: false    -    dependency: media_kit_libs_macos_video
    windows:
        true, // default: false    -    dependency: media_kit_libs_windows_video
    // linux: true,            // default: false    -    dependency: media_kit_libs_linux
  );
  var fileRoot =
      (await (Platform.isAndroid
              ? getExternalStorageDirectory()
              : getApplicationSupportDirectory()))!
          .path;
  LoggerUtils.init();
  FileManager.init(rootPath: fileRoot);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: getTheme(),
      darkTheme: getTheme(brightness: Brightness.dark),
      builder: (context, child) {
        return child!;
      },
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // 添加指定支持的locale，在windows平台显示中文时，可以避免字体回落造成的cjk字符显示效果与预期不一致。
      supportedLocales: const [Locale('zh', 'CN'), Locale('en', 'US')],
      // home: const DisplayPage(),
      initialRoute: '/client_setting',
      routes: {
        '/register': (context) => const RegistrationScreen(),
        '/display': (context) => const DisplayPage(),
        '/client_setting': (context) => const ClientSettingPage(),
        '/admin': (context) => const AdminPage(),
      },
    );
  }
}

ThemeData getTheme({
  Color seedColor = Colors.blue,
  Brightness brightness = Brightness.light,
}) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    ),
    useMaterial3: true,
  );
}
