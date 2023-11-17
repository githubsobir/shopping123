class ModelChatDataServer {
  List<ModelWithChatId> listGetDataServer;
  bool boolGetDataInServer;

  ModelChatDataServer({required this.listGetDataServer, required this.boolGetDataInServer});

  ModelChatDataServer copyWith(List<ModelWithChatId> listGetDataServer1, bool boolGetDataInServer1) {
    return ModelChatDataServer(listGetDataServer: listGetDataServer1,
        boolGetDataInServer: boolGetDataInServer1
    );
  }

  factory ModelChatDataServer.fromJson(Map<String, dynamic> json) =>
      ModelChatDataServer(
        listGetDataServer: json["listGetDataServer"],
        boolGetDataInServer: json["boolGetDataInServer"],

      );

  Map<String, dynamic> toJson() => {
    "listGetDataServer": listGetDataServer,
    "boolGetDataInServer":boolGetDataInServer
  };
}

class ModelWithChatId {
  dynamic id;
  dynamic text;
  dynamic url;
  dynamic align;
  dynamic time;
  dynamic duration;
  dynamic downloaded;
  dynamic timerAudio;
  dynamic timerBuffer;
  dynamic selectId;
  dynamic selectForDelete;
  dynamic dateForChatList;



  ModelWithChatId({
    this.id,
    this.text,
    this.url,
    this.align,
    this.time,
    this.duration,
    this.downloaded,
    this.timerAudio,
    this.timerBuffer,
    this.selectId,
    this.selectForDelete,
    this.dateForChatList,
  });

  ModelWithChatId copyWith(
      dynamic id1,
      dynamic text1,
      dynamic url1,
      dynamic align1,
      dynamic time1,
      dynamic duration1,
      dynamic downloaded1,
      dynamic timerAudio1,
      dynamic timerBuffer1,
      dynamic selectId1,
      dynamic selectForDelete1,
      dynamic dateForChatList1,
      ) {
    return ModelWithChatId(
      id: id1 ?? id,
      text: text1 ?? text,
      url: url1 ?? url,
      align: align1 ?? align,
      time: time1 ?? time,
      duration: duration1 ?? duration,
      downloaded: downloaded1 ?? downloaded,
      timerAudio: timerAudio1 ?? timerAudio,
      timerBuffer: timerBuffer1 ?? timerBuffer,
      selectId: selectId1 ?? selectId,
      selectForDelete: selectForDelete1 ?? selectForDelete,
      dateForChatList: dateForChatList1 ?? dateForChatList,
    );
  }

  factory ModelWithChatId.fromJson(Map<String, dynamic> json) =>
      ModelWithChatId(
        id: json["id"],
        text: json["text"],
        url: json["url"],
        align: json["align"],
        time: json["time"],
        duration: json["duration"],
        downloaded: json["downloaded"],
        timerAudio: json["timerAudio"],
        timerBuffer: json["timerBuffer"],
        selectId: json["selectId"],
        selectForDelete: json["selectForDelete"],
        dateForChatList: json["dateForChatList"],
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "text": text,
    "url": url,
    "align": align,
    "time": time,
    "duration": duration,
    "downloaded": downloaded,
    "timerAudio": timerAudio,
    "timerBuffer": timerBuffer,
    "selectId": selectId,
    "selectForDelete": selectForDelete,
    "dateForChatList": dateForChatList,
  };
}
