import 'dart:convert';

import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:http/http.dart' as http;

class ChargerApiService {
  static const endPoint = "http://localhost:8080/";
  // https://retoolapi.dev/uwBd3x/data?chargerId%20=159995
  var client = new http.Client();

  Future<List<Charger>> getChargers() async {
    var chargers = <Charger>[];
    var response = await client.get(Uri.parse('$endPoint/chargers'));
    switch (response.statusCode) {
      case 200:
        var parsed = json.decode(response.body) as List<dynamic>;
        for (var charger in parsed) {
          chargers.add(Charger.fromJson(charger));
        }
        return chargers;
      case 500:
        throw Exception("Internal server error");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  /// Remove .first from the return when you use the flexi charger Api
  Future<Charger> getChargerById(int id) async {
    // https://retoolapi.dev/uwBd3x/data?chargerId%20=159995

    var response = await client
        .get(Uri.parse('https://retoolapi.dev/xLZMZ7/data?chargerId=$id'));
    switch (response.statusCode) {
      case 200:
        var charger = json.decode(response.body);
        return Charger.fromJson(charger.first);
      case 404:
        throw Exception("Not Found");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<List<Charger>> getAllAvailableChargers() async {
    var chargers = <Charger>[];
    var response = await client.get(Uri.parse('$endPoint/chargers/available'));
    switch (response.statusCode) {
      case 200:
        var parsed = json.decode(response.body) as List<dynamic>;
        for (var charger in parsed) {
          chargers.add(Charger.fromJson(charger));
        }
        return chargers;
      case 404:
        throw Exception("Not Found");
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  // The function don't work yet...
  Future<Charger> getChargersByChargerPointId(chargerPointId) async {
    var response = await client.get(Uri.parse('$endPoint/chargers'));
    return Charger.fromJson(jsonDecode(response.body));
  }

  //Check later
  Future<Charger> updateStatus(status, id) async {
    var response = await client.put(
      Uri.parse('$endPoint/chargers/$id'),
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
