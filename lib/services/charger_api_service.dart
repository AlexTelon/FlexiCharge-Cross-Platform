import 'dart:convert';

import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:http/http.dart' as http;

class ChargerApiService {
  static const endPoint = "http://54.220.194.65:8080";
  http.Client client = new http.Client();
  var chargerPoint = new ChargerPoint();
  LocalData _localData = locator<LocalData>();
  Future<List<Charger>> getChargers() async {
    var chargers = <Charger>[];
    var response = await client.get(Uri.parse('$endPoint/chargers'));
    switch (response.statusCode) {
      case 200:
        var parsed = json.decode(response.body) as List<dynamic>;
        var i = 0;
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

  Future<List<Charger>> getChargerPoints() async {
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
    // print(id);
    var response = await client.get(Uri.parse('$endPoint/chargers/$id'));
    // print(response.body);
    switch (response.statusCode) {
      case 200:
        var charger = json.decode(response.body);
        var chargerFromJson = Charger.fromJson(charger);
        return chargerFromJson;
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
  Future<void> updateStatus(int status, int id, int chargePointID) async {
    await client
        .put(
          Uri.parse('$endPoint/chargers/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, int>{
            'status': status,
          }),
        )
        .then((result) => {
              print("test" + result.statusCode.toString()),
              print("test2" + result.body.toString()),
              print("test3" + id.toString())
            });
  }
}
