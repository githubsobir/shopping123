class ModelProductList {
  dynamic count;
  dynamic next;
  dynamic previous;
  List<ResultProductList> results;

  ModelProductList({
     this.count,
     this.next,
     this.previous,
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
  dynamic count;
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
  dynamic colorProduct;
  dynamic sizeProduct;

  ResultProductList({
     this.id,
    this.count,
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
     this.colorProduct,
     this.sizeProduct,

  });



  factory ResultProductList.fromJson(Map<String, dynamic> json) =>
      ResultProductList(
        id: json["id"]??"",
        count: json["count"]??0,
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
        colorProduct: json["colorProduct"]??-1,
        sizeProduct: json["sizeProduct"]??-1,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "count": count,
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
        "colorProduct": colorProduct,
        "sizeProduct": sizeProduct,
      };
}


