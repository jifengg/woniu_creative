import 'dart:io';
import 'package:path/path.dart';
import 'package:dio/dio.dart';
import 'package:woniu_creative/api/http_helper.dart';
import 'package:woniu_creative/models/api/upload_response.dart';

Future<UploadResponseData> uploadFile(
  File file, {
  ProgressCallback? onSendProgress,
}) async {
  var data = {'filename': basename(file.path)};
  var res = await upload<UploadResponse>(
    'admin/file/upload',
    file: file,
    queryParameters: data,
    onSendProgress: onSendProgress,
  );
  if (res.data == null) {
    throw Exception(res.message);
  }
  return res.data!;
}
