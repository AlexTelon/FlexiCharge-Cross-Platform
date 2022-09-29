import 'package:flexicharge/services/user_auth_api_service.dart';

class Registration {
  String email = '';
  String verificationCode = '';

  Registration.fromTransaction({
    required this.email,
    required this.verificationCode,
  });

  Registration.fromJson(Map<String, dynamic> json) {
    email = json['username'] ?? "";
    verificationCode = json['verification_code'] ?? '';
  }
}
