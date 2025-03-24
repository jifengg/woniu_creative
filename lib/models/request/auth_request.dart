import 'validator.dart';

class LoginRequest {
  final String username;
  final String password;

  LoginRequest._(this.username, this.password);

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    var username = getString(json, 'username')!;
    var password = getString(json, 'password')!;
    return LoginRequest._(username, password);
  }
}

class ChangePasswordRequest {
  final String newPassword;
  final String oldPassword;

  ChangePasswordRequest._(this.newPassword, this.oldPassword);

  factory ChangePasswordRequest.fromJson(Map<String, dynamic> json) {
    var newPassword = getString(json, 'new_password', min: 6, max: 16)!;
    var oldPassword = getString(json, 'old_password')!;
    return ChangePasswordRequest._(newPassword, oldPassword);
  }
}

class RegisterRequest {
  final String username;
  final String password;
  final String name;

  RegisterRequest._(this.username, this.password, this.name);

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    var username = getString(json, 'username')!;
    var password = getString(json, 'password')!;
    var name = getString(json, 'name', min: 3, max: 16)!;
    return RegisterRequest._(username, password, name);
  }
}
