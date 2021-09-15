import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

class TopSheetViewModel extends BaseViewModel {
  String _topSheetText = "Text";
  bool connectingToCharger = true;
  bool chargeInProgress = false;
  BitmapDescriptor startChargingIcon = BitmapDescriptor.defaultMarker;
  var flexLogo = new Image.asset('/assets/images/smallFlexiChargeLogo.png');

  init() async {
    startChargingIcon = await _chargerStartedIcon;
    notifyListeners();
  }

  get _chargerStartedIcon => BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(25, 25)),
      '/assets/images/smallFlexiChargeLogo.png');

  String getTitleText() {
    return _topSheetText;
  }

  void changeTitleText(int state) {
    switch (state) {
      case 1:
        {
          _topSheetText = "Charging Started";
        }
        break;
      case 2:
        {
          _topSheetText = "Charging In Progress";
        }
        break;
      case 3:
        {
          _topSheetText = "Fully Charged";
        }
        break;
      case 4:
        {
          _topSheetText = "Charging Summary";
        }
        break;
      default:
        {
          _topSheetText = "";
        }
        break;
    }
    notifyListeners();
  }
}
