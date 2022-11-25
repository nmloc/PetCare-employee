import 'dart:convert';
import 'dart:typed_data';
import 'package:dogs_park/controllers/controller.dart';
import 'package:dogs_park/models/employee_information.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/dogs.dart';
import '../models/task_list_model.dart';

class DataBucket {
  static final DataBucket _instance = DataBucket._internal();

  DataBucket._internal();

  static DataBucket getInstance() => _instance;

  void setMetaDataEmpty() {
    setTaskList([]);
    setEmployeeInformation([]);
  }

  void setMetaData(dynamic rawData) {
    setTaskList(rawData[0]['TaskList']);
    setEmployeeInformation(rawData[0]['EmployeeInformation']);
  }

  List<EmployeeModel> _employeeInformation = [];

  List<EmployeeModel> getEmployeeInformation() => _employeeInformation;

  void setEmployeeInformation(List<dynamic> rawList) {
    _employeeInformation = [];

    for (var item in rawList) {
      var phoneNumber = (item['PhoneNumber'] == null)
          ? 'No data'
          : item['PhoneNumber'].toString();
      var fullName =
          (item['FullName'] == null) ? 'No data' : item['FullName'].toString();
      var position =
          (item['Position'] == null) ? 'No data' : item['Position'].toString();
      var dateOfBirth = (item['DateOfBirth'] == null)
          ? DateTime(0001, 01, 01, 00, 00, 00)
          : DateFormat("dd.MM.yyyy hh:mm:ss").parse(item['DateOfBirth']);
      bool isModerator = (item['IsModerator'] == null)
          ? false
          : (item['IsModerator'] == "Yes")
              ? true
              : false;

      _employeeInformation.add(EmployeeModel(
          phoneNumber, fullName, position, dateOfBirth, isModerator));
    }
  }

  String? codeStaff;

  getCodeUser() => codeStaff;

  void setCodeUser(String code) {
    codeStaff = code;
  }

  void resetCodeUser() {
    codeStaff = null;
  }

  ///Set all task into model
  List<TaskListModel> _taskList = [];

  List<TaskListModel> getTaskList() => _taskList;

  void setTaskList(List<dynamic> rawList) {
    _taskList = [];
    Image base64Image;
    for (var item in rawList) {
      var dogName = (item['Dog'] == null) ? 'No data' : item['Dog'].toString();
      var customer =
          (item['Customer'] == null) ? 'No data' : item['Customer'].toString();
      var package =
          (item['Package'] == null) ? 'No data' : item['Package'].toString();
      var staff =
          (item['Staff'] == null) ? 'No data' : item['Staff'].toString();

      if (item['Picture'] == null) {
        base64Image = Image.asset("images/golden2.jpg");
      } else {
        base64Image = Image.network(item['Picture']);
        //base64Image= base64ToImage(item['Picture'].toString().replaceAll('\r\n', ''));
      }

      var checkIn = (item['CheckIn'] == null)
          ? DateTime(0001, 01, 01, 00, 00, 00)
          : DateFormat("dd.MM.yyyy hh:mm:ss").parse(item['CheckIn']);
      var checkOut =
          (item['CheckOut'] == null) ? 'No data' : item['CheckOut'].toString();
      var packageTime = (item['PackageTime'] == null)
          ? 'No data'
          : item['PackageTime'].toString();
      var pickUp =
          (item['PickUp'] == null) ? 'No data' : item['PickUp'].toString();
      var pickUpAddress = (item['PickupInformation'] == null)
          ? "No data"
          : (item['PickupInformation'][0]['PickupAddress'] == null)
              ? 'No data'
              : item['PickupInformation'][0]['PickupAddress'].toString();
      var pickUpTime = (item['PickupInformation'] == null)
          ? DateTime(0001, 01, 01, 00, 00, 00)
          : (item['PickupInformation'][0]['PickupTime'] == null)
              ? DateTime(0001, 01, 01, 00, 00, 00)
              : DateFormat("dd.MM.yyyy hh:mm:ss")
                  .parse(item['PickupInformation'][0]['PickupTime']);
      var driver = (item['PickupInformation'] == null)
          ? "No data"
          : (item['PickupInformation'][0]['Driver'] == null)
              ? 'No data'
              : item['PickupInformation'][0]['Driver'].toString();
      _taskList.add(TaskListModel(
          dogName,
          customer,
          package,
          staff,
          checkIn,
          checkOut,
          pickUp,
          packageTime,
          pickUpAddress,
          pickUpTime,
          driver,
          base64Image));
    }
  }

