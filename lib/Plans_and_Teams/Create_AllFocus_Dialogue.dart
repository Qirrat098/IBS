import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

class CreateAllfocusDialouge extends StatefulWidget {
  final Function(String, String, String, String, String, String, List<String>, String, String, String) onCreateFocusArea;
  final List<String> strategies;
  final List<String> teams; // Pass teams list

  CreateAllfocusDialouge({required this.onCreateFocusArea, required this.strategies, required this.teams});

  @override
  _CreateAllfocusDialougeState createState() => _CreateAllfocusDialougeState();
}

class _CreateAllfocusDialougeState extends State<CreateAllfocusDialouge> {
  final TextEditingController _teamNameController = TextEditingController();
  final HtmlEditorController _descriptionController = HtmlEditorController();
  String parentPlanDropdownValue = 'My Plan';
  String assignToPlanDropdownValue = 'All';
  String strategyPillarsDropdownValue = 'Marketing'; // Default value
  String timeframeDropdownValue = 'One Week';
  final TextEditingController strategyController = TextEditingController();
  final TextEditingController teamsController = TextEditingController();
  bool isLoading = false;

  String commencementDate = DateFormat('MM/dd/yyyy').format(DateTime.now());
  String retirementDate = DateFormat('MM/dd/yyyy').format(DateTime.now());


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
                  "Create a new focus area",
                  style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(height: 16),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 43, // Set the desired height
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Set the border color
                      width: 1.0, // Set the border width
                    ),
                    borderRadius: BorderRadius.circular(4.0), // Optional: for rounded corners
                  ),
                  child: Center(
                    child: TextField(
                      controller: _teamNameController,
                      style: GoogleFonts.inter(
                        fontSize: 14, // Decrease font size
                      ),
                      textAlign: TextAlign.start, // Center text and cursor
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // Add horizontal padding
                        border: InputBorder.none, // Remove default border
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text('Description' ,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            HtmlEditor(
              controller: _descriptionController,
              htmlEditorOptions: HtmlEditorOptions(
                hint: " ",
                shouldEnsureVisible: true,
              ),
              otherOptions: OtherOptions(
                height: 200,
              ),
              callbacks: Callbacks(
                onChangeContent: (String? html) {
                  print("Content changed: $html");
                },
              ),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Type',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 43, // Set the desired height
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey, // Set the border color
                      width: 1.0, // Set the border width
                    ),
                    borderRadius: BorderRadius.circular(4.0), // Optional: for rounded corners
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: assignToPlanDropdownValue,
                      isExpanded: true, // Ensure the dropdown button takes the full width
                      hint: Text(
                        'Nothing selected',
                        style: GoogleFonts.inter(fontSize: 14), // Adjust hint text style
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
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Add horizontal padding
                            child: Text(
                              value,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.5, // Decrease font size of options
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
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Commencement date',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'mm/dd/yyyy', // Upper text
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              commencementDate = DateFormat('MM/dd/yyyy').format(pickedDate);
                            });
                          }
                        },
                        child: Container(
                          height: 43,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: Text(
                              commencementDate, // Display the initialized date
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16), // Space between the date pickers
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Retirement \ndate',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'mm/dd/yyyy', // Upper text
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      GestureDetector(
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              retirementDate = DateFormat('MM/dd/yyyy').format(pickedDate);
                            });
                          }
                        },
                        child: Container(
                          height: 43,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Center(
                            child: Text(
                              retirementDate, // Display the initialized date
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.normal,
                                fontSize: 13,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.grey[600], // Grey color for the cancel button
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
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
                      backgroundColor: Color(0xFFE94CD9),
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: isLoading ? null : () async {
                      if (_teamNameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Plan name is required')),
                        );
                        return;
                      }
                      setState(() {
                        isLoading = true;
                      });
                      final descriptionHtml = await _descriptionController.getText();
                      print("Description HTML: $descriptionHtml"); // Debug the HTML content
                      widget.onCreateFocusArea(
                        parentPlanDropdownValue,
                        _teamNameController.text,
                        assignToPlanDropdownValue,
                        descriptionHtml,
                        strategyController.text,
                        strategyPillarsDropdownValue,
                        widget.teams,
                        timeframeDropdownValue,
                        commencementDate,
                        retirementDate,

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
      height: 43,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[600]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 12, right: 40),
              border: InputBorder.none,
            ),
            onSubmitted: onSubmitted,
          ),
          Positioned(
            top: -2, // Adjust according to your needs
            right: -11, // Position to the right
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
