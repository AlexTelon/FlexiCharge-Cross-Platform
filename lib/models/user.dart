/// The User class is a Dart class that is used to create a User object.
/// The User object is used to store the user's email, mobile number, password
/// and repeated password. The User class also has a factory constructor that
/// is used to create a User object from the response data that is returned
/// from the API
class User {
  String email;
  String mobileNumber;
  String password;
  String repeatedPassword;

  User(
      {required this.email,
      required this.mobileNumber,
      required this.password,
      required this.repeatedPassword});

  //This is the response data from the API.
  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        email: responseData['email'],
        mobileNumber: responseData[
            'username'], //mobileNumber does currently exist in FlexiCharge API
        password: responseData['password'],
        repeatedPassword: responseData[
            'password']); //repeat password data does currently exist in FlexiCharge API
  }
}
