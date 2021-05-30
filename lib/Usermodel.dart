import 'dart:convert';

import 'dart:ffi';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
   String principal;
  String rate;
  String year;
  String interest;



  UserModel({
    this.principal,
    this.rate,
    this.year,
    this.interest
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    principal: json['principal'] ,
    rate: json['rate'] ,
    year:json['year'],
    interest: json['interest'],

  );

  Map<String, dynamic> toJson() => {
    "principal": principal,
    "rate": rate,
    "year": year,
    "interest":interest,
  };
}