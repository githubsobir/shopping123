class ModelProductList {
  dynamic count;
  dynamic next;
  dynamic previous;
  dynamic boolGetData;
  dynamic errorText;
  List<ResultProductList> results;

  ModelProductList({
    this.count,
    this.next,
    this.previous,
    this.boolGetData,
    this.errorText,
    required this.results,
  });

  ModelProductList copyWith({
    dynamic count,
    dynamic next,
    dynamic previous,
    dynamic boolGetData,
    dynamic errorText,
    required List<ResultProductList> results,
  }) {
    return ModelProductList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        boolGetData: boolGetData ?? this.boolGetData,
        errorText: errorText ?? this.errorText,
        results: results);
  }

  factory ModelProductList.fromJson(Map<String, dynamic> json) =>
      ModelProductList(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        boolGetData: json["boolGetData"],
        errorText: json["errorText"],
        results: List<ResultProductList>.from(
            json["results"].map((x) => ResultProductList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "boolGetData": boolGetData,
        "errorText": errorText,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultProductList {
  dynamic id;
  dynamic name;
  dynamic price;
  dynamic discount;
  dynamic newPrice;
  dynamic gender;
  dynamic type;
  dynamic season;
  dynamic material;
  List<int> size;
  dynamic brand;
  dynamic category;
  dynamic isFavorite;
  dynamic isCart;
  dynamic photo;
  dynamic rating;

  ResultProductList({
    this.id,
    this.name,
    this.price,
    this.discount,
    this.newPrice,
    this.gender,
    this.type,
    this.season,
    this.material,
    required this.size,
    this.brand,
    this.category,
    this.isFavorite,
    this.isCart,
    this.photo,
    this.rating,
  });

  factory ResultProductList.fromJson(Map<String, dynamic> json) =>
      ResultProductList(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        discount: json["discount"],
        newPrice: json["new_price"]?.toDouble(),
        gender: json["gender"],
        type: json["type"],
        season: json["season"],
        material: json["material"],
        size: List<int>.from(json["size"].map((x) => x)),
        brand: json["brand"],
        category: json["category"],
        isFavorite: json["is_favorite"],
        isCart: json["is_cart"],
        photo: json["photo"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "discount": discount,
        "new_price": newPrice,
        "gender": gender,
        "type": type,
        "season": season,
        "material": material,
        "size": List<dynamic>.from(size.map((x) => x)),
        "brand": brand,
        "category": category,
        "is_favorite": isFavorite,
        "is_cart": isCart,
        "photo": photo,
        "rating": rating,
      };
}

class Material {
  dynamic id;
  dynamic name;

  Material({
    this.id,
    this.name,
  });

  factory Material.fromJson(Map<String, dynamic> json) => Material(
        id: json["id"] ?? "",
        name: json["name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
