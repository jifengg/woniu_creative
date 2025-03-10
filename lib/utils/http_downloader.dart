import 'dart:io';
import 'dart:async';

typedef ResponseHeaderCallback =
    Future<DownloadConfig?> Function(HttpHeaders headers);
typedef ProgressCallback = void Function(int received, int total);
typedef SuccessCallback = void Function(String path, Duration duration);
typedef FailureCallback = void Function(dynamic error);

class DownloadConfig {
  final bool cancel;
  final String? fullPath;

  DownloadConfig({this.cancel = false, this.fullPath});
}

class Downloader {
  final String url;
  final String localPath;
  final Map<String, String> headers;
  final ResponseHeaderCallback? onResponseHeaders;
  final ProgressCallback? onProgress;
  final SuccessCallback? onSuccess;
  final FailureCallback? onFailure;

  bool _isCancelled = false;
  HttpClient? _httpClient;
  HttpClientResponse? _response;
  IOSink? _fileSink;

  Downloader({
    required this.url,
    required this.localPath,
    Map<String, String> headers = const {},
    String? userAgent,
    String? cookie,
    this.onResponseHeaders,
    this.onProgress,
    this.onSuccess,
    this.onFailure,
  }) : headers = _mergeHeaders(headers, userAgent, cookie);

  static Map<String, String> _mergeHeaders(
    Map<String, String> headers,
    String? userAgent,
    String? cookie,
  ) {
    final merged = <String, String>{};
    headers.forEach((key, value) {
      final standardizedKey = key
          .split('-')
          .map(
            (e) =>
                e.isEmpty
                    ? ''
                    : '${e[0].toUpperCase()}${e.substring(1).toLowerCase()}',
          )
          .join('-');
      merged[standardizedKey] = value;
    });
    if (userAgent != null) merged['User-Agent'] = userAgent;
    if (cookie != null) merged['Cookie'] = cookie;
    return merged;
  }

  Future<void> start() async {
    final stopwatch = Stopwatch()..start();
    try {
      final client = HttpClient();
      _httpClient = client;
      final request = await client.getUrl(Uri.parse(url));
      headers.forEach(request.headers.add);

      final response = await request.close();
      String finalPath = localPath;
      DownloadConfig? config;

      if (onResponseHeaders != null) {
        config = await onResponseHeaders!(response.headers);
        if (config != null) {
          if (config.cancel) {
            await response.drain();
            return;
          }
          if (config.fullPath != null) {
            finalPath = config.fullPath!;
          }
        }
      }

      final file = File(finalPath);
      final supportRange = response.headers.value('Accept-Ranges') == 'bytes';
      int startByte = await file.exists() ? await file.length() : 0;

      if (supportRange && startByte > 0) {
        //关闭上一个请求。重新发起请求从断点处开始获取数据
        response.drain();
        await _resumeDownload(client, startByte, file);
      } else {
        await _startNewDownload(response, file);
      }

      stopwatch.stop();
      onSuccess?.call(finalPath, stopwatch.elapsed);
    } catch (e) {
      stopwatch.stop();
      if (onFailure != null) {
        onFailure?.call(e);
      } else {
        rethrow;
      }
    }
  }

  Future cancel({bool deletePartial = true}) async {
    _isCancelled = true;
    _httpClient?.close(force: true);
    await _response?.detachSocket();
    await _fileSink?.close();

    if (deletePartial) {
      final file = File(localPath);
      if (file.existsSync()) {
        file.deleteSync();
      }
    }
  }

  Future<void> _resumeDownload(
    HttpClient client,
    int startByte,
    File file,
  ) async {
    final request = await client.getUrl(Uri.parse(url));
    headers.forEach(request.headers.add);
    request.headers.add('Range', 'bytes=$startByte-');

    final response = await request.close();
    if (response.statusCode != HttpStatus.partialContent) {
      throw Exception('Server does not support range requests');
    }

    final sink = file.openWrite(mode: FileMode.append);
    await _handleResponse(response, sink, startByte);
  }

  Future<void> _startNewDownload(HttpClientResponse response, File file) async {
    final sink = file.openWrite();
    await _handleResponse(response, sink, 0);
  }

  Future<void> _handleResponse(
    HttpClientResponse response,
    IOSink sink,
    int startByte,
  ) async {
    _response = response;
    _fileSink = sink;
    int received = startByte;
    final total = _getContentLength(response) ?? -1;

    try {
      await response.forEach((data) {
        if (_isCancelled) {
          throw Exception('Download cancelled');
        }
        received += data.length;
        sink.add(data);
        if (onProgress != null && total != -1) {
          onProgress!(received, total);
        }
      });
    } catch (e) {
      if (_isCancelled) {
        sink.close();
        throw Exception('Download cancelled');
      }
      rethrow;
    }

    await sink.close();
    await sink.done;

    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.partialContent) {
      throw Exception('Download failed with status: ${response.statusCode}');
    }
  }

  int? _getContentLength(HttpClientResponse response) {
    final contentLength = response.headers.contentLength;
    return contentLength == -1 ? null : contentLength;
  }
}
