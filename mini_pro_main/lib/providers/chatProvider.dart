import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/message_model.dart';


class ChatProvider extends ChangeNotifier {
  final List<Message> _messages = [
    Message(
        message: "Hi, I'm ClinicMate's AI health specialist",
        role: "system",
        time: DateTime.now().toIso8601String()),
    Message(
        message: "Ask me any doubts you have about healthcare",
        role: "system",
        time: DateTime.now().toIso8601String()),
  ];

  List<Message> get messages => _messages;

  Future<void> sendMessage(String message) async {
    _messages.add(Message(
        message: message,
        role: "user",
        time: DateTime.now().toIso8601String()));
    notifyListeners();

    final url = Uri.parse("https://api.openai.com/v1/chat/completions");
    const header = {
      "Content-Type": "application/json",
      "Authorization": "Bearer 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"
    };
    List<Map<String, dynamic>> conversation = [
      {
        "role": "system",
        "content": "You are a health care specialist. answer the following questions accordingly and the answers should be short and concise to 1 or 2 sentences"
      },

      {
        "role": "assistant",
        "content":
        "okay I'll answer to the questions shortly without any other explanations"
      },
    ];

    for (var element in _messages) {
      if(element.role != "system"){
        conversation.add({"role": element.role, "content": element.message});
      }
    }
    final body = {
      "messages": conversation,
      "max_tokens": 100,
      "temperature": 0,
      "model": "gpt-3.5-turbo"
    };

    final response =
    await http.post(url, headers: header, body: json.encode(body));
    print(response.body);
    final Map<String, dynamic> result = json.decode(response.body);
    _messages.add(Message(
        message: result["choices"][0]['message']["content"],
        role: "assistant",
        time: DateTime.now().toIso8601String()));
    notifyListeners();
  }
}