import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Model ro'yxatdan o'tishdagi holatni belgilash uchun
class ModelForSignUp {
  bool boolLoading;
  bool boolSuccess;
  bool boolError;

  ModelForSignUp({
    required this.boolLoading,
    required this.boolSuccess,
    required this.boolError,
  });

  ModelForSignUp copyWith(
      dynamic boolLoading, dynamic boolSuccess, dynamic boolError) {
    return ModelForSignUp(
        boolLoading: boolLoading,
        boolSuccess: boolSuccess,
        boolError: boolError);
  }

  factory ModelForSignUp.fromJson(Map<String, dynamic> json) => ModelForSignUp(
    boolLoading: json["boolLoading"],
    boolSuccess: json["boolSuccess"],
    boolError: json["boolError"],
  );

  Map<String, dynamic> toJson() => {
    "boolLoading": boolLoading,
    "boolSuccess": boolSuccess,
    "boolError": boolError
  };
}

/// Model serverga ma'lumot yurilayotgan user malumotlari
class ModelSignUpServer {
  String fullName;
  String phone;
  String password;
  String isActive;
  String fileImage;

  ModelSignUpServer({
    required this.fullName,
    required this.phone,
    required this.password,
    required this.isActive,
    required this.fileImage,
  });

  factory ModelSignUpServer.fromJson(Map<String, dynamic> json) =>
      ModelSignUpServer(
        fullName: json["fullName"],
        phone: json["phone"],
        password: json["password"],
        isActive: json["isActive"],
        fileImage: json["fileImage"],
      );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "phone": phone,
    "password": password,
    "isActive": isActive,
    "fileImage": fileImage,
  };
}

/// resgitratsiya qilingan foydalanuvchi modeli
class ModelResponseSignUp {
  int id;
  String fullName;
  dynamic avatar;
  String phone;

  ModelResponseSignUp({
    required this.id,
    required this.fullName,
    required this.avatar,
    required this.phone,
  });

  factory ModelResponseSignUp.fromJson(Map<String, dynamic> json) => ModelResponseSignUp(
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
