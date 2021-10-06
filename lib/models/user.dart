

class User{
  String id = '';
  String name = '';
  String familyName = '';
  String email = '';
  String username = '';
  String password = '';
  String accessToken = '';

  User();
  User.fromUser({
    required this.name,
    required this.familyName,
    required this.email,
    required this.username,
    required this.password
  });

  User.fromJson(Map<String, dynamic> json){
    name = json['name'];
    familyName = json['family_name'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
  }
}