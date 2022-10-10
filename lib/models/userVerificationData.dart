/// This class is used to store the data that is sent to the server when a
/// user is verified
class UserVerificationData {
  String email = '';
  String verificationCode = '';

  UserVerificationData.fromTransaction({
    required this.email,
    required this.verificationCode,
  });

  UserVerificationData.fromJson(Map<String, dynamic> json) {
    email = json['username'] ?? "";
    verificationCode = json['verification_code'] ?? '';
  }
}
