import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Use font_awesome_flutter for icons

class FooterWidget extends StatelessWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;
    bool isSmallScreen =
        screenWidth < 600; // Customize based on your breakpoint

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Use Wrap for flexible layout instead of Row
          Wrap(
            spacing: 10, // Horizontal spacing
            runSpacing: 10, // Vertical spacing
            alignment: WrapAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      // Add navigation or actions
                    },
                    child: Text(
                      "Terms of Use",
                      style: TextStyle(fontSize: 18, color: Colors.blue),
                    ),
                  ),
                ],
              ),
              // Social icons row
              if (!isSmallScreen) ...[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(FontAwesomeIcons.twitter, size: 20),
                      onPressed: () {
                        // Twitter link
                      },
                      tooltip: 'Twitter',
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.youtube, size: 20),
                      onPressed: () {
                        // YouTube link
                      },
                      tooltip: 'YouTube',
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.github, size: 20),
                      onPressed: () {
                        // GitHub link
                      },
                      tooltip: 'GitHub',
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.facebookF, size: 20),
                      onPressed: () {
                        // Facebook link
                      },
                      tooltip: 'Facebook',
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.linkedin, size: 20),
                      onPressed: () {
                        // LinkedIn link
                      },
                      tooltip: 'LinkedIn',
                    ),
                    IconButton(
                      icon: Icon(FontAwesomeIcons.instagram, size: 20),
                      onPressed: () {
                        // Instagram link
                      },
                      tooltip: 'Instagram',
                    ),
                  ],
                ),
              ]
            ],
          ),
          if (isSmallScreen)
            Wrap(
              spacing: 20,
              children: [
                IconButton(
                  icon: Icon(FontAwesomeIcons.twitter, size: 20),
                  onPressed: () {
                    // Twitter link
                  },
                  tooltip: 'Twitter',
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.youtube, size: 20),
                  onPressed: () {
                    // YouTube link
                  },
                  tooltip: 'YouTube',
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.github, size: 20),
                  onPressed: () {
                    // GitHub link
                  },
                  tooltip: 'GitHub',
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.facebookF, size: 20),
                  onPressed: () {
                    // Facebook link
                  },
                  tooltip: 'Facebook',
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.linkedin, size: 20),
                  onPressed: () {
                    // LinkedIn link
                  },
                  tooltip: 'LinkedIn',
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.instagram, size: 20),
                  onPressed: () {
                    // Instagram link
                  },
                  tooltip: 'Instagram',
                ),
              ],
            ),
        ],
      ),
    );
  }
}
