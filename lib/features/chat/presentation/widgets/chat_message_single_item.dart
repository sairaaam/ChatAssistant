import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_chatgpt_clone/features/chat/domain/entities/chat_message_entity.dart';
import 'package:flutter_chatgpt_clone/features/global/const/app_const.dart';
import 'package:flutter_chatgpt_clone/features/global/theme/style.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:share_plus/share_plus.dart';

class ChatMessageSingleItem extends StatelessWidget {
  final ChatMessageEntity chatMessage;
  const ChatMessageSingleItem({Key? key, required this.chatMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        SlideEffect(
          begin: Offset(0, 1),
          duration: Duration(milliseconds: 300),
        ),
      ],
      child: _chatMessageItem(context),
    );
  }

  Widget _chatMessageItem(BuildContext context) {
    if (chatMessage.messageId == ChatGptConst.AIBot &&
        chatMessage.promptResponse != null) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: MediaQuery.of(context).size.width * 0.07,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF2C2C34), // Updated background color
          borderRadius: BorderRadius.circular(15), // Rounded container
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset("assets/Lexilogo.png"),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      displayFullTextOnTap: true,
                      isRepeatingAnimation: false,
                      animatedTexts: [
                        TyperAnimatedText(
                          chatMessage.promptResponse!.trim(),
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 50),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (chatMessage.promptResponse != null) {
                        Clipboard.setData(
                          ClipboardData(text: chatMessage.promptResponse!),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Copied to clipboard')),
                        );
                      }
                    },
                    child: Icon(Icons.copy, size: 20, color: Colors.white70),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      if (chatMessage.promptResponse != null) {
                        Share.share(chatMessage.promptResponse!);
                      }
                    },
                    child: Icon(Icons.share, size: 20, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else if (chatMessage.queryPrompt != null) {
      return Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: MediaQuery.of(context).size.width * 0.07,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blueAccent, // User's icon background color
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  "U", // User's avatar initial
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(width: 15),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: MarkdownBody(
                  selectable: true,
                  data: chatMessage.queryPrompt!,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox
        .shrink(); // In case of missing data, return an empty widget.
  }
}
