import 'dart:developer';
import 'package:dogs_park/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../dog_checking/check_in_profile.dart';
import '../../dog_checking/check_out_profile.dart';
import '../../dog_checking/common_widget/button_page_checking.dart';

class QRViewExample extends StatefulWidget {
  final String pageName;
  const QRViewExample({Key? key, required this.pageName}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  check() {
    (widget.pageName=="CheckIn")?
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => CheckInProfile(code: result!.code)));
    }): WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => CheckOutProfile(code: result!.code)));
    });
  }

  @override
  Widget build(BuildContext context) {
    if (result != null) {
      check();
    }
    controller?.resumeCamera();

    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                      // 'Barcode Type: ${describeEnum(result!.format)}
                        'Data: ${result!.code}')
                  //Check_inProfile(code: result!.code)
                  else
                    const Text('Scan a code'),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: buttonChecking(
                          title: "Flash",
                          color: ColorResources.blackColor,
                          context: context,
                          onPressed: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: buttonChecking(
                          title: "Camera",
                          color: ColorResources.indigo,
                          context: context,
                          onPressed: () async {
                            await controller?.flipCamera();
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
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
          borderColor: ColorResources.redColor,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}