import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Details/Planner.dart';
import 'Details/TimelineScreen.dart';
import 'Details/reportscreen.dart';

class PlanDetails extends StatefulWidget {
  final Map<String, String> planDetails;

  PlanDetails({required this.planDetails});

  @override
  _PlanDetailsState createState() => _PlanDetailsState();
}

class _PlanDetailsState extends State<PlanDetails> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Function to remove HTML tags
  String removeHtmlTags(String htmlString) {
    return htmlString.replaceAll(RegExp(r'<[^>]*>'), '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF333452),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Plan Details',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        elevation: 4,
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFFF8F9FA),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Plan Name Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              widget.planDetails['planName'] ?? '',
                              style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.star_border, color: Color(0xFFFFD700), size: 24),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  // Description Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          removeHtmlTags(widget.planDetails['timeFrame'] ?? ''),
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),

                  // Assign To Team Section with People Icon
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Assigned Team: ',
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                      ),
                      Icon(Icons.people, color: Colors.black87, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          widget.planDetails['teamsDropdown'] ?? 'No team assigned',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Color(0xFFC01562),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              labelStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 12),
              tabs: [
                Tab(text: 'Planner'),
                Tab(text: 'Timeline'),
                Tab(text: 'Report'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                PlannerScreen(),
                TimelineScreen(),
                ReportScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}