// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadResponse _$UploadResponseFromJson(Map<String, dynamic> json) =>
    UploadResponse(
      code: (json['code'] as num).toInt(),
      message: json['message'] as String?,
      data:
          json['data'] == null
              ? null
              : UploadResponseData.fromJson(
                json['data'] as Map<String, dynamic>,
              ),
    );

Map<String, dynamic> _$UploadResponseToJson(UploadResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

UploadResponseData _$UploadResponseDataFromJson(Map<String, dynamic> json) =>
    UploadResponseData(
      filename: json['filename'] as String?,
      url: json['url'] as String?,
      previewUrl: json['preview_url'] as String?,
    );

Map<String, dynamic> _$UploadResponseDataToJson(UploadResponseData instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'url': instance.url,
      'preview_url': instance.previewUrl,
    };
