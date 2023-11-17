// class ModelDetails {
//   dynamic id;
//   dynamic name;
//   dynamic desc;
//   dynamic quantity;
//   dynamic price;
//   dynamic newPrice;
//   dynamic discount;
//   dynamic viewCount;
//   dynamic gender;
//   dynamic type;
//   dynamic season;
//   dynamic material;
//   dynamic brand;
//   dynamic category;
//   dynamic minimumOrderCount;
//   dynamic organization;
//   List<Size> size;
//   List<Variable> variables;
//   List<Price> prices;
//   dynamic rating;
//
//   ModelDetails({
//     this.id,
//     this.name,
//     this.desc,
//     this.quantity,
//     this.price,
//     this.newPrice,
//     this.discount,
//     this.viewCount,
//     this.gender,
//     this.type,
//     this.season,
//     this.material,
//     this.brand,
//     this.category,
//     this.minimumOrderCount,
//     this.organization,
//     required this.size,
//     required this.variables,
//     required this.prices,
//     this.rating,
//   });
//
//   factory ModelDetails.fromJson(Map<String, dynamic> json) => ModelDetails(
//         id: json["id"]??"",
//         name: json["name"]??"",
//         desc: json["desc"]??"",
//         quantity: json["quantity"]??"",
//         price: json["price"]??"",
//         newPrice: json["new_price"]??"",
//         discount: json["discount"]??"",
//         viewCount: json["view_count"]??"",
//         gender: json["gender"]??"",
//         type: json["type"]??"",
//         season: json["season"]??"",
//         material: json["material"]??"",
//         brand: json["brand"]??"",
//         category: json["category"]??"",
//         minimumOrderCount: json["minimum_order_count"]??"",
//         organization: json["organization"]??"",
//         size: List<Size>.from(json["size"].map((x) => Size.fromJson(x))),
//         variables: List<Variable>.from(
//             json["variables"].map((x) => Variable.fromJson(x))),
//         prices: List<Price>.from(json["prices"].map((x) => Price.fromJson(x))),
//         rating: json["rating"]??"",
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "desc": desc,
//         "quantity": quantity,
//         "price": price,
//         "new_price": newPrice,
//         "discount": discount,
//         "view_count": viewCount,
//         "gender": gender,
//         "type": type,
//         "season": season,
//         "material": material,
//         "brand": brand,
//         "category": category,
//         "minimum_order_count": minimumOrderCount,
//         "organization": organization,
//         "size": List<dynamic>.from(size.map((x) => x.toJson())),
//         "variables": List<dynamic>.from(variables.map((x) => x.toJson())),
//         "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
//         "rating": rating,
//       };
// }
//
// class Price {
//   dynamic id;
//   dynamic price;
//   dynamic quantity;
//
//   Price({
//     this.id,
//     this.price,
//     this.quantity,
//   });
//
//   factory Price.fromJson(Map<String, dynamic> json) => Price(
//         id: json["id"],
//         price: json["price"],
//         quantity: json["quantity"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "price": price,
//         "quantity": quantity,
//       };
// }
//
// class Size {
//   dynamic id;
//   dynamic name;
//
//   Size({
//     this.id,
//     this.name,
//   });
//
//   factory Size.fromJson(Map<String, dynamic> json) => Size(
//         id: json["id"],
//         name: json["name"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//       };
// }
//
// class Variable {
//   dynamic id;
//   dynamic color;
//   dynamic quantity;
//   dynamic isActive;
//   List<Media> media;
//
//   Variable({
//     this.id,
//     this.color,
//     this.quantity,
//     this.isActive,
//     required this.media,
//   });
//
//   factory Variable.fromJson(Map<String, dynamic> json) => Variable(
//         id: json["id"],
//         color: json["color"],
//         quantity: json["quantity"],
//         isActive: json["is_active"],
//         media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "color": color,
//         "quantity": quantity,
//         "is_active": isActive,
//         "media": List<dynamic>.from(media.map((x) => x.toJson())),
//       };
// }
//
// class Media {
//  dynamic  id;
//  dynamic  file;
//
//   Media({
//     required this.id,
//     required this.file,
//   });
//
//   factory Media.fromJson(Map<String, dynamic> json) => Media(
//         id: json["id"],
//         file: json["file"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "file": file,
//       };
// }

class ModelDetails {
  dynamic id;
  dynamic name;
  dynamic desc;
  dynamic quantity;
  dynamic price;
  dynamic newPrice;
  dynamic discount;
  dynamic gender;
  dynamic type;
  dynamic season;
  dynamic material;
  dynamic brand;
  dynamic category;
  dynamic organization;
  List<Variable> variables;
  List<dynamic> prices;
  dynamic rating;
  List<Size> size;

  ModelDetails({
     this.id,
     this.name,
     this.desc,
     this.quantity,
     this.price,
     this.newPrice,
     this.discount,
     this.gender,
     this.type,
     this.season,
     this.material,
     this.brand,
     this.category,
     this.organization,
    required this.variables,
    required this.prices,
     this.rating,
    required this.size,
  });

  factory ModelDetails.fromJson(Map<String, dynamic> json) => ModelDetails(
    id: json["id"],
    name: json["name"],
    desc: json["desc"],
    quantity: json["quantity"],
    price: json["price"],
    newPrice: json["new_price"],
    discount: json["discount"],
    gender: json["gender"],
    type: json["type"],
    season: json["season"],
    material: json["material"],
    brand: json["brand"],
    category: json["category"],
    organization: json["organization"],
    variables: List<Variable>.from(json["variables"].map((x) => Variable.fromJson(x))),
    prices: List<dynamic>.from(json["prices"].map((x) => x)),
    rating: json["rating"],
    size: List<Size>.from(json["size"].map((x) => Size.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "desc": desc,
    "quantity": quantity,
    "price": price,
    "new_price": newPrice,
    "discount": discount,
    "gender": gender,
    "type": type,
    "season": season,
    "material": material,
    "brand": brand,
    "category": category,
    "organization": organization,
    "variables": List<dynamic>.from(variables.map((x) => x.toJson())),
    "prices": List<dynamic>.from(prices.map((x) => x)),
    "rating": rating,
    "size": List<dynamic>.from(size.map((x) => x.toJson())),
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

class Variable {
  dynamic id;
  dynamic color;
  dynamic quantity;
  dynamic isActive;
  List<Media> media;

  Variable({
    required this.id,
    required this.color,
    required this.quantity,
    required this.isActive,
    required this.media,
  });

  factory Variable.fromJson(Map<String, dynamic> json) => Variable(
    id: json["id"],
    color: json["color"],
    quantity: json["quantity"],
    isActive: json["is_active"],
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color": color,
    "quantity": quantity,
    "is_active": isActive,
    "media": List<dynamic>.from(media.map((x) => x.toJson())),
  };
}

class Media {
  dynamic id;
  dynamic file;

  Media({
    required this.id,
    required this.file,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file": file,
  };
}
