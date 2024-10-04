import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_clone/features/app/navigation_bar/chat_gpt_nav_bar.dart';
import 'package:flutter_chatgpt_clone/features/global/const/page_const.dart';
import 'package:flutter_chatgpt_clone/features/global/theme/style.dart';

class HomeHeaderWidget extends StatelessWidget {
  const HomeHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(color: colorDarkGreen),
      child: Column(
        children: [
          ChatGptNavBar(),
          SizedBox(height: 60),
          Center(
            // This Center widget ensures everything is aligned at the center of the page
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Move the logo above the text and center it
                Container(
                  height: 120, // Set desired height for the logo
                  child: Image.asset("assets/Lexilogo.png",
                      fit: BoxFit.contain), // Logo displayed here
                ),
                SizedBox(height: 20),
                Text(
                  "LEXI: Language model based Chatbot",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: colorPink,
                  ),
                  textAlign: TextAlign.center, // Center align the text
                ),
                SizedBox(height: 20),
                _bodyTextData(),
                SizedBox(height: 20),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, PageConst.conversationPage);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(color: colorPink),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "TRY Lexi",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 240, 239, 239)),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.call_made_outlined,
                          color: const Color.fromARGB(255, 240, 239, 239),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _bodyTextData() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text:
                "Lexi helps you get answers, find inspiration and be more productive. It is free to use and easy to try. Just ask and Lexi can help with writing essays and blogs, creating content, and debugging code, to operating human-like conversations, you can get many things done by asking Lexi.",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: colorPink,
            ),
          ),
        ],
      ),
    );
  }
}
