import "package:flutter/material.dart";
import "package:serti_whatsapp_clone/sample_data.dart";
import "package:serti_whatsapp_clone/widgets/my_message_card.dart";
import "package:serti_whatsapp_clone/widgets/sender_message_card.dart";

class ChatList extends StatelessWidget {
  const ChatList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView.builder(
      itemCount: sampleMessages.length,
      itemBuilder: (BuildContext context, int index) => Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: sampleMessages[index]["isMe"] == true
              //! I SENT THIS MESSAGE
              ? MyMessageCard(
                  message: sampleMessages[index]["text"].toString(),
                  date: sampleMessages[index]["time"].toString())

              //! I RECEIVED THIS MESSAGE
              : SenderMessageCard(
                  message: sampleMessages[index]["text"].toString(),
                  date: sampleMessages[index]["time"].toString())));
}
