import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
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
    _selectedCharger = await _chargerAPI.getChargerById(id);
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
