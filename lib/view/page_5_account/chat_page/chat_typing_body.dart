import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget typingContent({
  required WidgetRef ref,
  required BuildContext context,
  required int index,
  required bool isSentByMe,
  required dynamic audioUrl,
  required dynamic timerAudio,
  required dynamic timerBuffer,
  required dynamic duration,
  required dynamic createdAt,
  required dynamic text,
  required dynamic chatIds,
}) {
  return Container(
    width: MediaQuery.of(context).size.width,
    margin: const EdgeInsets.only(bottom: 2, top: 2),
    decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10)),
    child: Align(
      alignment: isSentByMe ? Alignment.centerLeft : Alignment.centerRight,
      child: audioUrl != null
          ? Container(
              width: MediaQuery.of(context).size.width * 0.7,
              margin: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 5),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  border: Border.all(
                      color: Colors.grey.shade700,
                      width: 1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(12),
                  )),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text.toString(),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      createdAt.toString(),
                      style:const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            )
          /// user type
          : Container(
              margin: EdgeInsets.only(
                  bottom: 8,
                  top: 8,
                  right: isSentByMe ? 20 : 4,
                  left: isSentByMe ? 20 : 30),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(isSentByMe ? 0 : 10),
                    bottomRight: Radius.circular(isSentByMe ? 10 : 0),
                    topLeft: const Radius.circular(10),
                    topRight: const Radius.circular(10),
                  ),
                  color: isSentByMe
                      ? Colors.grey.shade200
                      : Theme.of(context).colorScheme.inversePrimary),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(text.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                  Text(createdAt,
                      textAlign: TextAlign.end,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.w500))
                ],
              ),
            ),
    ),
  );
}
