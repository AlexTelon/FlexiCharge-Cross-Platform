import 'package:flexicharge/theme.dart';
import 'package:flexicharge/ui/screens/qr_scanner/qr_scanner_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';

/// This class is a StatefulWidget that uses a ViewModelBuilder to create a
/// ViewModel and then uses that ViewModel to create a Scaffold with an AppBar
/// and a body. The body is a MobileScanner widget that uses the
/// cameraController from the ViewModel to create a QR scanner
class QrScannerView extends StatefulWidget {
  State<StatefulWidget> createState() => _QRViewState();
}

class _QRViewState extends State<QrScannerView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QrScannerViewModel>.reactive(
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: FlexiChargeTheme.green,
          title: const Text('Scan Charger QR'),
          actions: [
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: model.cameraController.torchState,
                builder: (context, state, child) {
                  switch (state as TorchState) {
                    case TorchState.off:
                      return const Icon(Icons.flash_off, color: Colors.grey);
                    case TorchState.on:
                      return const Icon(Icons.flash_on, color: Colors.yellow);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: () => model.cameraController.toggleTorch(),
            ),
            IconButton(
              color: Colors.white,
              icon: ValueListenableBuilder(
                valueListenable: model.cameraController.cameraFacingState,
                builder: (context, state, child) {
                  switch (state as CameraFacing) {
                    case CameraFacing.front:
                      return const Icon(Icons.camera_front);
                    case CameraFacing.back:
                      return const Icon(Icons.camera_rear);
                  }
                },
              ),
              iconSize: 32.0,
              onPressed: model.cameraController.switchCamera,
            ),
          ],
        ),
        body: MobileScanner(
            allowDuplicates: false,
            controller: model.cameraController,
            onDetect: model.onDetectQrCode),
      ),
      viewModelBuilder: () => QrScannerViewModel(),
    );
  }
}
