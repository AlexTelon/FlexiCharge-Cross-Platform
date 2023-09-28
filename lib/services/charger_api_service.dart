import 'dart:convert';
import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/api.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

/// It makes requests to the API and returns the response
class ChargerApiService {
  http.Client client = new http.Client();
  var chargerPoint = new ChargerPoint();

  /// It makes a GET request to the API, and if the response is 200, it
  /// parses the response body as a list of dynamic objects, and then adds
  /// each object to a list of Charger objects
  ///
  /// Returns:
  ///   A list of Charger objects.
  Future<List<Charger>> getChargers() async {
    var chargers = <Charger>[];
    var response = await client.get(Uri.parse('${API.url}/chargers'));
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

  /// It gets all the chargers from the API and then gets the charger point
  /// for each charger and then adds the charger to the charger point
  ///
  /// Returns:
  ///   A list of ChargerPoints.
  Future<List<ChargerPoint>> getChargerPoints() async {
    List<ChargerPoint> chargerPoints = [];

    try {
      var response = await client.get(Uri.parse('${API.url}/chargers'));
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
                  coordinates: LatLng(charger['location'][0].toDouble(),
                      charger['location'][1].toDouble()),
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

  /// It makes a GET request to the API, and if the response is successful,
  /// it returns a ChargerPoint object
  ///
  /// Args:
  ///   id (int): The id of the charger point you want to get.
  ///
  /// Returns:
  ///   A ChargerPoint object.
  Future<ChargerPoint> getChargerPoint(int id) async {
    ChargerPoint chargerPoint = ChargerPoint();
    try {
      var response = await client.get(Uri.parse('${API.url}/chargePoints/$id'));
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
    var response = await client.get(Uri.parse('${API.url}/chargers/$id'));
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

  /// It makes a GET request to the server, and if the response is 200, it
  /// parses the response body into a  list of Charger objects, and returns
  /// the list
  ///
  /// Returns:
  ///   A list of chargers.
  Future<List<Charger>> getAllAvailableChargers() async {
    var chargers = <Charger>[];
    var response = await client.get(Uri.parse('${API.url}/chargers/available'));
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

  /// The function does not work yet...
  /// It takes a chargerPointId as a parameter, makes a GET request to the API,
  /// and returns a Charger object
  ///
  /// Args:
  ///   chargerPointId: The ID of the charger point you want to get the chargers for.
  ///
  /// Returns:
  ///   A Charger object.
  Future<Charger> getChargersByChargerPointId(chargerPointId) async {
    var response = await client.get(Uri.parse('${API.url}/chargers'));
    return Charger.fromJson(jsonDecode(response.body));
  }

  /// It takes a string and an integer as parameters, and then it makes a PUT
  /// request to the API with the string and integer as the body
  ///
  /// Args:
  ///   status (String): "available"
  ///   id (int): 1
  Future<void> updateStatus(String status, int id) async {
    print("Status: " + status);
    print("Id: " + id.toString());
    await client
        .put(
          Uri.parse('${API.url}/chargers/$id'),
          headers: API.defaultRequestHeaders,
          body: jsonEncode(<String, String>{
            'status': status,
          }),
        )
        .then((result) => {
              print("statusCode: " + result.statusCode.toString()),
              print("body: " + result.body.toString())
            });
  }

  /// It takes a chargerId as an argument, and then sends a PUT request to the
  /// server with the chargerId, userId, start and end time
  ///
  /// Args:
  ///   chargerId (int): The id of the charger you want to reserve
  Future<void> reserveCharger(int chargerId) async {
    var response = await client.put(
      Uri.parse('${API.url}/reservations'),
      headers: API.defaultRequestHeaders,
      body: jsonEncode(<String, dynamic>{
        "chargerId": chargerId,
        "userId": 1,
        "start": 200,
        "end": 300,
      }),
    );
    switch (response.statusCode) {
      case 400: // Not able to connect to charger
        throw Exception("Statuscode: " + response.statusCode.toString());
      case 404:
        throw Exception(ErrorCodes.notFound);
      case 500: // Internal server error
        throw Exception(ErrorCodes.internalError);
    }
  }
}
