import 'package:json_annotation/json_annotation.dart';

/// DateTime 与 json formatter ，与String相互 转换，继承JsonConverter
class CustomDateTimeFormatter extends JsonConverter<DateTime, String> {
  const CustomDateTimeFormatter();

  @override
  DateTime fromJson(String json) {
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime object) {
    //yyyy-MM-dd HH:mm:ss
    return object.toString().substring(0, 19);
  }
}
