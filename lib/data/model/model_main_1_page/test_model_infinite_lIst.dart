class ModelProductList {
  dynamic count;
  dynamic next;
  dynamic previous;
  List<ResultProductList> results;

  ModelProductList({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  ModelProductList copyWith({
    dynamic count,
    dynamic next,
    dynamic previous,
    required List<ResultProductList> results,
  }) {
    return ModelProductList(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results);
  }

  factory ModelProductList.fromJson(Map<String, dynamic> json) =>
      ModelProductList(
        count: json["count"]??"",
        next: json["next"]??"",
        previous: json["previous"]??"",
        results: List<ResultProductList>.from(
            json["results"].map((x) => ResultProductList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class ResultProductList {
  dynamic id;
  dynamic name;
  dynamic slug;
  dynamic price;
  dynamic discount;
  dynamic newPrice;
  dynamic gender;
  dynamic type;
  dynamic season;
  dynamic material;
  dynamic brand;
  dynamic category;
  dynamic isFavorite;
  dynamic photo;
  dynamic rating;

  ResultProductList({
     this.id,
     this.name,
     this.slug,
     this.price,
     this.discount,
     this.newPrice,
     this.gender,
     this.type,
     this.season,
     this.material,
     this.brand,
     this.category,
     this.isFavorite,
     this.photo,
     this.rating,
  });



  factory ResultProductList.fromJson(Map<String, dynamic> json) =>
      ResultProductList(
        id: json["id"]??"",
        name: json["name"]??"",
        slug: json["slug"]??"",
        price: json["price"]??0??"",
        discount: json["discount"]??0??"",
        newPrice: json["new_price"]??-1.00,
        gender: json["gender"]??"",
        type: json["type"]??"",
        season: json["season"]??"",
        material: json["material"]??"",
        brand: json["brand"]??"",
        category: json["category"]??"",
        isFavorite: json["is_favorite"] ?? false,
        photo: json["photo"] ?? "https://uzb.technostudio.uz/media/Banner/bann.jpg",
        rating: json["rating"]??-1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "price": price,
        "discount": discount,
        "new_price": newPrice,
        "gender": gender,
        "type": type,
        "season": season,
        "material": material,
        "brand": brand,
        "category": category,
        "is_favorite": isFavorite,
        "photo": photo,
        "rating": rating,
      };
}


