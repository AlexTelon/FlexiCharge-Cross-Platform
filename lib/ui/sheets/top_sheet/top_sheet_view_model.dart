import 'dart:async';

import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/enums/event_type.dart';
import 'package:flexicharge/enums/top_sheet_strings.dart';
import 'package:flexicharge/models/transaction.dart';
import 'package:flexicharge/services/charger_api_service.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flexicharge/services/transaction_api_service.dart';
import 'package:stacked/stacked.dart';

/// It's a view model that is used to control the top sheet
class TopSheetViewModel extends BaseViewModel {
  final chargerApiService = locator<ChargerApiService>();
  final transactionApiService = locator<TransactionApiService>();
  final localData = locator<LocalData>();
  String topSheetText = TopSheetString.chargingStarted.name;
  int chargingState = 1;
  int topSheetState = 1;
  double topSheetSize = 0.3;
  String stopChargingButtonText = "";
  String expandButtonText = "";
  DateTime? fullychargedTime;
  String stopTime = '';
  Timer? timer;

  /// The function starts a stream listener that listens for changes in the
  /// battery level and charging status. It also starts a timer that increments
  /// the charging percentage every second
  init() {
    startStreamListener();

    changeChargingState(false);
  }

  /// The `chargingAddress` getter is returning the address of the charger.
  String get chargingAdress {
    var chargerPoint = localData.chargerPoints.firstWhere((element) => element
        .chargers
        .any((element) => element.id == transactionSession.connectorID));

    return chargerPoint.name;
  }

  /// Returns amount of seconds left until fully charged expressed as
  /// readable text
  String get timeUntilFullyCharged {
    var goal = 100;
    var percentage = transactionSession.currentChargePercentage;

    return '${(goal - percentage).toStringAsFixed(0)} seconds left';
  }

  /// It's a getter that returns the amount of kilowatt hours transferred.
  String get kilowattHours =>
      "${transactionSession.kwhTransferred} kWh transferred";

  int get currentChargePercentage => transactionSession.currentChargePercentage;

  /// It changes the state of the top sheet and notifies the listeners
  ///
  /// Args:
  ///   state: The state of the top sheet.
  void changeTopSheetState(state) {
    topSheetState = state;
    notifyListeners();
    changeTopSheetSize();
  }

  Transaction get transactionSession => localData.transactionSession;

  /// It changes the size of the top sheet based on the state of the top sheet
  void changeTopSheetSize() {
    switch (topSheetState) {
      case 1:
        {
          topSheetSize = 0.30;
        }
        break;
      case 2:
        {
          topSheetSize = 0.45;
        }
        break;
      case 3:
        {
          topSheetSize = 0.60;
        }
        break;
    }
    notifyListeners();
  }

  /// It's a function that is called every second to update the charging
  /// state of the app
  /// Args:
  ///   finishedCharging (bool): A boolean that determines whether the
  /// charging has finished or not.
  Future<void> changeChargingState(bool finishedCharging) async {
    if (finishedCharging) {
      print("Stopping timer...");
      //localData.timer.cancel();
      chargingState = 4;
      changeTopSheetState(3);
      try {
        Transaction stoppedChargingSession =
            await transactionApiService.stopCharging(9999); // hardcoded
        localData.transactionSession.updateFrom(stoppedChargingSession);
      } catch (error) {
        print("Could not stop charging");
      }
      chargerApiService.updateStatus("Available", localData.chargingCharger);
      localData.isButtonActive = true;
      localData.chargerPoints = await chargerApiService.getChargerPoints();
    } else {
      if (chargingState < 3) {
        chargingState += 1;
      } else {
        chargingState = 1;
        changeTopSheetState(1);
      }
    }

    notifyListeners();
    displayChargingState();
  }

