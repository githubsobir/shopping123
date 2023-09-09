class ModelSearch {
  dynamic minPrice;
  dynamic maxPrice;
  dynamic price;
  dynamic organization;
  dynamic brand;
  dynamic category;
  dynamic categorySlug;
  dynamic material;
  dynamic color;
  dynamic size;
  dynamic type;
  dynamic season;
  dynamic gender;
  dynamic search;
  dynamic ordering;
  dynamic page;
  dynamic pageSize;
  dynamic sessionId;
  dynamic lang;

  ModelSearch({
     this.minPrice,
     this.maxPrice,
     this.price,
     this.organization,
     this.brand,
     this.category,
     this.categorySlug,
     this.material,
     this.color,
     this.size,
     this.type,
     this.season,
     this.gender,
     this.search,
     this.ordering,
     this.page,
     this.pageSize,
     this.sessionId,
     this.lang,
  });

  factory ModelSearch.fromJson(Map<String, dynamic> json) => ModelSearch(
    minPrice: json["min_price"]??" ",
    maxPrice: json["max_price"]??" ",
    price: json["price"]??" ",
    organization: json["organization"]??" ",
    brand: json["brand"]??" ",
    category: json["category"]??" ",
    categorySlug: json["category_slug"]??" ",
    material: json["material"]??" ",
    color: json["color"]??" ",
    size: json["size"]??" ",
    type: json["type"]??" ",
    season: json["season"]??" ",
    gender: json["gender"]??" ",
    search: json["search"]??" ",
    ordering: json["ordering"]??" ",
    page: json["page"]??" ",
    pageSize: json["page_size"]??" ",
    sessionId: json["session_id"]??" ",
    lang: json["lang"]??" ",
  );

  Map<String, dynamic> toJson() => {
    "min_price": minPrice,
    "max_price": maxPrice,
    "price": price,
    "organization": organization,
    "brand": brand,
    "category": category,
    "category_slug": categorySlug,
    "material": material,
    "color": color,
    "size": size,
    "type": type,
    "season": season,
    "gender": gender,
    "search": search,
    "ordering": ordering,
    "page": page,
    "page_size": pageSize,
    "session_id": sessionId,
    "lang": lang,
  };
}