import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/data/model/model_5_account/model_chat.dart';
import 'package:shopping/data/network/internet_5_account/internet_chat.dart';

final controllerChatList =
    StateNotifierProvider.autoDispose<ChatStateNotifier, ModelChatDataServer>(
        (ref) => ChatStateNotifier());

class ChatStateNotifier extends StateNotifier<ModelChatDataServer> {
  ChatStateNotifier()
      : super(ModelChatDataServer(
            listGetDataServer: [], boolGetDataInServer: false)) {
    getChatList();
  }

  InternetChatGetList internetChatGetList = InternetChatGetList();

  Future<ModelChatDataServer> getChatList() async {
    log("chat message");
    try {
      // String dataChat =
      //     await internetChatGetList.getChatList(message: "message", id: "");
    } catch (e) {
      log(e.toString());
    }
    // await Future.delayed(const Duration(seconds: 2));
    state = state.copyWith(fakeList, true);
    return state;
  }

  Future setMessage({required String message}) async {
    try {
      List<ModelWithChatId> listModelChat = state.listGetDataServer;
      listModelChat.add( ModelWithChatId(
        id: "1",
        text: message,
        url: null,
        align: "R",
        time: DateTime.now().toString().substring(0,19),
        duration: "",
        downloaded: "",
        timerAudio: "",
        timerBuffer: "",
        selectId: "",
        selectForDelete: "",
        dateForChatList: "",
      ),);
      state = state.copyWith(listModelChat, true);
      await Future.delayed(Duration(seconds: 2));
      List<ModelWithChatId> listModelChat2 = state.listGetDataServer;
      listModelChat2.add( ModelWithChatId(
        id: "1",
        text: "Operatordan javob xabar",
        url: null,
        align: "L",
        time: DateTime.now().toString().substring(0,19),
        duration: "",
        downloaded: "",
        timerAudio: "",
        timerBuffer: "",
        selectId: "",
        selectForDelete: "",
        dateForChatList: "",
      ),);
      state = state.copyWith(listModelChat, true);
    } catch (e) {
      log(e.toString());
    }
  }

  List<ModelWithChatId> fakeList = [
    ModelWithChatId(
      id: "1",
      text: "Assalomu aleykum sizning savollaringaga javob beramiz",
      url: null,
      align: "L",
      time: "2023:11:11",
      duration: "",
      downloaded: "",
      timerAudio: "",
      timerBuffer: "",
      selectId: "",
      selectForDelete: "",
      dateForChatList: "",
    ),
    ModelWithChatId(
      id: "1",
      text: "Sotuvchilar telefon nomerini kerak",
      url: null,
      align: "R",
      time: "2023:11:12",
      duration: "",
      downloaded: "",
      timerAudio: "",
      timerBuffer: "",
      selectId: "",
      selectForDelete: "",
      dateForChatList: "",
    ),

  ];
}
