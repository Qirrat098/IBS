import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parser;

import 'Create_AllFocus_Dialouge.dart';

class AllFocusAreaTab extends StatefulWidget {
  @override
  _AllFocusAreaTabState createState() => _AllFocusAreaTabState();
}

class _AllFocusAreaTabState extends State<AllFocusAreaTab> {
  TextEditingController controller = TextEditingController();
  String dropdownValue1 = 'Nothing Selected';
  String dropdownValue2 = 'Nothing Selected';

  List<Map<String, dynamic>> plans = [];
  List<String> strategies = [];
  List<String> teams = [];
  List<Map<String, String>> focusAreas = [];

  void _editFocusArea(int index) {
    // Implement edit logic here
  }

  void _removeFocusArea(int index) {
    setState(() {
      focusAreas.removeAt(index);
    });
  }

  void _showCreateAllfocusDialouge() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: CreateAllfocusDialouge(
            onCreateFocusArea: (planName, teamName, assignToPlan, description, strategy, strategyPillar, updatedTeams, timeFrame, commencementDate, retirementDate) {
              final descriptionPlainText = html_parser.parse(description).body?.text ?? "";
              setState(() {
                // Adding data to focusAreas
                focusAreas.add({
                  'focusAreaName': planName,
                  'assignToPlan': assignToPlan,
                  'timeFrame': timeFrame,
                  'description': descriptionPlainText,
                  'owner': teamName,
                  'commencementDate': commencementDate,
                  'retirementDate': retirementDate,
                });

                // Logging the focusAreas to ensure it's populated
                print(focusAreas);

                // Other existing logic
                plans.add({
                  'teamName': teamName,
                  'planName': planName,
                  'assignToPlan': assignToPlan,
                  'description': descriptionPlainText,
                  'strategy': strategy,
                  'strategyPillar': strategyPillar,
                  'commencementDate': commencementDate,
                  'retirementDate': retirementDate,
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

  void _showFocusAreaOptions(int index) {
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
                _editFocusArea(index);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete'),
              onTap: () {
                Navigator.pop(context);
                _removeFocusArea(index);
              },
            ),
          ],
        );
      },
    );
  }

  String _getHealthStatus(String retirementDate) {
    DateTime now = DateTime.now();
    DateTime retirement = DateTime.tryParse(retirementDate) ?? now;
    return retirement.isBefore(now) ? "Retire" : "Current";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateAllfocusDialouge,
        backgroundColor:Color(0xFFC01562),
        child: Icon(Icons.add, size: 30, color: Colors.white), // Adjust the icon size if needed
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 35,
                  width: 310,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey,
                          fontSize: 14, fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      prefixIcon: Icon(Icons.search,
                          size: 20, color: Colors.grey),
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
                        ['Nothing Selected', 'All', 'Strategic', 'Operational', 'Tactical'],
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
                        ['Nothing Selected', 'Short-term', 'Mid-term', 'Long-term'],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0), // Add border radius
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.grey, width: 2), // Border around the container
                      borderRadius: BorderRadius.circular(0), // Match the border radius with ClipRRect
                    ),
                    child: DataTable(
                      columnSpacing: 35,
                      headingRowHeight: 45,
                      headingTextStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 13,
                      ),
                      dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
                      headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[100]!),
                      columns: <DataColumn>[
                        DataColumn(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text('Focus Area Name'),
                          ),
                        ),
                        DataColumn(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text('Type'),
                          ),
                        ),
                        DataColumn(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text('Time Frame'),
                          ),
                        ),
                        DataColumn(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text('Description'),
                          ),
                        ),
                        DataColumn(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text('Commencement Date'),
                          ),
                        ),
                        DataColumn(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text('Retirement Date'),
                          ),
                        ),
                        DataColumn(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text('Health'),
                          ),
                        ),
                        DataColumn(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text('Access'),
                          ),
                        ),
                      ],
                      rows: focusAreas.map((focusArea) {
                        return DataRow(cells: <DataCell>[
                          DataCell(Text(focusArea['owner'] ?? '--')),
                          DataCell(Text(focusArea['assignToPlan'] ?? '--')),
                          DataCell(Text(focusArea['timeFrame'] ?? '--')),
                          DataCell(Text(focusArea['description'] ?? '--')),
                          DataCell(Text(focusArea['commencementDate'] ?? '--')),
                          DataCell(Text(focusArea['retirementDate'] ?? '--')),
                          DataCell(Text(_getHealthStatus(focusArea['retirementDate'] ?? ''))),
                          DataCell(
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {
                                _showFocusAreaOptions(focusAreas.indexOf(focusArea));
                              },
                            ),
                          ),
                        ]);
                      }).toList(),
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
