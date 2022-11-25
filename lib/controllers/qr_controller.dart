import 'dart:developer';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../pages/dog_checking/check_in_profile.dart';
import '../pages/dog_checking/check_out_profile.dart';


class QrController extends GetxController{
  late Rx<QRViewController?> controller;
  Rxn<Barcode?> result= Rxn<Barcode?>();

  void checkPositionPage(String pageName) {
    if (result.value != null) {
      (pageName == "CheckIn") ? Get.off(CheckInProfile(code: result.value!.code,)):
          Get.off(CheckOutProfile(code: result.value!.code,));
      // WidgetsBinding.instance.addPostFrameCallback((_) async {
      //   await Navigator.pushReplacement(
      //       context, MaterialPageRoute(
      //       builder: (_) => CheckInProfile(code: result!.code)));
      // }) : WidgetsBinding.instance.addPostFrameCallback((_) async {
      //   await Navigator.pushReplacement(
      //       context, MaterialPageRoute(
      //       builder: (_) => CheckOutProfile(code: result!.code)));
      // });
    }
  }

  void flipCamera()async{
    await controller.value?.flipCamera();
  }
  void flashCamera()async{
    await controller.value?.toggleFlash();
  }
  void resumeCamera()async{
    await controller.value?.resumeCamera();
  }

   onQRViewCreated() {
    controller.value?.scannedDataStream.listen((scanData) {
      result.value =scanData;
    });
  }

  void onPermissionSet(QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      Get.snackbar('Alert', 'No permission');
    }
  }
}