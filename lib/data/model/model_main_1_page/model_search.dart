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

  ModelSearch copyWith({
    dynamic minPrice,
    dynamic maxPrice,
    dynamic price,
    dynamic organization,
    dynamic brand,
    dynamic category,
    dynamic categorySlug,
    dynamic material,
    dynamic color,
    dynamic size,
    dynamic type,
    dynamic season,
    dynamic gender,
    dynamic search,
    dynamic ordering,
    dynamic page,
    dynamic pageSize,
    dynamic sessionId,
    dynamic lang,
  }) {
    return ModelSearch(
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      price: price ?? this.price,
      organization: organization ?? this.organization,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      categorySlug: categorySlug ?? this.categorySlug,
      material: material ?? this.material,
      color: color ?? this.color,
      size: size ?? this.size,
      type: type ?? this.type,
      season: season ?? this.season,
      gender: gender ?? this.gender,
      search: search ?? this.search,
      ordering: ordering ?? this.ordering,
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      sessionId: sessionId ?? this.sessionId,
      lang: lang ?? this.lang,
    );
  }

  factory ModelSearch.fromJson(Map<String, dynamic> json) => ModelSearch(
        minPrice: json["min_price"] ?? " ",
        maxPrice: json["max_price"] ?? " ",
        price: json["price"] ?? " ",
        organization: json["organization"] ?? " ",
        brand: json["brand"] ?? " ",
        category: json["category"] ?? " ",
        categorySlug: json["category_slug"] ?? " ",
        material: json["material"] ?? " ",
        color: json["color"] ?? " ",
        size: json["size"] ?? " ",
        type: json["type"] ?? " ",
        season: json["season"] ?? " ",
        gender: json["gender"] ?? " ",
        search: json["search"] ?? " ",
        ordering: json["ordering"] ?? " ",
        page: json["page"] ?? " ",
        pageSize: json["page_size"] ?? " ",
        sessionId: json["session_id"] ?? " ",
        lang: json["lang"] ?? " ",
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
