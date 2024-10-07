import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:html/parser.dart' as html_parser;
import 'package:project_scitforte/Plans_and_Teams/plan_details.dart';

class CreateOnepageDialogue extends StatefulWidget {
  final void Function(
      String planName,
      String teamName,
      String assignToPlan,
      String description,
      String strategy,
      String strategyPillar,
      String customDropdown, // Updated to String
      String teamsDropdown,
      String timeFrame,
      String teamsString, // Updated to String if required
      ) onCreateOnePagePlan;
  final List<String> strategies;
  final List<String> teams; // Ensure this matches
  final List<String> customDropdownlist;
  final List<String> teamDropdownlist;

  CreateOnepageDialogue({
    required this.onCreateOnePagePlan,
    required this.strategies,
    required this.teams,
    required this.customDropdownlist,
    required this.teamDropdownlist,
  });

  @override
  _CreateOnepageDialogueState createState() => _CreateOnepageDialogueState();
}

class _CreateOnepageDialogueState extends State<CreateOnepageDialogue> {
  final TextEditingController _teamNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String parentPlanDropdownValue = 'My Plan';
  String assignToPlanDropdownValue = 'All';
  String strategyPillarsDropdownValue = 'Marketing'; // Default value
  String timeframeDropdownValue = 'One Week';
  final TextEditingController strategyController = TextEditingController();
  final TextEditingController customDropdownController = TextEditingController(); // Controller for custom dropdown
  List<String> customDropdownOptions = []; // List to store custom dropdown options
  final TextEditingController teamlistDropdownController = TextEditingController();
  List<String> teamlistDropdownOptions = [];
  bool isLoading = false;
  String removeHtmlTags(String htmlString) {
    return htmlString.replaceAll(RegExp(r'&nbsp;'), ' ').replaceAll(RegExp(r'<[^>]*>'), '');
  }
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
                  "Create One Page Plan",
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Parent Plan' ,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            EditableDropdown(
              options: widget.customDropdownlist,
              controller: customDropdownController,
              onItemSelected: (String value) {
                setState(() {
                  customDropdownController.text = value;
                });
              },
              onSubmitted: (String value) {
                if (value.isNotEmpty && !widget.customDropdownlist.contains(value)) {
                  setState(() {
                    widget.customDropdownlist.add(value);
                  });
                }
              },
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plan Name',
                  style: GoogleFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 35, // Set the desired height
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Set the border color
                      width: 1.0, // Set the border width
                    ),
                    borderRadius: BorderRadius.circular(0), // Optional: for rounded corners
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _teamNameController,
                        style: GoogleFonts.inter(
                          fontSize: 14, // Decrease font size
                        ),
                        textAlign: TextAlign.start, // Center text and cursor
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 0.0 , vertical: 10), // Add horizontal padding
                          border: InputBorder.none, // Remove default border
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Description',
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 2),
            Container(
              height: 100, // Adjust the height as needed
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey, // Set the border color
                  width: 1.0, // Set the border width
                ),
                borderRadius: BorderRadius.circular(0), // Optional: for rounded corners
              ),
              child: TextField(
                controller: _descriptionController, // Use a TextEditingController for the TextField
                maxLines: 5, // Allows multiple lines
                style: GoogleFonts.inter(fontSize: 13), // Text styling
                decoration: InputDecoration(
                  border: InputBorder.none, // Remove default border
                  hintText: "Enter description here...", // Hint text
                  contentPadding: EdgeInsets.all(8.0), // Padding inside the TextField
                ),
              ),
            ),
            SizedBox(height: 16),
          Text('Strategy' ,
            style: GoogleFonts.inter(
              fontSize: 13.5,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          EditableDropdown(
            options: widget.strategies,
            controller: strategyController,
            onItemSelected: (String value) {
              setState(() {
                strategyController.text = value;
              });
            },
            onSubmitted: (String value) {
              if (value.isNotEmpty && !widget.strategies.contains(value)) {
                setState(() {
                  widget.strategies.add(value);
                });
              }
            },
          ),
          SizedBox(height: 16),
          Text('Strategy Pillars' ,
            style: GoogleFonts.inter(
              fontSize: 13.5,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
          ),
          Container(
            height: 35, // Set the desired height
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey, // Set the border color
                width: 1.0, // Set the border width
              ),
              borderRadius: BorderRadius.circular(0), // Optional: for rounded corners
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: strategyPillarsDropdownValue,
                isExpanded: true, // Ensure the dropdown button takes the full width
                hint: Text(
                  'Nothing selected',
                  style: GoogleFonts.inter(fontSize: 14), // Adjust hint text style
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    strategyPillarsDropdownValue = newValue!;
                  });
                },
                items: <String>['Marketing', 'Finance']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Add horizontal padding
                      child: Text(
                        value,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.normal,
                          fontSize: 13, // Decrease font size of options
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
            SizedBox(height: 16),
            Text('Team' ,
              style: GoogleFonts.inter(
                fontSize: 13.5,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            EditableDropdown(
              options: widget.teamDropdownlist,
              controller: teamlistDropdownController,
              onItemSelected: (String value) {
                setState(() {
                  teamlistDropdownController.text = value;
                });
              },
              onSubmitted: (String value) {
                if (value.isNotEmpty && !widget.teamDropdownlist.contains(value)) {
                  setState(() {
                    widget.teamDropdownlist.add(value);
                  });
                }
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Type',
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: assignToPlanDropdownValue,
                            isExpanded: true,
                            hint: Text(
                              'Nothing selected',
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                assignToPlanDropdownValue = newValue!;
                              });
                            },
                            items: <String>[
                              'All',
                              'Project Portfolio',
                              'Operational',
                              'Functional',
                              'Programmatic'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7.0),
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16), // Space between dropdowns
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time Frame',
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: timeframeDropdownValue,
                            isExpanded: true,
                            hint: Text(
                              'Nothing selected',
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                timeframeDropdownValue = newValue!;
                              });
                            },
                            items: <String>[
                              'One Week',
                              'Two Weeks',
                              'One Month',
                              'Three Months',
                              'Six Months',
                              'One Year'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
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
            backgroundColor: Color(0xFFC01562), // Custom color for save button
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // Reduced vertical padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          onPressed: isLoading ? null : () async {
            // Check if the team name is empty
            if (_teamNameController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Plan name is required')),
              );
              return;
            }

            // Retrieve text from the TextEditingController for description
            final descriptionText = _descriptionController.text;
            if (descriptionText.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Description cannot be empty')),
              );
              return;
            }

            setState(() {
              isLoading = true;
            });

            try {
              // Call your onCreateOnePagePlan function with the necessary values
              widget.onCreateOnePagePlan(
                _teamNameController.text,
                parentPlanDropdownValue,
                assignToPlanDropdownValue,
                strategyController.text,
                strategyPillarsDropdownValue,
                timeframeDropdownValue,
                customDropdownController.text,
                teamlistDropdownController.text,
                descriptionText, // Pass the description text instead of descriptionHtml
                widget.teams.join(', '), // Combine teams into a string if necessary
              );

              setState(() {
                isLoading = false;
              });

              Navigator.of(context).pop(); // Close the dialog

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlanDetails(
                    planDetails: {
                      'planName': _teamNameController.text,
                      'timeFrame': descriptionText, // Use descriptionText instead of descriptionHtml
                      'teamsDropdown': teamlistDropdownController.text,
                    },
                  ),
                ),
              );

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Success'),
                    content: Text('Plan created successfully!'),
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
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${e.toString()}')),
              );
            } finally {
              setState(() {
                isLoading = false;
              });
            }
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

