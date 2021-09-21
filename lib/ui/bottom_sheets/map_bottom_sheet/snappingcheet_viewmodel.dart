import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class CustomSnappingSheetViewModel extends BaseViewModel {
  final _chargerAPI = locator<ChargerApiService>();
  final localData = locator<LocalData>();
  bool _isSwishActive = false;
  Charger _selectedCharger = Charger();

  String _chargerCode = '';
  List<Charger> chargers = [];
  List<Charger> get nearestLocation => localData.chargers;
  bool get isSwishActive => _isSwishActive;

  set isSwishActive(bool newState) {
    _isSwishActive = newState;
    notifyListeners();
  }

  Charger get selectedCharger => _selectedCharger;

  Color get wideButtonColor {
    if (selectedCharger.status == 1)
      return Color.fromRGBO(120, 189, 118, 1);
    else if (selectedCharger.status == 0)
      return Color.fromRGBO(239, 96, 72, 1);
    else
      return Color.fromRGBO(229, 229, 229, 1);
  }

  String get wideButtonText {
    if (selectedCharger.status == 1)
      return 'Begin Charging';
    else if (selectedCharger.status == 0)
      return 'Charger Occupied';
    else
      return 'Charger Not Identified';
  }

  set selectedCharger(Charger newCharger) {
    _selectedCharger = newCharger;
    notifyListeners();
  }

  void changWideget() {
    _selectedCharger = Charger();
    notifyListeners();
  }

  set chargerCode(String value) => _chargerCode = value;
  /* === Dummy Data ===  */
  // void getChargers() {
  //   chargers = localData.chargers
  //       .where(
  //         (charger) =>
  //             charger.id ==
  //             int.parse(
  //               _chargerCode,
  //             ),
  //       )
  //       .toList();
  //   notifyListeners();
  // }

  Future<List<Charger>> getChargers() => _chargerAPI.getChargers();

  Future<void> getChargerById(int id) async {
    selectedCharger = await _chargerAPI.getChargerById(id);
    notifyListeners();
  }

  Future<void> updateStatus(int status, int id, int chargePointID) async {
    await _chargerAPI.updateStatus(status, id, chargePointID);
    notifyListeners();
  }

  void getChargersFromNearest() {
    chargers = localData.chargers
        .where(
          (charger) => charger.id == selectedCharger.id,
        )
        .toList();
    notifyListeners();
  }
}
