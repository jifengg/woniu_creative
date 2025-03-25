import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:woniu_creative/models/api/channel_response.dart';
import 'package:woniu_creative/models/api/register_response.dart';

import '../models/api/base_response.dart';

String baseUrl =
    kDebugMode ? 'http://127.0.0.1:7780/api/' : 'http://127.0.0.1:7781/api/';

T convert2BaseResponse<T extends BaseResponse>(Response<dynamic> res) {
  if (res.statusCode == 200) {
    if (T == RegisterResponse) {
      return RegisterResponse.fromJson(res.data) as T;
    }
    if (T == ChannelResponse) {
      return ChannelResponse.fromJson(res.data) as T;
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
  var dio = Dio(BaseOptions(baseUrl: baseUrl));
  var res = await dio.get(path, queryParameters: queryParameters);
  return convert2BaseResponse<T>(res);
}

Future<T> post<T extends BaseResponse>(
  String path, {
  Map<String, dynamic>? queryParameters,
  Object? data,
}) async {
  var dio = Dio(BaseOptions(baseUrl: baseUrl));
  var res = await dio.post(
    path,
    queryParameters: queryParameters,
    data: jsonEncode(data),
  );
  return convert2BaseResponse<T>(res);
}
