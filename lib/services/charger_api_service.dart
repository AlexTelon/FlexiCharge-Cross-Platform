import 'dart:convert';

import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
        for (var charger in parsed) {
          chargers.add(Charger.fromJson(charger));
        }
        return chargers;
      case 500:
        throw Exception(ErrorCodes.internalError);
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<List<ChargerPoint>> getChargerPoints() async {
    List<ChargerPoint> chargerPoints = [];

    try {
      var response = await client.get(Uri.parse('$endPoint/chargers'));
      switch (response.statusCode) {
        case 200:
          List<dynamic> chargers = json.decode(response.body);
          if (chargers.isEmpty)
            return throw throw Exception('No Chargers Found');
          for (var charger in chargers) {
            var chargerPoint = chargerPoints
                .where(
                    (value) => value.chargerPointId == charger['chargePointID'])
                .toList();
            if (chargerPoint.isNotEmpty) {
              var firstChargerPoint = chargerPoint.first;

              chargerPoint.first.chargers.add(Charger.fromCharger(
                id: charger['chargerID'],
                cost: firstChargerPoint.price,
                chargerPointId: charger['chargePointID'],
                status: charger['status'],
              ));
            } else {
              var chargerPoint =
                  await getChargerPoint(charger['chargePointID']);

              chargerPoints.add(
                ChargerPoint.fromCharger(
                  chargerPointId: charger['chargePointID'],
                  chargers: [
                    Charger.fromCharger(
                      id: charger['chargerID'],
                      cost: chargerPoint.price,
                      chargerPointId: charger['chargePointID'],
                      status: charger['status'],
                    )
                  ],
                  coordinates:
                      LatLng(charger['location'][0], charger['location'][1]),
                  price: chargerPoint.price,
                  name: chargerPoint.name,
                ),
              );
            }
          }

          return chargerPoints;
        case 500:
          throw Exception(ErrorCodes.internalError);
        default:
          throw Exception(ErrorCodes.internalError);
      }
    } catch (e) {
      print(e);
    }
    return chargerPoints;
  }

  Future<ChargerPoint> getChargerPoint(int id) async {
    ChargerPoint chargerPoint = ChargerPoint();
    try {
      var response = await client.get(Uri.parse('$endPoint/chargePoints/$id'));
      if (response.statusCode == 200) {
        return ChargerPoint.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print(e);
    }

    return chargerPoint;
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
        throw Exception(ErrorCodes.notFound);
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
        throw Exception(ErrorCodes.notFound);
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
  Future<void> updateStatus(String status, int id) async {
    print("Status: " + status);
    print("Id: " + id.toString());
    await client
        .put(
          Uri.parse('$endPoint/chargers/$id'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'status': status,
          }),
        )
        .then((result) => {
              print("statusCode: " + result.statusCode.toString()),
              print("body: " + result.body.toString())
            });
  }

  Future<void> reserveCharger(int id) async {
    var response = await client.put(
      Uri.parse('$endPoint/reservations/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "connectorId": "1",
        "idTag": "1",
        "reservationId": "1",
        "parentIdTag": "1"
      }),
    );
    switch (response.statusCode) {
      case 404: // Not able to connect to charger
        // throw Exception("Statuscode: " + response.statusCode.toString());
        break;
      case 500: // Internal server error
        throw Exception(ErrorCodes.internalError);
    }
  }
}
