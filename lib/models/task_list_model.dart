import 'package:flutter/material.dart';

class TaskListModel {
  final String dogName;
  final String customer;
  final String package;
  final String staff;
  final DateTime checkIn;
  final String checkOut;
  final String packageTime;
  final String pickUp;
  final String pickUpAddress;
  final DateTime pickUpTime;
  final String driver;
  final Image image;

  TaskListModel(this.dogName, this.customer, this.package, this.staff,
      this.checkIn, this.checkOut, this.pickUp, this.packageTime, this.pickUpAddress, this.pickUpTime, this.driver, this.image);
}
final taskDataDemo = [
  TaskListModel('Tony', 'Nguyen Van Thanh', 'Pro', '0000000002', DateTime(2022,11,11,07,30), '15/11/2022 13:15', 'Yes', 'Full day', '202 Ly chinh thang thanh pho ho chi minh', DateTime.now(), 'Ha Thi Khanh Ly', Image.asset("images/golden2.jpg")),
  TaskListModel('Chopper', 'Nguyen Van Hien', 'Pro', '0000000002', DateTime.now(), '15/11/2022 13:15', 'No', 'Full day', '272 le duc tho thanh pho ho chi minh', DateTime.now(), 'Ha Thi Khanh Ly', Image.asset("images/golden2.jpg")),

  TaskListModel('Stark', 'Nguyen Thi Huong', 'Pro', '0000000002', DateTime(2022,11,11,15,30), '15/11/2022 13:15', 'Yes', 'Full day', '272 le duc tho', DateTime.now(), 'Ha Thi Khanh Ly', Image.asset("images/golden2.jpg"))
];
