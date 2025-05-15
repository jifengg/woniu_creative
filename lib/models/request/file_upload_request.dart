import 'validator.dart';

class FileUploadRequest {
  final String? fileName;

  FileUploadRequest._(this.fileName);

  factory FileUploadRequest.fromJson(Map<String, dynamic> json) {
    var filename = getString(json, 'filename');
    return FileUploadRequest._(filename);
  }
}
