class ModelAccountInformation {
  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  ModelAccountInformation({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory ModelAccountInformation.fromJson(Map<String, dynamic> json) => ModelAccountInformation(
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
  String question;
  String answer;
  int product;
  int client;

  Result({
    required this.id,
    required this.updatedAt,
    required this.createdAt,
    required this.question,
    required this.answer,
    required this.product,
    required this.client,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    question: json["question"],
    answer: json["answer"],
    product: json["product"],
    client: json["client"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "updated_at": updatedAt.toIso8601String(),
    "created_at": createdAt.toIso8601String(),
    "question": question,
    "answer": answer,
    "product": product,
    "client": client,
  };
}
