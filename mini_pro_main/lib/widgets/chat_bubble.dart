

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom_colors.dart';
import '../models/message_model.dart';




class ChatBubble extends StatelessWidget {
  ChatBubble({required this.message, Key? key}) : super(key: key);
  final Message message;


  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isCurrentUser?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.all(mediaQuery.height*.01),
          padding: EdgeInsets.symmetric(horizontal:mediaQuery.width*.03,vertical: mediaQuery.height*.01),
          alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          decoration: BoxDecoration(
              color: isCurrentUser?CustomColors.lightAccent:Colors.black45,
              borderRadius: isCurrentUser
                  ? const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              )
                  : const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: mediaQuery.width * .6,
            ),
            child: Text(
              message.message,

              maxLines: null,
              style: GoogleFonts.nunitoSans(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  bool  get isCurrentUser  {
    return message.role == "user";
  }
}