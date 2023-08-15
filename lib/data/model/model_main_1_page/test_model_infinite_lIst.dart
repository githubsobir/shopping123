import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModelSavedQuestion {
  int status;
  DataSavedQuestion data;

  ModelSavedQuestion({
    required this.status,
    required this.data,
  });

  ModelSavedQuestion copyWiths({
    int? status2,
    DataSavedQuestion? data2,
  }) {
    return ModelSavedQuestion(status: status2 ?? status, data: data2 ?? data);
  }

  factory ModelSavedQuestion.fromJson(Map<String, dynamic> json) =>
      ModelSavedQuestion(
        status: json["status"],
        data: DataSavedQuestion.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class DataSavedQuestion {
  List<DatumSavedQuestion> data;
  Meta meta;

  DataSavedQuestion({
    required this.data,
    required this.meta,
  });

  factory DataSavedQuestion.fromJson(Map<String, dynamic> json) =>
      DataSavedQuestion(
        data: List<DatumSavedQuestion>.from(
            json["data"].map((x) => DatumSavedQuestion.fromJson(x))),
        meta: Meta.fromJson(json["_meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "_meta": meta.toJson(),
      };
}

class DatumSavedQuestion {
  dynamic id;
  dynamic bookNum;
  dynamic userAns;
  dynamic questionId;
  dynamic fanName;
  dynamic subjectCode;
  dynamic qsvg;
  dynamic textSvg;
  dynamic qpdf;
  dynamic textPdf;
  dynamic qimg;
  dynamic textImg;
  dynamic examId;
  dynamic userId;
  dynamic isFavorite;

  DatumSavedQuestion({
    required this.id,
    required this.bookNum,
    required this.userAns,
    required this.questionId,
    required this.fanName,
    required this.subjectCode,
    required this.qsvg,
    required this.textSvg,
    required this.qpdf,
    required this.textPdf,
    required this.qimg,
    required this.textImg,
    required this.examId,
    required this.userId,
    required this.isFavorite,
  });

  factory DatumSavedQuestion.fromJson(Map<String, dynamic> json) =>
      DatumSavedQuestion(
        id: json["id"],
        bookNum: json["book_num"],
        userAns: json["user_ans"],
        questionId: json["question_id"],
        fanName: json["fan_name"],
        subjectCode: json["subject_code"],
        qsvg: json["qsvg"],
        textSvg: json["text_svg"],
        qpdf: json["qpdf"],
        textPdf: json["text_pdf"],
        qimg: json["qimg"],
        textImg: json["text_img"],
        examId: json["exam_id"],
        userId: json["user_id"],
        isFavorite: json["is_favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "book_num": bookNum,
        "user_ans": userAns,
        "question_id": questionId,
        "fan_name": fanName,
        "subject_code": subjectCode,
        "qsvg": qsvg,
        "text_svg": textSvg,
        "qpdf": qpdf,
        "text_pdf": textPdf,
        "qimg": qimg,
        "text_img": textImg,
        "exam_id": examId,
        "user_id": userId,
        "is_favorite": isFavorite,
      };
}

class Meta {
  int totalCount;
  int pageCount;
  int currentPage;
  int perPage;

  Meta({
    required this.totalCount,
    required this.pageCount,
    required this.currentPage,
    required this.perPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        totalCount: json["totalCount"],
        pageCount: json["pageCount"],
        currentPage: json["currentPage"],
        perPage: json["perPage"],
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "pageCount": pageCount,
        "currentPage": currentPage,
        "perPage": perPage,
      };
}

class GetInfinitListRiverpod extends StateNotifier<List<ModelSavedQuestion>> {
  GetInfinitListRiverpod()
      : super([
          ModelSavedQuestion(
              status: 1,
              data: DataSavedQuestion(
                  data: [
                    DatumSavedQuestion(
                        id: 1,
                        bookNum: "",
                        userAns: "",
                        questionId: "",
                        fanName: "",
                        subjectCode: "",
                        qsvg: "",
                        textSvg: "",
                        qpdf: "",
                        textPdf: "",
                        qimg: "",
                        textImg: "",
                        examId: "",
                        userId: "",
                        isFavorite: "")
                  ],
                  meta: Meta(
                    totalCount: 1,
                    pageCount: 1,
                    currentPage: 1,
                    perPage: 1,
                  )))
        ]);

  void addListData(ModelSavedQuestion l) {
    state = [...state, l];
  }
}
