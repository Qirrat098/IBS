import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              title: Row(
                children: [
                  Text(
                    'Plan Elements',
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Content for Plan Elements',
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Row(
                children: [
                  Text(
                    'Strategy Pillars',
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Content for Strategy Pillars',
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Row(
                children: [
                  Text(
                    'Key Targets',
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Content for Key Targets',
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Row(
                children: [
                  Text(
                    'Plan Detail',
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Content for Plan Details',
                    style: GoogleFonts.inter(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
