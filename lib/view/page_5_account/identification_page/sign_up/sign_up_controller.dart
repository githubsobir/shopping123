import 'dart:convert';
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/network/internet_5_account/internet_cleant_sign_up.dart';

final getDataSignUp = StateNotifierProvider<SignUpNotifier,
    ModelForSignUp>((ref) => SignUpNotifier());

class SignUpNotifier extends StateNotifier<ModelForSignUp> {

  SignUpNotifier()
      : super(ModelForSignUp(
            fullName: "",
            phone: "",
            password: "",
            isActive: "",
            fileImage: ""));
  InternetClientSignUp internetClientSignUp = InternetClientSignUp();

  Future getSignUp({required ModelForSignUp modelForSignUp}) async {
    try {
      log(jsonEncode(modelForSignUp).toString());
      String data = await internetClientSignUp.getISignUp(
          fullName: modelForSignUp.fullName,
          phoneNumber: modelForSignUp.phone,
          password: modelForSignUp.password,
          isActive: modelForSignUp.isActive,
          fileImage: modelForSignUp.fileImage);

      log(data.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}

class ModelForSignUp {
  String fullName;
  String phone;
  String password;
  String isActive;
  String fileImage;

  ModelForSignUp({
    required this.fullName,
    required this.phone,
    required this.password,
    required this.isActive,
    required this.fileImage,
  });

  ModelForSignUp copyWith(dynamic fullName, dynamic phone, dynamic password,
      dynamic isActive, dynamic fileImage) {
    return ModelForSignUp(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      fileImage: fileImage ?? this.fileImage,
    );
  }

  factory ModelForSignUp.fromJson(Map<String, dynamic> json) => ModelForSignUp(
        fullName: json["full_name"],
        phone: json["phone"],
        password: json["password"],
        isActive: json["is_active"],
        fileImage: json["file_image"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "phone": phone,
        "password": password,
        "is_active": isActive,
        "file_image": fileImage,
      };
}
