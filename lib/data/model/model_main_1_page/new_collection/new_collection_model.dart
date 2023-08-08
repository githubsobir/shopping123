class ModelMainNewCollections {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  ModelMainNewCollections({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ModelMainNewCollections.fromJson(Map<String, dynamic> json) => ModelMainNewCollections(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  DateTime updatedAt;
  DateTime createdAt;
  int quantity;
  int price;
  String gender;
  String? type;
  String? season;
  int? material;
  int brand;
  int category;
  dynamic organization;

  Result({
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.quantity,
    required this.price,
    required this.gender,
    this.type,
    this.season,
    this.material,
    required this.brand,
    required this.category,
    this.organization,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    quantity: json["quantity"],
    price: json["price"],
    gender: json["gender"],
    type: json["type"],
    season: json["season"],
    material: json["material"],
    brand: json["brand"],
    category: json["category"],
    organization: json["organization"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "quantity": quantity,
    "price": price,
    "gender": gender,
    "type": type,
    "season": season,
    "material": material,
    "brand": brand,
    "category": category,
    "organization": organization,
  };
}
