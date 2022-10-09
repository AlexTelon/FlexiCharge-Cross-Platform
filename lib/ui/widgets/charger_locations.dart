import 'package:flexicharge/models/charger_point.dart';
import 'package:flutter/material.dart';

import 'package:flexicharge/ui/widgets/nearest_station.dart';

/// It takes a list of maps, each map containing a ChargerPoint and a Location,
/// and displays a list of NearestStation widgets, each of which displays the
/// distance to the location and the number of available chargers at
/// the ChargerPoint
class ChargerLocations extends StatelessWidget {
  const ChargerLocations({
    required this.chargerPoints,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final Function(ChargerPoint)? onTap;
  final List<Map<String, dynamic>> chargerPoints;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: chargerPoints.map((chargerPoint) {
        return NearestStation(
          onTap:
              onTap != null ? () => onTap!(chargerPoint['chargerPoint']) : null,
          location: chargerPoint['location'],
          distance: chargerPoint['distance'],
          chargers: (chargerPoint['chargerPoint'] as ChargerPoint)
              .chargers
              .where((charger) => charger.status == "Available")
              .length,
        );
      }).toList(),
    );
  }
}
