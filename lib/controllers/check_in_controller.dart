import 'dart:convert';
import 'package:dogs_park/models/dogs.dart';
import 'package:dogs_park/pages/home_screens/components/checking_status.dart';
import 'package:dogs_park/pages/home_screens/home_screen.dart';
import 'package:dogs_park/utils/data_bucket.dart';
import 'package:get/get.dart';
import '../resources/resource.dart';
import '../utils/networking.dart';

class CheckInController extends GetxController {
  List<DogModel> listDogData =[];
  bool isMale = false;

  RxList<String> listZone = RxList();
  RxString dropdownValue =''.obs;

  Future<void> getZone() async{
    dynamic dataListZone = await Networking.getInstance().getListZone();
     DataBucket.getInstance().setListZone(dataListZone['ListZone']);
     listZone.value = DataBucket.getInstance().getListZone();
    dropdownValue.value =listZone[0];
  }


  

  void setDogCheckInData(dynamic data) {
    DataBucket.getInstance().setDogList(data['Dog']);
     listDogData = DataBucket.getInstance().getDogList();
    if (listDogData[0].gender == "Male") {
      isMale = true;
    } else {
      isMale = false;
    }
  }
  void setDropDownList(String newValue){
    dropdownValue.value = newValue;
  }
  void refuseButton(){
    Get.off(const HomeScreen());
  }
  Future<void> acceptButton() async {
    Map body = {
      'PhoneNumber': listDogData[0].ownerPhone,
      'DogCode': listDogData[0].code,
      'Zone': dropdownValue.value,
    };
    String stringJson = json.encode(body);

    dynamic createDocument = await Networking.getInstance().postCheckInDocument(stringJson);
    if (createDocument.toString() == "SUCCESS") {
      Get.off(const CheckingStatusPage(status: Strings.success, namePage: Strings.checkIn, message: '',));
    } else {
      Get.off(const CheckingStatusPage(status: Strings.failed, namePage: Strings.checkIn, message: Strings.anErrorFetchData,));
    }
  }
}
