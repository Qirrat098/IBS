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
  final TextEditingController _descriptionController = TextEditingController();
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
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400),
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
                    fontSize: 13.5,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 35, // Set the desired height
                  padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 0),
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
            Column(
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
                          fontSize: 13.5,
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
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(0),
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
                          fontSize: 13.5,
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
                          height: 35,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(0),
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
                        // Call your onCreatePlan function with the necessary values
                        widget.onCreateFocusArea(
                          parentPlanDropdownValue,
                          _teamNameController.text,
                          assignToPlanDropdownValue,
                          descriptionText, // Pass the description text
                          strategyController.text,
                          strategyPillarsDropdownValue,
                          widget.teams,
                          timeframeDropdownValue,
                          commencementDate,
                          retirementDate,
                        );

                        Navigator.of(context).pop(); // Close the dialog on success
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
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10), // Add horizontal padding
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
            top: -5, // Adjust according to your needs
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
