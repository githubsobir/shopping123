import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModelSignUp {
  String fullName;
  String phoneNumber;
  String password;
  String isActive;
  String fileImage;

  ModelSignUp({
    required this.fullName,
    required this.phoneNumber,
    required this.password,
    required this.isActive,
    required this.fileImage,
  });

  ModelSignUp copyWith({
    dynamic fullName,
    dynamic phoneNumber,
    dynamic password,
    dynamic isActive,
    dynamic fileImage,
  }) {
    return ModelSignUp(
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        isActive: isActive ?? this.isActive,
        fileImage: fileImage ?? this.fileImage);
  }

  factory ModelSignUp.fromJson(Map<String, dynamic> json) => ModelSignUp(
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        password: json["password"],
        isActive: json["isActive"],
        fileImage: json["fileImage"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "phoneNumber": phoneNumber,
        "password": password,
        "isActive": isActive,
        "fileImage": fileImage,
      };
}

class StateNotifierSignUp extends StateNotifier<ModelSignUp> {
  StateNotifierSignUp(super.state);
}


///
///
class ModelSignUpResponse {
  int id;
  String fullName;
  dynamic avatar;
  String phone;

  ModelSignUpResponse({
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.phone,
  });

  factory ModelSignUpResponse.fromJson(Map<String, dynamic> json) => ModelSignUpResponse(
    id: json["id"],
    fullName: json["full_name"],
    avatar: json["avatar"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "avatar": avatar,
    "phone": phone,
  };
}
