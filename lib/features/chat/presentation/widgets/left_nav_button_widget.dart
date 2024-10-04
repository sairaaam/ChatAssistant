import 'package:flutter/material.dart';

class LeftNavButtonWidget extends StatelessWidget {
  final IconData iconData;
  final String textData;
  final VoidCallback? onTap;
  final TextStyle? textStyle; // Add optional textStyle parameter

  const LeftNavButtonWidget({
    Key? key,
    required this.iconData,
    required this.textData,
    this.onTap,
    this.textStyle, // Initialize textStyle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Icon(iconData,
                color: textStyle?.color ?? Colors.white,
                size: 20), // Adjust icon color based on text style
            SizedBox(width: 10),
            Text(
              textData,
              style: textStyle ??
                  TextStyle(
                      color: Colors
                          .white), // Use the passed textStyle or fallback to default
            ),
          ],
        ),
      ),
    );
  }
}
