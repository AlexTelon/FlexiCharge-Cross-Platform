enum TopSheetString {
  chargingStarted,
  chargingInProgress,
  fullyCharged,
  chargingSummary,
  pushToStopCharging,
  pushToDisconnect,
  stopCharging,
  disconnect,
}

extension TopSheetTitleExtension on TopSheetString {
  String get name {
    switch (this) {
      case TopSheetString.chargingStarted:
        return "Charging Started";
      case TopSheetString.chargingInProgress:
        return "Charging In Progress";
      case TopSheetString.fullyCharged:
        return "Fully Charged";
      case TopSheetString.chargingSummary:
        return "Charging Summary";
      case TopSheetString.pushToStopCharging:
        return "Push to stop charging";
      case TopSheetString.pushToDisconnect:
        return "Push to disconnect";
      case TopSheetString.stopCharging:
        return "Stop Charging";
      case TopSheetString.disconnect:
        return "Disconnect";
      default:
        return "null";
    }
  }
}
