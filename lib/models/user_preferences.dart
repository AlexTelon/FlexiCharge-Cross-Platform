// ignore_for_file: unused_local_variable
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flexicharge/models/user.dart';

class UserPreferences {
  
  Future<void> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // var valString = jsonEncode(user);
    // var _res = prefs.setString("$User", valString);

    prefs.setString('userid', user.id);
    prefs.setString('username', user.username);
    prefs.setString('name', user.name);
    prefs.setString('family_name', user.familyName);
    prefs.setString('email', user.email);
    prefs.setString('token', user.accessToken);
  }
}
