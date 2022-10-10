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
