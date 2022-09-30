/// A class that stores the user's access token in the device's secure storage.
/// This is class that could be extended to store all user information
import 'dart:ffi';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  // Create storage
  static final _storage = FlutterSecureStorage();
  static const _userAccessToken = "token";
  static const _userId = "noUserId";
  static const _userIsLoggedIn = false;

// Write value
  static Future setUserAccessToken(String AccessToken) async =>
      await _storage.write(key: _userAccessToken, value: AccessToken);

  static Future setUserId(String userId) async =>
      await _storage.write(key: _userId, value: userId);

  /* static Future setUserIsLoggedIn(Bool isUserLoggedIn) async =>
      await _storage.write(key: _userIsLoggedIn, value: isUserLoggedIn);*/

// Read value
  static Future<String?> getUserAccessToken() async =>
      await _storage.read(key: _userAccessToken);

  static Future<String?> getUserUserId() async =>
      await _storage.read(key: _userId);

// Delete value
  static Future deleteUserAccessToken() async =>
      await _storage.delete(key: _userAccessToken);

// Read all values
//Map<String, String> allValues = await storage.readAll();

// Delete all
//await storage.deleteAll();

}
