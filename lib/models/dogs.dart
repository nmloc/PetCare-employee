import 'package:flutter/material.dart';

class DogModel {
  const DogModel(
      this.code,
      this.dogName,
      this.gender,
      this.image,
      this.weight,
      this.dateOfBirth,
      this.ownerName,
      this.checkInTime,
      this.checkInStatus,
      this.checkOutStatus,
      this.zone, this.dogBreed, this.ownerPhone);

  final String code;
  final String dogName;
  final String gender;
  final Image image;
  final String weight;
  final String dateOfBirth;
  final String ownerName;
  final String checkInTime;
  final bool checkInStatus;
  final bool checkOutStatus;
  final String zone;
  final String dogBreed;
  final String ownerPhone;
}
