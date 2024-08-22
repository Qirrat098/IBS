import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'Create_Team_Dialogue.dart';

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
            borderRadius: BorderRadius.circular(20),
          ),
          child: CreateTeamDialogue(
            onCreatePlan: (teamName, teamowner, teamMembers, updatedTeams, parentTeam) {
              setState(() {
                if (index != null) {
                  // Editing an existing team
                  teamsData[index] = {
                    'teamName': teamName,
                    'teamOwner': teamowner,
                    'teamMembers': teamMembers,
                    'parentTeam': parentTeam,
                  };
                } else {
                  // Creating a new team
                  teamsData.add({
                    'teamName': teamName,
                    'teamOwner': teamowner,
                    'teamMembers': teamMembers,
                    'parentTeam': parentTeam,
                  });
                }

                this.teamowner.add(teamowner);
                teams.clear();
                teams.addAll(updatedTeams); // Update teams list
                parentTeams.clear();
                parentTeams.addAll(updatedTeams); // Update parent teams list
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Search bar
              Center(
                child: Container(
                  width: 310,
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      prefixIcon: GestureDetector(
                        onTap: _handleIconClick,
                        child: Icon(
                          Icons.search,
                          color: _isIconClicked ? Colors.blue : Colors.grey[500],
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          width: 2.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFFE7E8E8),
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Color(0xFFE7E8E8),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 155,
                          height: 50,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFE7E8E8),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownValue1,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.black),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue1 = newValue!;
                                });
                              },
                              items: <String>[
                                'Nothing Selected',
                                'All',
                                'Project Portfolio',
                                'Operational',
                                'Functhgional',
                                'Programmatic'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                    style: TextStyle(color: Colors.grey , fontSize: 13),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          width: 65,
                          height: 50,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFE7E8E8),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownValue2,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue2 = newValue!;
                                });
                              },
                              items: <String>['A', 'B', 'C', 'D']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Container(
                          width: 65,
                          height: 50,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFE7E8E8),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: dropdownValue3,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(color: Colors.deepPurple),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue3 = newValue!;
                                });
                              },
                              items: <String>['A', 'B', 'C', 'D']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                      style: TextStyle(color: Colors.grey)
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 125,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFFE94CD9),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xFFE94CD9), width: 2.0),
                          ),
                        ),
                        onPressed: _showCreateTeamDialogue,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 18),
                            SizedBox(width: 4),
                            Text("New Team", style: GoogleFonts.inter(fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ...teamsData.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, String> team = entry.value;
                return Stack(
                  children: [
                    Container(
                      width: 400,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFE7E8E8),
                          width: 3.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Team Name: ",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                TextSpan(
                                  text: "${team['teamName']}",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Team Owner: ",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                TextSpan(
                                  text: "${team['teamOwner']}",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Team Members: ",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                TextSpan(
                                  text: "${team['teamMembers']}",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Parent Team: ",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                TextSpan(
                                  text: "${team['parentTeam']}",
                                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 3,
                      right: -3,
                      child: PopupMenuButton(
                        icon: Icon(Icons.more_vert, color: Colors.grey),
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showCreateTeamDialogue(existingTeam: team, index: index);
                          } else if (value == 'delete') {
                            _removeTeam(index);
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            value: 'edit',
                            child: Row(
                              children: [
                                Icon(Icons.edit, color: Colors.black),
                                SizedBox(width: 8),
                                Text('Edit', style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.black),
                                SizedBox(width: 8),
                                Text('Delete', style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
