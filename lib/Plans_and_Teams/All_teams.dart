import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

import 'Create_Team_Dialouge.dart';

class AllTeamsTab extends StatefulWidget {
  @override
  _AllTeamsTabState createState() => _AllTeamsTabState();
}

class _AllTeamsTabState extends State<AllTeamsTab> {
  bool _isIconClicked = false;
  TextEditingController controller = TextEditingController();

  String dropdownValue1 = 'Nothing Selected';
  String dropdownValue2 = 'A';
  String dropdownValue3 = 'A';

  List<Map<String, String>> teamsData = [];
  List<String> teamowner = [];
  List<String> teams = [];
  List<String> parentTeams = [];

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

  void _showCreateTeamDialogue({Map<String, String>? existingTeam, int? index}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: CreateTeamDialogue(
            onCreatePlan: (teamName, teamowner, teamMembers, updatedTeams, parentTeam) {
              setState(() {
                if (index != null) {
                  teamsData[index] = {
                    'teamName': teamName,
                    'teamOwner': teamowner,
                    'teamMembers': teamMembers,
                    'parentTeam': parentTeam,
                  };
                } else {
                  teamsData.add({
                    'teamName': teamName,
                    'teamOwner': teamowner,
                    'teamMembers': teamMembers,
                    'parentTeam': parentTeam,
                  });
                }

                this.teamowner.add(teamowner);
                teams.clear();
                teams.addAll(updatedTeams);
                parentTeams.clear();
                parentTeams.addAll(updatedTeams);
              });
            },
            teamowner: teamowner,
            teams: teams,
          ),
        );
      },
    );
  }

  void _removeTeam(int index) {
    setState(() {
      teamsData.removeAt(index);
    });
  }

  void _editPlan(int index) {
    // Implement edit logic here
  }

  void _removePlan(int index) {
    setState(() {
      teamsData.removeAt(index);
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
      backgroundColor: Colors.white60,
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateTeamDialogue,
        backgroundColor: Color(0xFFC01562),
        child: Icon(Icons.add, size: 30, color: Colors.white),
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
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      prefixIcon: GestureDetector(
                        onTap: _handleIconClick,
                        child: Icon(
                          Icons.search,
                          size: 20,
                          color: _isIconClicked ? Colors.blue : Colors.grey[500],
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
              // Filters
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 35, // Adjust the height as needed
                        child: _buildDropdown(
                            dropdownValue1,
                            ['Nothing Selected', 'All', 'Project Portfolio', 'Operational', 'Functhgional', 'Programmatic'],
                                (newValue) {
                              setState(() {
                                dropdownValue1 = newValue!;
                              });
                            }
                        ),
                      ),
                      SizedBox(width: 12),
                      SizedBox(
                        height: 35, // Adjust the height as needed
                        child: _buildDropdown(
                            dropdownValue2,
                            ['A', 'B', 'C', 'D'],
                                (newValue) {
                              setState(() {
                                dropdownValue2 = newValue!;
                              });
                            }
                        ),
                      ),
                      SizedBox(width: 12),
                      SizedBox(
                        height: 35, // Adjust the height as needed
                        child: _buildDropdown(
                            dropdownValue3,
                            ['A', 'B', 'C', 'D'],
                                (newValue) {
                              setState(() {
                                dropdownValue3 = newValue!;
                              });
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Data Table
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.5), // Black border
                    borderRadius: BorderRadius.circular(0), // Rounded corners
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0), // Match the border radius
                    child: Container(
                      color: Colors.grey[100],
                      child: CustomPaint(
                        painter: TableBorderPainter(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.grey[300]!,
                        ),
                        child: DataTable(
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
                                child: Text('Team', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Parent Team', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('No Of Plans', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Team Owner', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Members', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                            DataColumn(
                              label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Action', style: TextStyle(fontSize: 13)),
                              ),
                            ),
                          ],
                          rows: teamsData.map((team) {
                            return DataRow(cells: <DataCell>[
                              DataCell(Text(team['teamName'] ?? '--')),
                              DataCell(Text(team['parentTeam'] ?? '--')),
                              DataCell(Text('0')), // Replace with actual data
                              DataCell(Text(team['teamOwner'] ?? '--')),
                              DataCell(Text(team['teamMembers'] ?? '--')),
                              DataCell(
                                IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {
                                    _showPlanOptions(teamsData.indexOf(team));
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String value, List<String> items, ValueChanged<String?> onChanged) {
    return Container(
      width: items.length > 4 ? 155 : 65,
      height: 10, // Decreased height from 30 to 25
      padding: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0), // Reduced padding
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFE7E8E8), width: 2.0),
        borderRadius: BorderRadius.circular(0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          icon: Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Colors.grey),
          onChanged: onChanged,
          items: items.map<DropdownMenuItem<String>>((String val) {
            return DropdownMenuItem<String>(
              value: val,
              child: Text(val, style: TextStyle(color: Colors.grey, fontSize: 13)),
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
