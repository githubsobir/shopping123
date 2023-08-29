class ModelDetails {
  dynamic id;
  dynamic name;
  dynamic desc;
  dynamic quantity;
  dynamic price;
  dynamic discount;
  dynamic gender;
  dynamic type;
  dynamic season;
  dynamic material;
  dynamic brand;
  dynamic category;
  dynamic organization;
  List<Variable> variables;

  ModelDetails({
    required this.id,
    required this.name,
    required this.desc,
    required this.quantity,
    required this.price,
    required this.discount,
    required this.gender,
    required this.type,
    required this.season,
    required this.material,
    required this.brand,
    required this.category,
    required this.organization,
    required this.variables,
  });

  factory ModelDetails.fromJson(Map<String, dynamic> json) => ModelDetails(
    id: json["id"],
    name: json["name"],
    desc: json["desc"],
    quantity: json["quantity"],
    price: json["price"],
    discount: json["discount"],
    gender: json["gender"],
    type: json["type"],
    season: json["season"],
    material: json["material"],
    brand: json["brand"],
    category: json["category"],
    organization: json["organization"],
    variables: List<Variable>.from(json["variables"].map((x) => Variable.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "desc": desc,
    "quantity": quantity,
    "price": price,
    "discount": discount,
    "gender": gender,
    "type": type,
    "season": season,
    "material": material,
    "brand": brand,
    "category": category,
    "organization": organization,
    "variables": List<dynamic>.from(variables.map((x) => x.toJson())),
  };
}

class Variable {
  dynamic id;
  dynamic color;
  dynamic size;
  dynamic quantity;
  dynamic isActive;
  List<Media> media;

  Variable({
    required this.id,
    required this.color,
    required this.size,
    required this.quantity,
    required this.isActive,
    required this.media,
  });

  factory Variable.fromJson(Map<String, dynamic> json) => Variable(
    id: json["id"],
    color: json["color"],
    size: json["size"],
    quantity: json["quantity"],
    isActive: json["is_active"],
    media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color": color,
    "size": size,
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
