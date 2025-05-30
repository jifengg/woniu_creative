import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:woniu_creative/global.dart';
import 'package:woniu_creative/models/api/channel_response.dart';
import 'package:woniu_creative/models/api/register_response.dart';

import '../models/api/base_response.dart';
import '../models/api/upload_response.dart';

String baseUrl =
    kDebugMode ? 'http://127.0.0.1:7780/api/' : 'http://127.0.0.1:7781/api/';

String _token = 'FkJHWS7zjfGPuDpowX2zccasl7er9UR3GaZY'; //'no-token';

Dio? _dio;
Dio get dio {
  _dio ??= Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Authorization': 'Bearer $_token',
        'Content-Type': 'application/json',
      },
    ),
  );
  return _dio!;
}

update({String? base, String? token}) {
  if (base != null) {
    baseUrl = base;
    dio.options.baseUrl = baseUrl;
  }
  if (token != null) {
    _token = token;
    dio.options.headers['Authorization'] = 'Bearer $_token';
  }
}

T convert2BaseResponse<T extends BaseResponse>(Response<dynamic> res) {
  if (res.statusCode == 200) {
    handleResponseCode(res.data);
    if (T == RegisterResponse) {
      return RegisterResponse.fromJson(res.data) as T;
    }
    if (T == ChannelResponse) {
      return ChannelResponse.fromJson(res.data) as T;
    }
    if (T == UploadResponse) {
      return UploadResponse.fromJson(res.data) as T;
    }
    return BaseResponse.fromJson(res.data) as T;
  } else {
    throw DioException.badResponse(
      statusCode: res.statusCode!,
      requestOptions: res.requestOptions,
      response: res,
    );
  }
}

Future<T> get<T extends BaseResponse>(
  String path, {
  Map<String, dynamic>? queryParameters,
}) async {
  var res = await dio.get(path, queryParameters: queryParameters);
  return convert2BaseResponse<T>(res);
}

Future<T> post<T extends BaseResponse>(
  String path, {
  Map<String, dynamic>? queryParameters,
  Object? data,
}) async {
  var res = await dio.post(
    path,
    queryParameters: queryParameters,
    data: jsonEncode(data),
  );
  return convert2BaseResponse<T>(res);
}

Future<T> put<T extends BaseResponse>(
  String path, {
  Map<String, dynamic>? queryParameters,
  Object? data,
}) async {
  var res = await dio.put(
    path,
    queryParameters: queryParameters,
    data: jsonEncode(data),
  );
  return convert2BaseResponse<T>(res);
}

Future<T> delete<T extends BaseResponse>(
  String path, {
  Map<String, dynamic>? queryParameters,
}) async {
  var res = await dio.delete(path, queryParameters: queryParameters);
  return convert2BaseResponse<T>(res);
}

Future<T> upload<T extends BaseResponse>(
  String path, {
  required File file,
  Map<String, dynamic>? queryParameters,
  Object? data,
  ProgressCallback? onSendProgress,
}) async {
  Stream<List<int>> stream = file.openRead();
  var filesize = file.lengthSync();
  var res = await dio.put(
    path,
    queryParameters: queryParameters,
    data: stream,
    onSendProgress: onSendProgress,
    // 必须设置Content-Length，才能触发onSendProgress
    options: Options(
      headers: {'Content-Length': filesize},
    ),
  );
  return convert2BaseResponse<T>(res);
}
