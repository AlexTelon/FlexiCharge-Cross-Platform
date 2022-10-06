import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class QrScannerViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final localData = locator<LocalData>();
  MobileScannerController cameraController = MobileScannerController();

  void init() {}

  void onDetectQrCode(Barcode barcode, MobileScannerArguments? args) {
    if (barcode.rawValue == null) {
      debugPrint('Failed to scan QR Code');
    } else {
      final String code = barcode.rawValue!;
      debugPrint('QR code found! $code');
      localData.qrCode = code;
      _navigationService.back();
    }
  }
}
