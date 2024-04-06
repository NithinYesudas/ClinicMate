import 'package:flutter/material.dart';

class Doctor {
  String name;
  String phoneNum;
  String address;
  double rate;
  int rating;
  String status;
  AssetImage profilePic;
  String specialization;

  Doctor(
    this.name,
    this.phoneNum,
    this.address,
    this.rate,
    this.rating,
    this.status,
    this.profilePic,
    this.specialization,
  );
}
