import 'package:dogs_park/models/dogs.dart';
import 'package:dogs_park/pages/home_screens/components/checking_status.dart';
import 'package:dogs_park/pages/home_screens/home_screen.dart';
import 'package:dogs_park/utils/data_bucket.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../resources/resource.dart';
import '../utils/networking.dart';

class CheckOutController extends GetxController {
  List<DogModel> listDogData =[];
  bool isMale = false;


  

  void setDogCheckOutData(dynamic data) {
    DataBucket.getInstance().setDogList(data['Dog']);
     listDogData = DataBucket.getInstance().getDogList();
    if (listDogData[0].gender == "Male") {
      isMale = true;
    } else {
      isMale = false;
    }
  }


  //Get duration
  duration() {
    DateTime checkOut =DateTime.now();
    DateTime checkIn = DateFormat("dd.MM.yyyy hh:mm:ss").parse(listDogData[0].checkInTime);
    checkIn = DateTime(checkIn.year, checkIn.month, checkIn.day, checkIn.hour, checkIn.minute);
    checkOut = DateTime(checkOut.year, checkOut.month, checkOut.day, checkOut.hour, checkOut.minute);
    if ((checkOut.difference(checkIn).inHours) < 1) {
      return "${checkOut.difference(checkIn).inMinutes} Minutes";
    } else if ((checkOut.difference(checkIn).inHours) > 1 &&
        ((checkOut.difference(checkIn).inHours) < 24)) {
      return "${checkOut.difference(checkIn).inHours} Hours ${checkOut.difference(checkIn).inMinutes - (checkOut.difference(checkIn).inHours * 60)} Minutes";
    } else if ((checkOut.difference(checkIn).inHours) > 24) {
      return "${checkOut.difference(checkIn).inDays} Day ${checkOut.difference(checkIn).inHours - (checkOut.difference(checkIn).inDays * 24)} Hours";
    }
  }

  void refuseButton(){
    Get.off(const HomeScreen());
  }
  Future<void> acceptButton() async {
    dynamic checkOutDocument =
    await Networking.getInstance().putTracking(listDogData[0].code);
    if (checkOutDocument.toString() == "SUCCESS") {
      Get.off(const CheckingStatusPage(status: "success", namePage: "Check out", message: "",));
    } else {
      Get.off( const CheckingStatusPage(status: "Failed", namePage: "Check out", message: "an error occurred when fetch data",));

    }
  }
}
