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
  dynamic like;

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
     this.like,
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
    like: json["like"],
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
    "like": like,
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
