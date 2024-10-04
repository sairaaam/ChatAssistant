import 'package:flutter/material.dart';
import 'package:flutter_chatgpt_clone/features/global/provider/high_order_functions.dart';
import 'package:flutter_chatgpt_clone/features/global/custom_text_field/custom_text_field.dart'; // Import for CustomTextField

class ExampleWidget extends StatefulWidget {
  final OnMessageController onMessageController;

  const ExampleWidget({Key? key, required this.onMessageController})
      : super(key: key);

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen = screenWidth < 600;

    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal:
              isSmallScreen ? 10 : 40, // Adjust margin for small screens
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 140),
            // Image asset instead of text
            Image.asset(
              'assets/Lexilogo.png', // Path to your image asset
              width:
                  isSmallScreen ? 50 : 70, // Adjust size based on screen size
              height:
                  isSmallScreen ? 50 : 70, // Adjust size based on screen size
              fit: BoxFit.contain, // Adjust how the image fits into the space
            ),
            SizedBox(height: 60),

            // Horizontal scroll view for prompt cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildPromptCard(
                    icon: Icons.image,
                    text: 'Create an image for my presentation',
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildPromptCard(
                    icon: Icons.bar_chart,
                    text: 'Write a report based on my data',
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildPromptCard(
                    icon: Icons.edit,
                    text: 'Thank my interviewer',
                    isSmallScreen: isSmallScreen,
                  ),
                  _buildPromptCard(
                    icon: Icons.remove_red_eye,
                    text: 'Find the decade that a photo is from',
                    isSmallScreen: isSmallScreen,
                  ),
                ],
              ),
            ),

            // Additional space to separate the cards from the text field
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Helper method to build individual prompt cards
  Widget _buildPromptCard({
    required IconData icon,
    required String text,
    required bool isSmallScreen,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
            color: const Color.fromARGB(255, 197, 196, 196)), // Black border
      ),
      elevation: 2,
      color: Colors.white, // Set card background to white
      child: Container(
        padding: EdgeInsets.all(
            isSmallScreen ? 8 : 12), // Adjust padding for small screens
        width: 180, // Fixed width for all cards
        height: isSmallScreen ? 120 : 150, // Adjusted height for all cards
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceEvenly, // Evenly distribute space
          children: [
            Icon(
              icon,
              color: Colors.lightBlue, // Set icon color to light blue
              size: isSmallScreen ? 30 : 36, // Adjust icon size
            ),
            Flexible(
              // Wrap Text with Flexible
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black, // Set text color to black
                  fontSize: isSmallScreen ? 12 : 14, // Adjust text size
                ),
                textAlign: TextAlign.center,
                overflow: TextOverflow.visible, // Prevent overflow
              ),
            ),
          ],
        ),
      ),
    );
  }
}
