import 'dart:async';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:woniu_creative/utils/http_downloader.dart';

void main() {
  // 定义测试目录
  final testDir = Directory('build/dl_test');
  final validUrl = 'http://192.168.3.82/share/FiddlerSetup.exe';
  final filesize = 6840480;
  final invalidUrl = 'http://192.168.3.82/share/404.zip';

  setUp(() async {
    // 创建测试目录
    if (await testDir.exists()) {
      await testDir.delete(recursive: true);
    }
    await testDir.create();
  });

  // tearDown(() async {
  //   // 清理测试目录
  //   if (await testDir.exists()) {
  //     await testDir.delete(recursive: true);
  //   }
  // });

  test('基本下载成功测试', () async {
    final filePath = '${testDir.path}/FiddlerSetup.exe';

    final dl = Downloader(
      url: validUrl,
      localPath: filePath,
      onResponseHeaders: (headers) async {
        expect(headers.value('Accept-Ranges'), 'bytes');
        return null; // 使用默认路径
      },
      onSuccess: (path, duration) {
        expect(path, filePath);
        expect(File(path).existsSync(), true);
        expect(File(path).lengthSync(), greaterThan(1024 * 1024)); // 验证文件大小合理
      },
    );

    await dl.start();
  });

  test('修改下载路径测试', () async {
    final newFilePath = '${testDir.path}/custom_name.exe';

    final dl = Downloader(
      url: validUrl,
      localPath: '${testDir.path}/default.exe',
      onResponseHeaders: (headers) async {
        return DownloadConfig(fullPath: newFilePath);
      },
      onSuccess: (path, duration) {
        expect(path, newFilePath);
        expect(File(newFilePath).existsSync(), true);
      },
    );

    await dl.start();
  });

  test('取消下载测试', () async {
    final dl = Downloader(
      url: validUrl,
      localPath: '${testDir.path}/cancel_test.exe',
      onResponseHeaders: (headers) async {
        return DownloadConfig(cancel: true);
      },
      onFailure: (error) {
        fail('不应触发失败回调');
      },
    );

    await dl.start();
    expect(File('${testDir.path}/cancel_test.exe').existsSync(), false);
  });

  test('404错误测试', () async {
    final completer = Completer<void>();

    final dl = Downloader(
      url: invalidUrl,
      localPath: '${testDir.path}/404.zip',
      onFailure: (error) {
        expect(error.toString(), contains('404'));
        completer.complete();
      },
    );

    await dl.start();
    return completer.future;
  });

  test('Header标准化测试', () async {
    final dl = Downloader(
      url: validUrl,
      localPath: '${testDir.path}/header_test.exe',
      headers: {'user-agent': 'test-agent', 'CoOkIe': 'test-cookie'},
      onResponseHeaders: (headers) async {
        // 验证发送的Header是否被标准化
        expect(headers.value('User-Agent'), 'test-agent');
        expect(headers.value('Cookie'), 'test-cookie');
        return null;
      },
    );

    await dl.start();
  });

  test('断点续传测试', () async {
    var resumableUrl = validUrl;
    final testFile = File('${testDir.path}/512k.exe');
    var partialSize = 512 * 1024; // 512KB

    // 确保测试文件不存在
    if (await testFile.exists()) {
      await testFile.delete();
    }
    // 第一次下载：创建部分文件
    final firstDownload = Completer<void>();
    Downloader? dl1;
    dl1 = Downloader(
      url: resumableUrl,
      localPath: testFile.path,
      onResponseHeaders: (headers) async {
        expect(headers.value('Accept-Ranges'), 'bytes');
        return null;
      },
      onProgress: (received, total) async {
        // 下载到512KB时取消
        if (received >= partialSize) {
          partialSize = received;
          await dl1!.cancel(deletePartial: false); // 需要在Downloader类中添加cancel方法
          firstDownload.complete();
        }
      },
    );
    // 启动第一次下载并等待取消
    await dl1.start();
    await firstDownload.future;

    // 验证部分文件存在
    expect(await testFile.exists(), true);
    expect(await testFile.length(), partialSize);

    // 第二次下载：续传
    final completer = Completer<void>();
    final dl2 = Downloader(
      url: resumableUrl,
      localPath: testFile.path,
      onSuccess: (path, duration) async {
        // 验证最终文件大小
        expect(await File(path).length(), filesize);
        completer.complete();
      },
    );

    await dl2.start();
    return completer.future;
  });
}
