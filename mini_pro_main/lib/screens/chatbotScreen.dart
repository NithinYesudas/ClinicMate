
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../custom_colors.dart';
import '../providers/chatProvider.dart';
import '../widgets/message_list.dart';


class HealthCareBot extends StatelessWidget {
 HealthCareBot({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final provider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),


        elevation: 5,
        backgroundColor: CustomColors.lightAccent,
        title: Text(
          "ClinicMate",
          style: GoogleFonts.nunitoSans(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 22),
        ),
      ),
      body: Column(
        children: [
          const Expanded(child: MessagesList()),
          Container(

            height: mediaQuery.height * .1,
            padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * .01),
            child: Row(
              children: [
                SizedBox(
                  width: mediaQuery.width * .8,
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Ionicons.lock_closed_outline,
                          color: CustomColors.lightAccent,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 5),
                        hintText: "Message",
                        hintStyle: GoogleFonts.nunitoSans(
                            fontWeight: FontWeight.w600, color: Colors.black38),
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none)),
                  ),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.only(
                            left: 20, right: 15, bottom: 15, top: 15),
                        backgroundColor: CustomColors.lightAccent,
                        shape: const CircleBorder()),
                    onPressed: () {
                      provider.sendMessage(_controller.text);

                      _controller.clear();
                    },
                    child: const Icon(
                      Ionicons.send_sharp,
                      color: Colors.white,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}