import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

/// This class is responsible for handling the camera and the QR code detection
class QrScannerViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final localData = locator<LocalData>();
  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  void init() {}

  /// When the user scans a QR code, the app will save the code to the local
  /// data and then navigate back to the previous screen
  ///
  /// Args:
  ///   barcode (Barcode): The barcode object that contains the rawValue, type,
  ///   and format of the barcode.
  ///   args (MobileScannerArguments): This is the arguments that you passed
  ///   to the scanner.
  void onDetectQrCode(Barcode barcode, MobileScannerArguments? args) async {
    if (barcode.rawValue == null) {
      debugPrint('Failed to scan QR Code');
    } else {
      final String code = barcode.rawValue!;
      debugPrint('QR code found! $code');
      localData.qrCode = code;
      notifyListeners();
      _navigationService.back();
    }
  }
}
