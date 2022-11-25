import 'package:dogs_park/pages/authentication/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/data_bucket.dart';

class EmployeeController extends GetxController{

  Future<void> logOut() async {
    DataBucket.getInstance().resetCodeUser();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove("employeePhoneNumber");
    DataBucket.getInstance().setMetaDataEmpty();
   await Get.offAll(const LoginPage());
  }

}