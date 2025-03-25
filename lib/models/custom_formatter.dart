import 'package:json_annotation/json_annotation.dart';

/// DateTime 与 json formatter ，与String相互 转换，继承JsonConverter
class CustomDateTimeFormatter extends JsonConverter<DateTime?, String?> {
  const CustomDateTimeFormatter();

  @override
  DateTime? fromJson(String? json) {
    return json == null ? null : DateTime.parse(json);
  }

  @override
  String? toJson(DateTime? object) {
    //yyyy-MM-dd HH:mm:ss
    return object?.toString().substring(0, 19);
  }
}

class BoolIntConverter extends JsonConverter<bool?, int?> {
  const BoolIntConverter();

  @override
  bool? fromJson(int? json) {
    return json == null ? null : json == 1;
  }

  @override
  int? toJson(bool? object) {
    return object == null ? null : (object ? 1 : 0);
  }
}
