import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_clone/features/global/theme/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final VoidCallback? onTap;
  final bool isRequestProcessing;
  final ValueChanged<String>? onSubmit; // New callback for Enter key

  const CustomTextField({
    Key? key,
    required this.textEditingController,
    this.onTap,
    required this.isRequestProcessing,
    this.onSubmit, // Accepting the callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 28, left: 150, right: 150),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: colorDarkGray,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          constraints: BoxConstraints(maxHeight: 90),
                          child: TextField(
                            style: TextStyle(fontSize: 14),
                            controller: textEditingController,
                            decoration: InputDecoration(
                              hintText: "Open AI prompt",
                              border: InputBorder.none,
                            ),
                            onSubmitted: (value) {
                              if (onSubmit != null) {
                                onSubmit!(value); // Call the onSubmit callback
                              }
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      isRequestProcessing
                          ? Container(
                              height: 40,
                              child: Image.asset("assets/loading_response.gif"),
                            )
                          : InkWell(
                              onTap: textEditingController.text.isEmpty
                                  ? null
                                  : onTap,
                              child: Icon(
                                FontAwesomeIcons.paperPlane,
                                color: textEditingController.text.isEmpty
                                    ? Colors.grey.withOpacity(.4)
                                    : Colors.grey,
                              ),
                            ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
