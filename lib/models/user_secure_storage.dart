import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  // Create storage
  static final _storage = new FlutterSecureStorage();

  static const _userAccessToken = "token";

// Read value
  static Future readUserAccessToken() async =>
      await _storage.read(key: _userAccessToken);

// Read all values
//Map<String, String> allValues = await storage.readAll();

// Delete value
//await storage.delete(key: key);

// Delete all
//await storage.deleteAll();

// Write value
  static Future setUserAccessToken(String AccessToken) async =>
      await _storage.write(key: _userAccessToken, value: AccessToken);
}
