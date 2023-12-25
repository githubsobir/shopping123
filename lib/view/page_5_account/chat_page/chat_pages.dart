import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/view/page_5_account/chat_page/chat_typing_body.dart';
import 'package:shopping/view/page_5_account/chat_page/controller_chat.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  ScrollController scrollController = ScrollController();

  scrollListener() async {
    if (scrollController.offset <= scrollController.position.maxScrollExtent &&
        scrollController.position.outOfRange) {
      scrollController.addListener(() {});
    }
  }

  @override
  initState() {
    scrollController = ScrollController(initialScrollOffset: 5.0)
      ..addListener(scrollListener);
    animateToLast();
    super.initState();
  }

  animateToLast() {
    debugPrint('scroll down');
    Future.delayed(const Duration(milliseconds: 350)).then((_) {
      try {
        scrollController
            .animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 350),
          curve: Curves.fastOutSlowIn,
        )
            .then((value) {
          scrollController.animateTo(
            scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
          );
        });
      } catch (e) {
        // print('error on scroll $e');
      }
    });
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  int listLength = 0;

  @override
  Widget build(BuildContext context) {
    final getDataChatUi = ref.watch(controllerChatList);
    log(getDataChatUi.listGetDataServer.length.toString());
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
          title: const Text("Biz bilan aloqa",
              style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: getDataChatUi.listGetDataServer.length,
                      itemBuilder: (context, index) {
                        if (getDataChatUi.listGetDataServer.length !=
                            listLength) {
                          animateToLast();
                          listLength = getDataChatUi.listGetDataServer.length;
                        }
                        return GestureDetector(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Row(
                              children: [
                                /// typing content
                                typingContent(
                                  ref: ref,
                                  context: context,
                                  index: 1,
                                  isSentByMe: getDataChatUi
                                              .listGetDataServer[index].align
                                              .toString() ==
                                          "L"
                                      ? true
                                      : false,
                                  audioUrl: getDataChatUi
                                      .listGetDataServer[index].url,
                                  timerAudio: getDataChatUi
                                      .listGetDataServer[index].timerAudio,
                                  timerBuffer: getDataChatUi
                                      .listGetDataServer[index].timerBuffer,
                                  duration: getDataChatUi
                                      .listGetDataServer[index].duration,
                                  createdAt: getDataChatUi
                                          .listGetDataServer[index].time ??
                                      "2022-01-01",
                                  // getDataChatUi.listGetDataServer[inxdex].time,
                                  text: getDataChatUi
                                      .listGetDataServer[index].text
                                      .toString(),
                                  chatIds: "1",
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Container(

                  margin: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                    bottom: 4,
                  ),
                  padding: const EdgeInsets.only(
                    right: 1,
                    left: 4,
                    bottom: 0,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade50),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(
                          controller: textEditingController,
                          keyboardType: TextInputType.text,
                          expands: false,
                          maxLines: null,
                          maxLength: 140,
                          decoration: const InputDecoration(

                              // filled: true,
                              //
                              // fillColor: Colors.transparent,
                              border: InputBorder.none,
                              counter: SizedBox.shrink()),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (textEditingController.text.trim().isNotEmpty) {
                            /// serverga ma'lumot yuborish
                            ref.read(controllerChatList.notifier).setMessage(
                                message: textEditingController.text);
                            textEditingController.clear();

                            /// listni oxirgisini ko'rsatish
                            // animateToLast();

                            /// o'zgartirish kontentini yopish
                            // ref
                            //     .watch(selectingEditText.notifier)
                            //     .state = false;
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade50),
                          child: const Center(
                              child: Icon(
                            Icons.send,
                            color: Colors.blue,
                          )),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
