import 'dart:convert';

import 'package:flexicharge/enums/error_codes.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:http/http.dart' as http;

class ChargerService {
  Future<Charger> getChargers() async {
    final response  = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    switch( response.statusCode ){
      case 200: 
        return Charger.fromJson(jsonDecode(response.body));
      default:
        throw Exception(ErrorCodes.internalError);
    }
  }

  Future<Charger> getChargerById(String id) async {
    final response  = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
    switch( response.statusCode ){
      case 200: 
        return Charger.fromJson(jsonDecode(response.body));
      default:
        throw Exception(ErrorCodes.internalError);

    }
    
  }
}
