import 'package:flexicharge/models/charger.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargerPoint {
  int chargerPointId = -1;
  String location = "";
  LatLng coordinates = LatLng(0, 0);
  List<Charger> chargers = [];
  ChargerPoint();
  ChargerPoint.fromCharger({
    required this.chargerPointId,
    required this.location,
    required this.coordinates,
    required this.chargers,
  });

  ChargerPoint.fromJson(Map<String, dynamic> json) {
    var coordinatesList = (json['coordinates'] as String).split(',');
    //var coordinatesListFromMap =(json['location']['coordinates'] as List);
    chargerPointId = json['chargePointID'];
    location = json['location'];
    coordinates = LatLng(
      double.parse(coordinatesList[0]),
      double.parse(coordinatesList[1]),
    );
  }
}
