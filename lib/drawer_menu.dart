import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerMenu extends StatefulWidget {
  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          '',
          style: GoogleFonts.nunito(
            fontSize: screenWidth * 0.06,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Color(0xFF333452),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Column(
          children: [
            Text(
              'Profile',
              style: GoogleFonts.poppins(
                color: Color(0xFF333452),
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAnimatedButton(
                          context,
                          'assets/images/House.png',
                          'Dashboard',
                          Colors.black,
                          '/dashboard',  // Use named route here
                          screenWidth,
                          screenHeight,
                        ),
                        _buildAnimatedButton(
                          context,
                          'assets/images/arrow.png',
                          'Strategy',
                          Colors.black,
                          '/home_strategy',  // Use named route here
                          screenWidth,
                          screenHeight,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAnimatedButton(
                          context,
                          'assets/images/plans.png',
                          'Plans and Teams',
                          Colors.black,
                          '/PlansandTeams',  // Use named route here
                          screenWidth,
                          screenHeight,
                        ),
                        _buildAnimatedButton(
                          context,
                          'assets/images/case.png',
                          'Tasks',
                          Colors.black,
                          '/tasks',  // Use named route here
                          screenWidth,
                          screenHeight,
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildAnimatedButton(
                          context,
                          'assets/images/ticks.png',
                          'Projects',
                          Colors.black,
                          '/projects',  // Use named route here
                          screenWidth,
                          screenHeight,
                        ),
                        _buildAnimatedButton(
                          context,
                          'assets/images/set.png',
                          'Settings',
                          Colors.black,
                          '/home_setting',  // Use named route here
                          screenWidth,
                          screenHeight,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedButton(
      BuildContext context,
      String imagePath,
      String label,
      Color color,
      String routeName,  // Change type to String
      double screenWidth,
      double screenHeight,
      ) {
    return _AnimatedButton(
      imagePath: imagePath,
      label: label,
      color: color,
      routeName: routeName,  // Pass the route name
      screenWidth: screenWidth,
      screenHeight: screenHeight,
    );
  }
}

class _AnimatedButton extends StatefulWidget {
  final String imagePath;
  final String label;
  final Color color;
  final String routeName;  // Change type to String
  final double screenWidth;
  final double screenHeight;

  const _AnimatedButton({
    required this.imagePath,
    required this.label,
    required this.color,
    required this.routeName,  // Pass the route name
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  __AnimatedButtonState createState() => __AnimatedButtonState();
}

class __AnimatedButtonState extends State<_AnimatedButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          isTapped = false;
        });
        Navigator.pushNamed(context, widget.routeName);  // Use named route for navigation
      },
      onTapCancel: () {
        setState(() {
          isTapped = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: widget.screenWidth * 0.36,
        height: widget.screenHeight * 0.1,
        decoration: BoxDecoration(
          color: isTapped ? Colors.purple.shade100 : Colors.white,
          border: Border.all(color: Colors.white, width: 2.0),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade500,
              offset: Offset(6, 6),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-6, -6),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          vertical: widget.screenHeight * 0.01,
          horizontal: widget.screenWidth * 0.06,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              widget.imagePath,
              width: widget.screenWidth * 0.07,
              height: widget.screenWidth * 0.07,
            ),
            SizedBox(height: widget.screenHeight * 0.01),
            Text(
              widget.label,
              style: GoogleFonts.poppins(
                fontSize: widget.screenWidth * 0.025,
                fontWeight: FontWeight.w500,
                color: widget.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
