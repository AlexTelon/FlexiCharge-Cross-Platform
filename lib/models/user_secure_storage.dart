/// A class that stores the user's access token in the device's secure storage.
/// This is class that could be extended to store all user information
/// The package flutter_secure_storage only supports storeing strings

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  // Create storage
  static final _storage = FlutterSecureStorage();

  static const _userAccessToken = "token";
  static const _userId = "noUserId";
  static const _userIsLoggedIn = "false";

// Write value
  static Future setUserAccessToken(String accessToken) async =>
      await _storage.write(key: _userAccessToken, value: accessToken);

  static Future setUserId(String userId) async =>
      await _storage.write(key: _userId, value: userId);

  static Future setUserIsLoggedIn(bool boolIsUserLoggedIn) async {
    String isUserLoggedIn = boolIsUserLoggedIn.toString();
    await _storage.write(key: _userIsLoggedIn, value: isUserLoggedIn);
  }

// Read value
  static Future<String?> getUserAccessToken() async =>
      await _storage.read(key: _userAccessToken);

  static Future<String?> getUserUserId() async =>
      await _storage.read(key: _userId);

  static Future<bool> getUserIsLoggedIn() async {
    var userIsLoggedIn = await _storage.read(key: _userIsLoggedIn);
    return userIsLoggedIn.toString().toLowerCase() == 'true';
  }

// Read all values
//Map<String, String> allValues = await storage.readAll();

// Delete value
  static Future deleteUserAccessToken() async =>
      await _storage.delete(key: _userAccessToken);

// Delete all values
  static Future deleteAllUserStorage() async => await _storage.deleteAll();
}
