import 'package:flexicharge/ui/sheets/map_bottom_sheet/snappingcheet_viewmodel.dart';
import 'package:flexicharge/ui/widgets/charger_locations.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NearestChargers extends ViewModelWidget<CustomSnappingSheetViewModel> {
  const NearestChargers({required this.completer, Key? key}) : super(key: key);
  final Function(SheetResponse) completer;

  @override
  Widget build(context, model) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () => model.onlyPin = true,
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: ChargerLocations(
            chargerPoints: model.getSortedChargerPoints,
            onTap: (chargingPoint) {
              model.selectedChargerPoint = chargingPoint;
              model.isFirstView = false;
            },
          ),
        ),
      ],
    );
  }
}
