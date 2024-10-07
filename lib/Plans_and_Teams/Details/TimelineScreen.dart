import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding around the content
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title Text
              Text(
                "Let's Start Planning",
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8), // Space between title and subtitle

              // Subtitle Text
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed diam nonummy nibh euismod",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20), // Space between text and image

              // Image
              Image.asset(
                'assets/images/man.jpeg', // Adjust this path to your image location
                width: 200, // Set width according to your design
                height: 200, // Set height according to your design
              ),
              SizedBox(height: 20), // Space between image and buttons

              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // First Button
                  ElevatedButton(
                    onPressed: () {
                      // Define the button's action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:Color(0xFFC01562), // Background color
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'Create new Focus Area',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 10), // Space between buttons

                  // Second Button
                  ElevatedButton(
                    onPressed: () {
                      // Define the button's action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal, // Background color
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: Text(
                      'Learn more',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
