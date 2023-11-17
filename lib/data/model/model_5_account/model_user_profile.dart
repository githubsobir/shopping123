// To parse this JSON data, do
//
//     final modelUserProfile = modelUserProfileFromJson(jsonString);

import 'dart:convert';

ModelUserProfile modelUserProfileFromJson(String str) => ModelUserProfile.fromJson(json.decode(str));

String modelUserProfileToJson(ModelUserProfile data) => json.encode(data.toJson());

class ModelUserProfile {
  dynamic id;
  dynamic fullName;
  dynamic avatar;
  dynamic phone;

  ModelUserProfile({
     this.id,
     this.fullName,
     this.avatar,
     this.phone,
  });

  factory ModelUserProfile.fromJson(Map<String, dynamic> json) => ModelUserProfile(
    id: json["id"]??"",
    fullName: json["full_name"]??"",
    avatar: json["avatar"]??"",
    phone: json["phone"]??"",
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "avatar": avatar,
    "phone": phone,
  };
}
