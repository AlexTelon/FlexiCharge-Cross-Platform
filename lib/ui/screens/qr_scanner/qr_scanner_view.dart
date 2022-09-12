import 'dart:io';

import 'package:flexicharge/app/app.locator.dart';
import 'package:flexicharge/services/local_data.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked_services/stacked_services.dart';

class QrScannerView extends StatefulWidget {
  State<StatefulWidget> createState() => _QRViewState();
}

class _QRViewState extends State<QrScannerView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final _navigationService = locator<NavigationService>();
  final localData = locator<LocalData>();

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.green,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  Future<void> _onQRViewCreated(QRViewController controller) async {
    localData.qrCode = '';
    setState(() {
      this.controller = controller;
    });
    bool foundValid = false;
    // Listens for scanned data
    controller.scannedDataStream.listen((scanData) {
      //Prevents the qr-code from continuing to scan after we found a code
      if (!foundValid) {
        try {
          var code = scanData.code!.removeAllWhitespace
              .replaceAll(',', '')
              .replaceAll('[', '')
              .replaceAll(']', '')
              .replaceAll("'", '');
          if (code.length == 6) {
            int.parse(code);
            localData.qrCode = code;
            foundValid = true;
            _navigationService.back();
          }
        } catch (e) {}
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
