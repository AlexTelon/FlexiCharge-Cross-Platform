/// A class that stores the user's access token in the device's secure storage.
/// This is class that could be extended to store all user information
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  // Create storage
  static final _storage = FlutterSecureStorage();
  static const _userAccessToken = "token";

// Write value
  static Future setUserAccessToken(String AccessToken) async =>
      await _storage.write(key: _userAccessToken, value: AccessToken);

// Read value
  static Future<String?> getUserAccessToken() async =>
      await _storage.read(key: _userAccessToken);

// Delete value
  static Future deleteUserAccessToken() async =>
      await _storage.delete(key: _userAccessToken);

// Read all values
//Map<String, String> allValues = await storage.readAll();

// Delete all
//await storage.deleteAll();

}