  /// It takes an integer as an argument and based on the integer value,
  /// it changes the value of the variables that are used to display the text
  /// on the screen
  void displayChargingState() {
    switch (chargingState) {
      case 1:
        {
          topSheetText = TopSheetString.chargingStarted.name;
          chargingState = 1;
        }
        break;
      case 2:
        {
          topSheetText = TopSheetString.chargingInProgress.name;
          stopChargingButtonText = TopSheetString.stopCharging.name;
          expandButtonText = TopSheetString.pushToStopCharging.name;
          chargingState = 2;
        }
        break;
      case 3:
        {
          topSheetText = TopSheetString.fullyCharged.name;
          stopChargingButtonText = TopSheetString.disconnect.name;
          expandButtonText = TopSheetString.pushToDisconnect.name;
          chargingState = 3;
        }
        break;
      case 4:
        {
          topSheetText = TopSheetString.chargingSummary.name;
          chargingState = 4;
        }
        break;
      default:
        {
          topSheetText = "";
          chargingState = 1;
          topSheetState = 1;
          changeTopSheetSize();
        }
        break;
    }

    notifyListeners();
  }

  /// Listening to the stream and if the event is stopTimer, it will change
  /// the charging state to false and notify the listeners. If the event is
  /// showCharging, it will change the charging state to false.
  void startStreamListener() {
    localData.stream.listen((event) {
      if (event == EventType.stopTimer) {
        changeChargingState(false);
        stopTime = '${DateTime.now().hour}:${DateTime.now().minute} ';
        notifyListeners();
      } else if (event == EventType.showCharging) {
        changeChargingState(false);
      }
    });
  }

  /// The function `getChargingStopTime` takes an end timestamp and returns the time in hours and minutes,
  /// adjusted by 2 hours.
  ///
  /// Args:
  ///   endTimeStamp (int): The `endTimeStamp` parameter is a Unix timestamp representing the end time of
  /// a charging session.
  ///
  /// Returns:
  ///   a string representing the time when charging should stop.
  String getChargingStopTime(int endTimeStamp) {
    DateTime realTime =
        DateTime.fromMillisecondsSinceEpoch(endTimeStamp * 1000, isUtc: true);

    String timeNow =
        (realTime.hour + 2).toString() + ":" + (realTime.minute).toString();

    return timeNow;
  }

  /// The function calculates the duration between two timestamps in hours and minutes.
  ///
  /// Args:
  ///   startTimeStamp (int): The startTimeStamp parameter represents the starting time of an event or
  /// duration in seconds since the Unix epoch (January 1, 1970, 00:00:00 UTC).
  ///   endTimeStamp (int): The `endTimeStamp` parameter represents the end time of an event or duration
  /// in seconds since the Unix epoch (January 1, 1970).
  ///
  /// Returns:
  ///   a string that represents the duration between the start and end timestamps in the format "X hr Y
  /// min", where X is the number of hours and Y is the number of minutes.
  String getDuration(int startTimeStamp, int endTimeStamp) {
    DateTime startTime = startTimeStamp.parseUNIXTimestamp();
    DateTime endTime = endTimeStamp.parseUNIXTimestamp();

    Duration difference = endTime.difference(startTime);

    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);

    String totalDuration = '$hours hr ${minutes}min';
    return totalDuration;
  }
}

/// It's an extension method that is used to parse the time difference between
/// two dates.
extension TimeParser on int {
  DateTime parseUNIXTimestamp() {
    return DateTime.fromMillisecondsSinceEpoch(this * 1000, isUtc: true);
  }

  String parseTimeDiff() {
    var date = DateTime.fromMicrosecondsSinceEpoch(this);
    var now = DateTime.now();
    var duration = now.difference(date);
    var result = '';

    if (duration.inHours % 24 > 0) {
      result = result + (duration.inHours % 24).toString() + 'hr ';
    }
    if (duration.inMinutes % 60 > 0) {
      result = result + (duration.inMinutes % 60).toString() + 'min ';
    }

    return result + "until full";
  }
}
