import 'package:dogs_park/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/data_bucket.dart';
import '../utils/networking.dart';
import 'package:dogs_park/resources/resource.dart';

class AuthenticationController extends GetxController {
  var employeePhoneNumber = RxString("");
  RxBool remember = false.obs;

  void setRemember() {
    remember.toggle();
  }
  void onTapForgotOrSignUp(){
    Get.snackbar(Strings.notification, Strings.contactAdmin);
  }


  Future<void> signInHandler(TextEditingController phoneController,
      TextEditingController passwordController) async {
    if (phoneController.text.isEmpty) {
      // ignore: use_build_context_synchronously
      Get.snackbar(Strings.notification, Strings.alertEnterPhoneNum);
    } else if (passwordController.text.isEmpty) {
      // ignore: use_build_context_synchronously
      Get.snackbar( Strings.notification, Strings.alertEnterPassword);
    } else {
      dynamic employeeData = await Networking.getInstance().isEmployee(
          phoneController.text,
          passwordController.text);
      if (employeeData == Strings.authenticationApiReturnNotExisted) {
        // ignore: use_build_context_synchronously
        Get.snackbar(Strings.notification,Strings.wrongPhoneNum);
      } else if (employeeData == Strings.apiWrongPass) {
        // ignore: use_build_context_synchronously
        Get.snackbar(Strings.notification,Strings.wrongPass);
      } else if (employeeData == Strings.success) {
        DataBucket.getInstance().setCodeUser(phoneController.text);
        SharedPreferences pref = await SharedPreferences.getInstance();
        if (remember.value) {
          pref.setString("employeePhoneNumber", phoneController.text);
        }
        // ignore: use_build_context_synchronously
        Get.off(AdminApp(codeUser: phoneController.text));
      }
    }
  }
}
