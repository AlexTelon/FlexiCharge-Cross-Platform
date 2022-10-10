/// It's a class that contains static variables that are used to make requests
/// to the server
class API {
  static const url = 'http://18.202.253.30:8080';

  static const defaultRequestHeaders = <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };
}
