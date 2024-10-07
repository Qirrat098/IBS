import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTeamDialogue extends StatefulWidget {
  final Function(String, String, String, List<String>, String) onCreatePlan; // Consider renaming this to onCreateTeam
  final List<String> teamowner;
  final List<String> teams;

  CreateTeamDialogue({required this.onCreatePlan, required this.teamowner, required this.teams});

  @override
  _CreateTeamDialogueState createState() => _CreateTeamDialogueState();
}

class _CreateTeamDialogueState extends State<CreateTeamDialogue> {
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController teamownerController = TextEditingController();
  final TextEditingController teamMembersController = TextEditingController();
  final TextEditingController parentTeamController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Create New Team",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Team Name',
                  style: GoogleFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 35,
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[700]!,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _teamNameController,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0 , vertical: 10), // Add horizontal padding
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Team Owner*' ,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            EditableDropdown(
              options: widget.teamowner,
              controller: teamownerController,
              onItemSelected: (String value) {
                setState(() {
                  teamownerController.text = value;
                });
              },
              onSubmitted: (String value) {
                if (value.isNotEmpty && !widget.teamowner.contains(value)) {
                  setState(() {
                    widget.teamowner.add(value);
                  });
                }
              },
            ),
            SizedBox(height: 16),
            Text('Team Members*' ,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            EditableDropdown(
              options: widget.teams,
              controller: teamMembersController,
              onItemSelected: (String value) {
                setState(() {
                  teamMembersController.text = value;
                });
              },
              onSubmitted: (String value) {
                if (value.isNotEmpty && !widget.teams.contains(value)) {
                  setState(() {
                    widget.teams.add(value);
                  });
                }
              },
            ),
            SizedBox(height: 16),
            Text('Parent Team*'),
            EditableDropdown(
              options: widget.teams,
              controller: parentTeamController,
              onItemSelected: (String value) {
                setState(() {
                  parentTeamController.text = value;
                });
              },
              onSubmitted: (String value) {
                if (value.isNotEmpty && !widget.teams.contains(value)) {
                  setState(() {
                    widget.teams.add(value);
                  });
                }
              },
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight, // Aligns the buttons to the right side
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end, // Moves the buttons to the right within the row
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFF5A6268), // Grey color for the cancel button
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // Reduced vertical padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  SizedBox(width: 16), // Space between the buttons
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFC01562),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // Reduced vertical padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    onPressed: isLoading ? null : () {
                      if (_teamNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Team name is required')),
                        );
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });

                      widget.onCreatePlan(
                        _teamNameController.text,
                        teamownerController.text,
                        teamMembersController.text,
                        widget.teams,
                        parentTeamController.text,
                      );

                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pop();
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Success'),
                            content: Text('Team created successfully!'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: isLoading ? CircularProgressIndicator() : Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditableDropdown extends StatelessWidget {
  final List<String> options;
  final TextEditingController controller;
  final Function(String) onItemSelected;
  final Function(String) onSubmitted;

  EditableDropdown({
    required this.options,
    required this.controller,
    required this.onItemSelected,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[600]!),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8), // Add horizontal padding
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 3, right: 40 , top:40 ),
                border: InputBorder.none,
              ),
              onSubmitted: onSubmitted,
            ),
          ),
          Positioned(
            top: -5,
            right: -11,
            child: PopupMenuButton<String>(
              icon: Icon(Icons.arrow_drop_down, color: Colors.grey[700]),
              onSelected: onItemSelected,
              itemBuilder: (BuildContext context) {
                return options.map<PopupMenuItem<String>>((String value) {
                  return PopupMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList();
              },
            ),
          ),
        ],
      ),
    );
  }
}
