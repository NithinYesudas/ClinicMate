import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/message_model.dart';
import '../providers/chatProvider.dart';

import 'chat_bubble.dart';

class MessagesList extends StatelessWidget {
  const MessagesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final provider = Provider.of<ChatProvider>(context);
    final messages = provider.messages;

    return ListView.builder(
        padding: EdgeInsets.symmetric(
            horizontal: mediaQuery.width * .01,
            vertical: mediaQuery.height * .01),
        itemCount: messages.length,
        itemBuilder: (ctx, index) {
          final message = Message(
            role: messages[index].role,
            message: messages[index].message,
            time: messages[index].time,
          );

          return ChatBubble(message: message);
        });
  }
}