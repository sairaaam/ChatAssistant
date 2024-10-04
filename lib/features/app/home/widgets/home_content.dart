import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      // Adjust padding based on screen width
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth > 1000
            ? 200
            : screenWidth * 0.1, // 10% of screen width on smaller devices
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Limitations",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Text(
            "Lexi sometimes writes plausible-sounding but incorrect or nonsensical answers. Fixing this issue is challenging as training the model to be more cautious causes it to decline questions that it can answer correctly.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 15),
          Text(
            "Lexi is sensitive to tweaks to the input phrasing or attempting the same prompt multiple times. For example, given one phrasing of a question, the model can claim to not know the answer, but given a slight rephrase, can answer correctly.",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
