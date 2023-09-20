class ModelForSignInParse {
  dynamic pk;
  dynamic token;

  ModelForSignInParse({
    required this.pk,
    required this.token,
  });

  factory ModelForSignInParse.fromJson(Map<String, dynamic> json) => ModelForSignInParse(
    pk: json["pk"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "pk": pk,
    "token": token,
  };
}