  ///Filter task by day
  List<TaskListModel> _taskListByDay = [];

  List<TaskListModel> getTaskListByDay() => _taskListByDay;

  void setTaskListByDay(DateTime findDay) {
    _taskList = getTaskList();
    _taskListByDay = [];
    Image base64Image;
    for (var item in _taskList) {
      DateTime checkInData = item.checkIn;
      // DateTime now = DateTime.now();
      if (checkInData.year == findDay.year &&
          checkInData.month == findDay.month &&
          checkInData.day == findDay.day) {
        var dogName = item.dogName;
        var customer = item.customer;
        var package = item.package;
        var staff = item.staff;
        var checkIn = item.checkIn;
        var checkOut = item.checkOut;
        var packageTime = item.packageTime;
        var pickUp = item.pickUp;
        var pickUpAddress = item.pickUpAddress;
        var pickUpTime = item.pickUpTime;
        var driver = item.driver;
        base64Image = item.image;
        _taskListByDay.add(TaskListModel(
            dogName,
            customer,
            package,
            staff,
            checkIn,
            checkOut,
            pickUp,
            packageTime,
            pickUpAddress,
            pickUpTime,
            driver,
            base64Image));
      }
    }
  }

  /// Set Get List zone
  List<String> _listZone = [];

  List<String> getListZone() => _listZone;

  void setListZone(dynamic rawList) {
    _listZone = [];
    for (var item in rawList) {
      _listZone.add((item['Description'] == null)
          ? 'No data'
          : item['Description'].toString());
    }
  }

  /// set dog information when check in
  List<DogModel> _dogList = [];

  List<DogModel> getDogList() => _dogList;

  void setDogList(List<dynamic> rawList) {
    _dogList = [];
    Image base64Image;
    for (var item in rawList) {
      var dogCode =
          (item['Code'] == null) ? 'No data' : item['Code'].toString();
      var dogName =
          (item['DogName'] == null) ? 'No data' : item['DogName'].toString();
      var gender =
          (item['Gender'] == null) ? 'No data' : item['Gender'].toString();
      var weight =
          (item['Weight'] == null) ? 'No data' : item['Weight'].toString();
      var dogBreed =
          (item['DogBreed'] == null) ? 'No data' : item['DogBreed'].toString();

      if (item['Picture'] == null) {
        base64Image = Image.asset("images/golden2.jpg");
      } else {
        base64Image =
            base64ToImage(item['Picture'].toString().replaceAll('\r\n', ''));
      }
      var ownerPhone = (item['Owner'][0]['OwnerCode'] == null)
          ? 'No data'
          : item['Owner'][0]['OwnerCode'].toString();
      var dateOfBirth = (item['DateOfBirth'] == null)
          ? 'No data'
          : item['DateOfBirth'].toString();
      var ownerName = (item['Owner'][0]['OwnerDescription'] == null)
          ? 'No data'
          : item['Owner'][0]['OwnerDescription'].toString();
      var checkInTime = (item['Tracking'][0]['CheckIn'] == null)
          ? 'No data'
          : (item['Tracking'][0]['CheckIn']).toString();
      var checkInStatus = (item['Tracking'][0]['CheckInStatus'] == null)
          ? false
          : ((item['Tracking'][0]['CheckInStatus']).toString() == "Yes")
              ? true
              : false;
      var checkOutStatus = (item['Tracking'][0]['CheckOutStatus'] == null)
          ? false
          : ((item['Tracking'][0]['CheckOutStatus']).toString() == "Yes")
              ? true
              : false;
      var zone = (item['Tracking'][0]['Zone'] == null)
          ? 'No data'
          : (item['Tracking'][0]['Zone']).toString();
      _dogList.add(DogModel(
          dogCode,
          dogName,
          gender,
          base64Image,
          weight,
          dateOfBirth,
          ownerName,
          checkInTime,
          checkInStatus,
          checkOutStatus,
          zone,
          dogBreed,
          ownerPhone));
    }
  }
}

Image base64ToImage(String base64) {
  Uint8List bytes = const Base64Decoder().convert(base64);
  return Image.memory(bytes);
}
