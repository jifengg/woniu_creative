import 'validator.dart';

class IdRequest {
  final int id;

  IdRequest._(this.id);

  factory IdRequest.fromMap(Map<String, String> json) {
    var id = getUint(json, 'id')!;
    return IdRequest._(id);
  }
}

class StringIdRequest {
  final String id;

  StringIdRequest._(this.id);

  factory StringIdRequest.fromMap(Map<String, String> json) {
    var id = getString(json, 'id')!;
    return StringIdRequest._(id);
  }
}
