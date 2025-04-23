// lib/models/channel_response.dart
import 'package:json_annotation/json_annotation.dart';
import '../api/base_response.dart';

part 'upload_response.g.dart';

/// 频道响应顶层对象
@JsonSerializable()
class UploadResponse extends BaseResponse {
  /// 频道数据容器
  @override
  UploadResponseData? get data => super.data as UploadResponseData?;

  UploadResponse({
    required super.code,
    super.message,
    UploadResponseData? super.data,
  });

  factory UploadResponse.fromJson(Map<String, dynamic> json) =>
      _$UploadResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UploadResponseToJson(this);
}

@JsonSerializable()
class UploadResponseData {
  String? filename;
  String? url;
  @JsonKey(name: 'preview_url')
  String? previewUrl;

  UploadResponseData({this.filename, this.url, this.previewUrl});

  factory UploadResponseData.fromJson(Map<String, dynamic> json) =>
      _$UploadResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$UploadResponseDataToJson(this);
}
