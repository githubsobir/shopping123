
class ModelBasketList {
  dynamic count;
  dynamic next;
  dynamic previous;
  dynamic errorText;
  dynamic internetStatePosition;
  List<ResultBasketList> results;

  ModelBasketList({
    this.count,
    this.next,
    this.previous,
    this.errorText,
    this.internetStatePosition,
    required this.results,
  });

  ModelBasketList copyWith(
      dynamic count1,
      dynamic next1,
      dynamic previous1,
      dynamic errorText1,
      dynamic internetStatePosition1,
      List<ResultBasketList> results1,
      ) {
    return ModelBasketList(
      count: count1 ?? count,
      next: next1 ?? next,
      previous: previous1 ?? previous,
      errorText: errorText1 ?? errorText,
      internetStatePosition: internetStatePosition1 ?? internetStatePosition,
      results: results1,
    );
  }

  factory ModelBasketList.fromJson(Map<String, dynamic> json) =>
      ModelBasketList(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        errorText: json["errorText"],
        results:
        List<ResultBasketList>.from(json["results"].map((x) => ResultBasketList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "errorText": errorText,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class ResultBasketList {
  dynamic id;
  Product product;
  Size size;
  dynamic material;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic quantity;

  ResultBasketList({
    this.id,
    required this.product,
    required this.size,
    this.material,
    this.updatedAt,
    this.createdAt,
    this.quantity,
  });

  factory ResultBasketList.fromJson(Map<String, dynamic> json) => ResultBasketList(
    id: json["id"],
    product: Product.fromJson(json["product"]),
    size: Size.fromJson(json["size"]),
    material: json["material"],
    updatedAt: json["updated_at"],
    createdAt: json["created_at"],
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "product": product.toJson(),
    "size": size.toJson(),
    "material": material,
    "updated_at": updatedAt,
    "created_at": createdAt,
    "quantity": quantity,
  };
}

class Product {
  dynamic id;
  dynamic name;
  dynamic price;
  dynamic photo;
  dynamic color1;

  Product({
    this.id,
    this.name,
    this.price,
    this.photo,
    this.color1,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    photo: json["photo"],
    color1: json["color"] ?? Color1(code1: "", id1: "", name1: ""),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "photo": photo,
    "color": color1,
  };
}

class Color1 {
  dynamic id1;
  dynamic code1;

  dynamic name1;

  Color1({
    this.id1,
    this.code1,
    this.name1,
  });

  factory Color1.fromJson(Map<String, dynamic> json) => Color1(
    id1: json["id"],
    code1: json["code"],
    name1: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id1,
    "code": code1,
    "name": name1,
  };
}

class Size {
  dynamic id;
  dynamic name;

  Size({
    this.id,
    this.name,
  });

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
