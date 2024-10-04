import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_clone/features/app/navigation_bar/nav_button.dart';
import 'package:flutter_chatgpt_clone/features/global/theme/style.dart';

class ChatGptNavBar extends StatelessWidget {
  const ChatGptNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 100,
            child: Image.asset(
              "assets/lexihome.png",
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                NavButton(title: "APIS", onTap: () {}),
                SizedBox(
                    width: screenWidth < 600
                        ? 10
                        : 25), // Adjust space based on screen size
                NavButton(title: "RESEARCH", onTap: () {}),
                SizedBox(width: screenWidth < 600 ? 10 : 25),
                NavButton(title: "BLOG", onTap: () {}),
                SizedBox(width: screenWidth < 600 ? 10 : 25),
                NavButton(title: "ABOUT", onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
