import 'dart:io';

import 'package:dio/dio.dart';
import 'package:woniu_creative/api/http_helper.dart';
import 'package:woniu_creative/models/api/upload_response.dart';

Future<UploadResponseData> uploadFile(
  File file, {
  ProgressCallback? onSendProgress,
}) async {
  var res = await upload<UploadResponse>(
    'file/upload',
    file: file,
    onSendProgress: onSendProgress,
  );
  if (res.data == null) {
    throw Exception(res.message);
  }
  return res.data!;
}
