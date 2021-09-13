import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/models/charger.dart';
import 'package:flexicharge/services/chargers.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:stacked/stacked.dart';
class CustomSnappingSheetViewModel extends BaseViewModel{

  final chagerAPI = locator<ChargerService>();
  final localData = locator<LocalData>();

  String _chargerCode = '';
  List<Charger> chargers = [];

  set chargerCode(String value) => _chargerCode = value;

  void getChargers() {
    chargers = localData.chargers
        .where((charger) => charger.id == _chargerCode)
        .toList();
    notifyListeners();
  }
}