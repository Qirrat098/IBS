import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:html/parser.dart' as html_parser;

import 'Create_Onepage_Dialogue.dart';
import 'Create_Plan_Dialog.dart';

class AllPlansTab extends StatefulWidget {
  @override
  _AllPlansTabState createState() => _AllPlansTabState();
}

class _AllPlansTabState extends State<AllPlansTab> {
  bool _isIconClicked = false;
  bool displayClassList = false;
  TextEditingController controller = TextEditingController();
  TextEditingController strategyController = TextEditingController();
  TextEditingController teamsController = TextEditingController();

  String dropdownValue1 = 'Nothing Selected';
  String dropdownValue2 = 'Nothing Selected';

  List<Map<String, String>> plans = [];
  List<String> strategies = [];
  List<String> teams = [];

  void _handleIconClick() {
    setState(() {
      _isIconClicked = true;
    });

    Timer(Duration(seconds: 1), () {
      setState(() {
        _isIconClicked = false;
      });
    });
  }

  void _handleItemSelection(String selectedItem) {
    setState(() {
      controller.text = selectedItem;
      displayClassList = false;
    });
  }

  void _showCreatePlanDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: CreatePlanDialog(
            onCreatePlan: (planName, teamName, assignToPlan, description, strategy, strategyPillar, updatedTeams, timeFrame) {
              final descriptionPlainText = html_parser.parse(description).body?.text ?? "";
              setState(() {
                plans.add({
                  'teamName': teamName,
                  'planName': planName,
                  'assignToPlan': assignToPlan,
                  'description': descriptionPlainText,
                  'strategy': strategy,
                  'strategyPillar': strategyPillar,
                  'timeFrame': timeFrame,
                });
                strategies.add(strategy);
                teams.clear();
                teams.addAll(updatedTeams); // Update teams list
              });
            },
            strategies: strategies,
            teams: teams,
          ),
        );
      },
    );
  }

  void _editPlan(int index) {
    // Implement edit logic here
  }

  void _removePlan(int index) {
    setState(() {
      plans.removeAt(index);
    });
  }

  void _showPlanOptions(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit'),
              onTap: () {
                Navigator.pop(context);
                _editPlan(index);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                _removePlan(index);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Add Floating Action Button at the bottom right
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePlanDialog,
        backgroundColor: Color(0xFFC01562),
        child: Icon(Icons.add, size: 30, color: Colors.white), // Adjust the icon size if needed
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Search bar
              Center(
                child: Container(
                  height: 35,
                  width: 310,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey ,
                      fontSize: 14, fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.symmetric(vertical: 4 , horizontal: 0),
                      prefixIcon: GestureDetector(
                        onTap: _handleIconClick,
                        child: Icon(
                          Icons.search,
                          size: 20,
                          color: _isIconClicked ? Colors.blue : Colors.grey,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          color: Color(0xFFE7E8E8),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          color: Color(0xFFE7E8E8),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Center(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Type Dropdown
                      _buildStyledDropdownButton(
                        dropdownValue1,
                            (newValue) {
                          setState(() {
                            dropdownValue1 = newValue!;
                          });
                        },
                        ['Nothing Selected', 'All', 'Project Portfolio', 'Operational', 'Functional', 'Programmatic'],
                      ),
                      SizedBox(width: 12),
                      // Time Frame Dropdown
                      _buildStyledDropdownButton(
                        dropdownValue2,
                            (newValue) {
                          setState(() {
                            dropdownValue2 = newValue!;
                          });
                        },
                        ['Nothing Selected', 'A', 'B', 'C', 'D'],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // DataTable for displaying plans
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.5), // Black border with 2 width
                    borderRadius: BorderRadius.circular(0), // Optional: Add rounded corners if needed
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0), // Match the container's border radius
                    child: Container(
                      color: Colors.grey[100], // Background color of the container
                      child: CustomPaint(
                        painter: TableBorderPainter(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.grey[300]!,
                        ),
                        child: DataTable(
                          // Setting overall table properties
                          columnSpacing: 35,
                          headingRowHeight: 45,
                          headingTextStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                          dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
                          headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[100]!),
                          columns: <DataColumn>[
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Parent Plan', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Plan Name', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Type', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Strategy', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Description', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Strategy Pillars', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Access', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                          ],
                          rows: plans.map((plan) {
                            return DataRow(cells: <DataCell>[
                              DataCell(Text(plan['planName'] ?? '--')),
                              DataCell(Text(plan['teamName'] ?? '--')),
                              DataCell(Text(plan['assignToPlan'] ?? '--')),
                              DataCell(Text(plan['strategy'] ?? '--')),
                              DataCell(Text(plan['description'] ?? '--')),
                              DataCell(Text(plan['strategyPillar'] ?? '--')),
                              DataCell(
                                IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {
                                    _showPlanOptions(plans.indexOf(plan));
                                  },
                                ),
                              ),
                            ]);
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStyledDropdownButton(String currentValue, ValueChanged<String?> onChanged, List<String> items) {
    return Container(
      width: 150,
      height: 35,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFE7E8E8),
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(0),
        color: Colors.white,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentValue,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.black),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
class TableBorderPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final Color color;

  TableBorderPainter({required this.borderRadius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final radius = borderRadius.resolve(TextDirection.ltr);
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw the rounded border
    final rrect = RRect.fromRectAndRadius(rect, radius.topLeft);
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
