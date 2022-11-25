import 'package:dogs_park/main.dart';
import 'package:dogs_park/models/model.dart';
import 'package:dogs_park/utils/networking.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/notification_service.dart';
import '../utils/data_bucket.dart';
import 'package:dogs_park/resources/resource.dart';
class TaskListController extends GetxController{
  Rx<DateTime> selectedDate = Rx(DateTime.now());
  RxList<TaskListModel> taskListByDay =RxList();
  RxBool isMod = RxBool(false);

  RxList<String> listZone =RxList(['a','b','c']);
  RxString dropdownValue ='a'.obs;


  Future<void> getZone() async{
    dynamic dataListZone = await Networking.getInstance().getListZone();
    DataBucket.getInstance().setListZone(dataListZone['Listzone']);
    listZone.value = DataBucket.getInstance().getListZone();
    dropdownValue.value =listZone[0];
  }


  void isModHandle(){
    isMod.toggle();
  }


void onChangeDate(DateTime date){
   selectedDate.value= date;
   DataBucket.getInstance().setTaskListByDay(selectedDate.value);
   taskListByDay.value = DataBucket.getInstance().getTaskListByDay();

}
  void initDate(){
    DataBucket.getInstance().setTaskListByDay(selectedDate.value);
    taskListByDay.value = DataBucket.getInstance().getTaskListByDay();

  }

  Future updateEmployee()  async {
  final employeePhoneNumber = DataBucket.getInstance().getCodeUser();
  SharedPreferences pref =  await SharedPreferences.getInstance();
  var data = pref.get("employeePhoneNumber");
  String phone= (data==null)?employeePhoneNumber.toString():data.toString();
  dynamic taskListData= await Networking.getInstance().getTaskList(phone);
  if(taskListData!=false){
     DataBucket.getInstance().setMetaData(taskListData['Metadata']);
      initDate();
      //Get.snackbar('title','up');
     //return await Future.delayed(Duration(seconds: 2));
  }



   // await Get.off(()=>AdminApp(codeUser: phone));

}

  getColorAndNotificationByTime(DateTime checkInTime,int index) {
  DateTime currentTime = DateTime.now();
    DateTime checkIn = checkInTime;
    currentTime = DateTime(currentTime.year, currentTime.month, currentTime.day,
        currentTime.hour, currentTime.minute);
    checkIn = DateTime(
        checkIn.year, checkIn.month, checkIn.day, checkIn.hour, checkIn.minute);
    if ((currentTime.difference(checkIn).inHours) < 1) {
      if (currentTime.difference(currentTime).inHours == 0) {
        if (currentTime.difference(checkIn).inMinutes < -30) {
          if (currentTime.difference(checkIn).inMinutes < -60) {
            DateTime notificationTime = DateTime(checkIn.year, checkIn.month,
                checkIn.day, checkIn.hour - 1, checkIn.minute);
            NotificationService().showNotification(
                index,
                "Task alert",
                "You will have a task in an hours $index",
                notificationTime);
          }
          return ColorResources.availableTaskColor;
        } else if (currentTime.difference(checkIn).inMinutes >= -30 &&
            currentTime.difference(checkIn).inMinutes <= 0) {
          return ColorResources.pendingTaskColor;
        } else {
          return ColorResources.doneTaskColor;
        }
      } else if (currentTime.difference(currentTime).inHours == -1) {
        if (currentTime.difference(checkIn).inMinutes < -30) {
          return ColorResources.availableTaskColor;
        } else {
          return ColorResources.pendingTaskColor;
        }
      } else {
        return ColorResources.availableTaskColor;
      }
    } else {
      return ColorResources.doneTaskColor;
    }
  }



}