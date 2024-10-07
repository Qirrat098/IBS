import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:html/parser.dart' as html_parser;
import 'package:project_scitforte/Plans_and_Teams/plan_details.dart';
import 'Create_Onepage_Dialogue.dart';

class OnePagePlansTab extends StatefulWidget {
  @override
  _OnePagePlansTabState createState() => _OnePagePlansTabState();
}

class _OnePagePlansTabState extends State<OnePagePlansTab> {
  bool _isIconClicked = false;
  bool displayClassList = false;
  TextEditingController controller = TextEditingController();
  TextEditingController strategyController = TextEditingController();
  TextEditingController teamsController = TextEditingController();
  TextEditingController customDropdownController = TextEditingController(); // Controller for custom dropdown
  List<String> customDropdownlist = []; // Change from String to List<String>
  TextEditingController teamlistDropdownController = TextEditingController();
  List<String> teamDropdownlist = [];
  Set<Map<String, dynamic>> selectedPlans = {}; // Store selected plans


  String dropdownValue1 = 'Nothing Selected';
  String dropdownValue2 = 'Nothing Selected';
  Map<String, dynamic>? selectedPlan;
  List<Map<String, String>> plans = [];
  List<String> strategies = [];
  List<String> teams = [];
  int _selectedPlanIndex = -1; // Track which plan is clicked

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

  void _showCreateOnepageDialogue() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: CreateOnepageDialogue(
            onCreateOnePagePlan: (
                String planName,
                String teamName,
                String assignToPlan,
                String description,
                String strategy,
                String strategyPillar,
                String customDropdown, // Now a single string
                String teamsDropdown,
                String timeFrame,
                String teamsString, // Use this if needed
                ) {
              // Parse the HTML description to plain text
              final descriptionPlainText = html_parser.parse(description).body?.text ?? "";

              // Update the state with the new plan and updated dropdown options
              setState(() {
                plans.add({
                  'teamName': teamName,
                  'planName': planName,
                  'assignToPlan': assignToPlan,
                  'description': descriptionPlainText,
                  'strategy': strategy,
                  'strategyPillar': strategyPillar,
                  'timeFrame': timeFrame,
                  'customDropdown': customDropdown, // Updated to String
                  'teamsDropdown': teamsDropdown,
                });

                // Update the strategy list with new strategies if added
                if (!strategies.contains(strategy)) {
                  strategies.add(strategy);
                }
                if (!customDropdownlist.contains(customDropdown)) {
                  customDropdownlist.add(customDropdown);
                }
                if (!teamDropdownlist.contains(teamsDropdown)) {
                  teamDropdownlist.add(teamsDropdown);
                }
                // Update the teams list with new teams if necessary
                teams.clear();
                teams.addAll(teams); // This line may need adjustment based on your actual logic

                // Optionally, update other dropdowns or lists as needed
              });
            },
            strategies: strategies, // Pass current strategies list
            teams: teams, // Pass current teams list
            customDropdownlist: customDropdownlist, // Update as needed
            teamDropdownlist: teamDropdownlist,
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
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateOnepageDialogue,
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
                      hintStyle: TextStyle(color: Colors.grey,
                          fontSize: 14, fontWeight: FontWeight.normal),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0), // Add rounded corners
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 2.5), // Add a border with the desired color
                      borderRadius: BorderRadius.circular(0), // Apply the same border radius
                    ),
                    child: CustomPaint(
                      painter: TableBorderPainter(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.grey[300]!,
                      ),
                      child: DataTable(
                        showCheckboxColumn: false, // Hides the checkbox column
                        columnSpacing: 35,
                        headingRowHeight: 45,
                        dataRowHeight: 50,
                        headingTextStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                        dataRowColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                              return Colors.white;
                            }),
                        headingRowColor:
                        MaterialStateColor.resolveWith((states) => Colors.grey[200]!),
                        columns: <DataColumn>[
                          DataColumn(
                              label: Text('Plan', style: TextStyle(fontSize: 13))),
                          DataColumn(
                              label: Text('Team', style: TextStyle(fontSize: 13))),
                          DataColumn(
                              label: Text('Parent Plan', style: TextStyle(fontSize: 13))),
                          DataColumn(
                              label: Text('Focus Area', style: TextStyle(fontSize: 13))),
                          DataColumn(
                              label: Text('Objective', style: TextStyle(fontSize: 13))),
                          DataColumn(
                              label: Text('Plan Contributors', style: TextStyle(fontSize: 13))),
                          DataColumn(
                              label: Text('Access', style: TextStyle(fontSize: 13))),
                        ],
                        rows: plans.map((plan) {
                          final isSelected = selectedPlans.contains(plan);

                          return DataRow(
                            color: MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                                  return isSelected
                                      ? Colors.purple.shade100
                                      : Colors.white; // Color change for the entire row
                                }),
                            cells: <DataCell>[
                              DataCell(Text(plan['planName'] ?? '--')),
                              DataCell(Text(plan['teamsDropdown'] ?? '--')),
                              DataCell(Text(plan['customDropdown'] ?? '--')),
                              DataCell(Text(plan['focusArea'] ?? '0')),
                              DataCell(Text(plan['objective'] ?? '0')),
                              DataCell(Text(plan['planContributors'] ?? '0')),
                              DataCell(
                                IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {
                                    _showPlanOptions(plans.indexOf(plan));
                                  },
                                ),
                              ),
                            ],
                            onSelectChanged: (selected) {
                              if (selected != null && selected) {
                                setState(() {
                                  selectedPlans.add(plan);
                                });

                                // Trigger the color change, wait for a second, then navigate
                                Future.delayed(Duration(seconds: 1), () {
                                  setState(() {
                                    selectedPlans.remove(plan);
                                  });

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlanDetails(planDetails: plan),
                                    ),
                                  );
                                });
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
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
