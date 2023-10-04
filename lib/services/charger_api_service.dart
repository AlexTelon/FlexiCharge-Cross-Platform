import 'dart:convert';
import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/enums/charger_status.dart';
import 'package:flexicharge/models/api.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/models/charger_point.dart';
import 'package:http/http.dart' as http;

/// This class contains the functions that handles HTTP requests to the API
/// endpoints, relating to both chargers and charger points, and returns the
/// appropriate data or exceptions based on the HTTP responses.
class ChargerApiService {
  http.Client client = new http.Client();

  /// It makes a `get` request to the API, and returns a list of [Charger] Objects
  /// on a successful response.
  ///
  /// * **Returns**:
  ///   * A list of [Charger] Objects.
  Future<List<Charger>> getChargers() async {
    try {
      // TODO: Why not explcitly set the type of response to http.Response?
      // Applies to all functions in this file.
      var response = await client.get(Uri.parse('${API.url}/chargers'));
      switch (response.statusCode) {
        case 200:
          List<Charger> chargers = [];
          List<dynamic> parsed = json.decode(response.body);
          for (var charger in parsed) {
            chargers.add(Charger.fromJson(charger));
          }
          return chargers;
        // TODO: Check if this is supposed to throw an exception or return an
        // empty list. Applicable to all 404 responses in this file.
        // TODO: Check if this 404 is intentional from the backend.
        case 404:
          throw Exception(ErrorCodes.notFound);
        // TODO: Check if there should be a 500 response from the backend.
        // Commented out as there is no 500 response from the backend as of now.
        /*
        case 500:
          throw Exception(ErrorCodes.internalError);
        */
        default:
          throw Exception(ErrorCodes.internalError);
      }
    } catch (e) {
      print('Error in charger_api_service, getChargers():\n\t${e.toString()}');
      throw Exception(ErrorCodes.internalError);
    }
  }

  /// It makes a `get` request to the API, and returns a list of [ChargerPoint]
  /// Objects on a successful response.
  ///
  /// * **Returns**:
  ///   * A list of [ChargerPoint] Objects.
  Future<List<ChargerPoint>> getChargerPoints() async {
    try {
      var response = await client.get(Uri.parse('${API.url}/chargePoints'));
      switch (response.statusCode) {
        case 200:
          List<ChargerPoint> chargerPoints = [];
          List<dynamic> parsed = json.decode(response.body);
          for (var chargerPoint in parsed) {
            chargerPoints.add(ChargerPoint.fromJson(chargerPoint));
          }
          return chargerPoints;
        // TODO: Check if this 404 is intentional from the backend.
        case 404:
          throw Exception(ErrorCodes.notFound);
        case 500:
          throw Exception(ErrorCodes.internalError);
        default:
          throw Exception(ErrorCodes.internalError);
      }
    } catch (e) {
      print(
          'Error in charger_api_service, getChargerPoints():\n\t${e.toString()}');
      throw Exception(ErrorCodes.internalError);
    }
  }

  /// It makes a `get` request to the API, and returns the [ChargerPoint]
  /// Object of the corresponding `id` on a successful response.
  ///
  /// * **Args**:
  ///   * `id` [int] : The ID of the charger point you want to get.
  ///
  /// * **Returns**:
  ///   * A [ChargerPoint] Object.
  // TODO: Check if this name should be getChargerPointById instead.
  Future<ChargerPoint> getChargerPoint(int id) async {
    try {
      var response = await client.get(Uri.parse('${API.url}/chargePoints/$id'));
      switch (response.statusCode) {
        case 200:
          return ChargerPoint.fromJson(json.decode(response.body));
        case 404:
          throw Exception(ErrorCodes.notFound);
        case 500:
          throw Exception(ErrorCodes.internalError);
        default:
          throw Exception(ErrorCodes.internalError);
      }
    } catch (e) {
      print(
          'Error in charger_api_service, getChargerPoint($id):\n\t${e.toString()}');
      throw Exception(ErrorCodes.internalError);
    }
  }

  /// It makes a `get` request to the API, and returns the [Charger]
  /// Object of the corresponding `id` on a successful response.
  ///
  /// * **Args**:
  ///   * `id` [int] : The ID of the charger you want to get.
  ///
  /// * **Returns**:
  ///   * A [Charger] Object.
  Future<Charger> getChargerById(int id) async {
    try {
      var response = await client.get(Uri.parse('${API.url}/chargers/$id'));
      switch (response.statusCode) {
        case 200:
          return Charger.fromJson(json.decode(response.body));
        case 404:
          // TODO: Check if this really this should throw an exception and not just return empty chargerPoint
          throw Exception(ErrorCodes.notFound);
        default:
          throw Exception(ErrorCodes.internalError);
      }
    } catch (e) {
      print(
          'Error in charger_api_service, getChargerById($id):\n\t${e.toString()}');
      throw Exception(ErrorCodes.internalError);
    }
  }

  /// It makes a `get` request to the API, and returns a list of all available
  /// [Charger] Objects on a successful response.
  ///
  /// * **Returns**:
  ///   * A list of [Charger] Objects.
  Future<List<Charger>> getAllAvailableChargers() async {
    try {
      var response =
          await client.get(Uri.parse('${API.url}/chargers/available'));
      switch (response.statusCode) {
        case 200:
          List<Charger> chargers = [];
          var parsed = json.decode(response.body) as List<dynamic>;
          for (var charger in parsed) {
            chargers.add(Charger.fromJson(charger));
          }
          return chargers;
        // TODO: Check if this 404 is intentional from the backend.
        case 404:
          throw Exception(ErrorCodes.notFound);
        // TODO: Check if there should be a 500 response from the backend.
        // Commented out as there is no 500 response from the backend as of now.
        /*
        case 500:
          throw Exception(ErrorCodes.internalError);
        */
        default:
          throw Exception(ErrorCodes.internalError);
      }
    } catch (e) {
      print(
          'Error in charger_api_service, getAllAvailableChargers():\n\t${e.toString()}');
      throw Exception(ErrorCodes.internalError);
    }
  }

  /// Used to update the status of a charger.
  /// It takes a `status` and an `id` as parameters, and then it makes a `put`
  /// request to the API with the `id`in the URL, and `status`in the body.
  ///
  /// * **Args**:
  ///   * `status` [String] : Either "Available" or "Unavailable"
  ///   * `id` [int] : The ID of the charger you want to update
  // TODO: Check if this name should be updateChargerStatus instead.
  Future<void> updateStatus(String status, int id) async {
    if (status != ChargerStatus.Available.name &&
        status != ChargerStatus.Unavailable.name) {
      throw Exception(ErrorCodes.badRequest);
    }
    try {
      var response = await client.put(
        Uri.parse('${API.url}/chargers/$id'),
        headers: API.defaultRequestHeaders,
        body: jsonEncode(<String, String>{
          'status': status,
        }),
      );
      switch (response.statusCode) {
        case 200:
          print('Status on Charger #$id updated successfully to $status');
          break;
        case 400:
          throw Exception(ErrorCodes.badRequest);
        case 404:
          throw Exception(ErrorCodes.notFound);
        // TODO: Check if there should be a 500 response from the backend.
        // Commented out as there is no 500 response from the backend as of now.
        /*
        case 500:
          throw Exception(ErrorCodes.internalError);
        */
        default:
          throw Exception(ErrorCodes.internalError);
      }
    } catch (e) {
      print(
          'Error in charger_api_service, updateStatus($status, $id):\n\t${e.toString()}');
      throw Exception(ErrorCodes.internalError);
    }
  }
}
