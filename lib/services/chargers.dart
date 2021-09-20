import 'dart:convert';

import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:http/http.dart' as http;

class ChargerApiService {
  Future<Charger> getChargers() async {
    var response = await http.get(Uri.parse('http://localhost:8080/chargers'));
    switch (response.statusCode) {
      case 200:
        return Charger.fromJson(jsonDecode(response.body));
      case 500:
        throw Exception("Internal server error");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<Charger> getChargerById(String id) async {
    var response =
        await http.get(Uri.parse('http://localhost:8080/chargers/' + id));
    switch (response.statusCode) {
      case 200:
        return Charger.fromJson(jsonDecode(response.body));
      case 404:
        throw Exception("Not Found");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<Charger> getAllAvailableChargers() async {
    var response = await http
        .get(Uri.parse('http://localhost:8080/chargers/chargers/available'));
    switch (response.statusCode) {
      case 200:
        return Charger.fromJson(jsonDecode(response.body));
      case 404:
        throw Exception("Not Found");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  // The function don't work yet...
  Future<Charger> getChargersByChargerPointId(chargerPointId) async {
    var response = await http.get(Uri.parse('http://localhost:8080/chargers'));
    return Charger.fromJson(jsonDecode(response.body));
  }

  //Check later
  Future<Charger> updateStatus(status, id) async {
    var response = await http.put(
      Uri.parse('http://localhost:8080/chargers/' + id),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'status': status,
      }),
    );
    switch (response.statusCode) {
      case 204:
        return Charger.fromJson(jsonDecode(response.body));
      case 400:
        throw Exception("Bad Request");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }
}
