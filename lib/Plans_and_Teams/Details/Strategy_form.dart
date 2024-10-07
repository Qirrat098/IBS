import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StrategyFormDialog extends StatefulWidget {
  @override
  _StrategyFormDialogState createState() => _StrategyFormDialogState();
}

class _StrategyFormDialogState extends State<StrategyFormDialog> {
  final _name2Controller = TextEditingController();
  final _description2Controller = TextEditingController();

  void _submit() {
    final name = _name2Controller.text;
    final description = _description2Controller.text;

    if (name.isEmpty || description.isEmpty) {
      // Show a snackbar or dialog to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    // Return a map containing the name and description
    Navigator.of(context).pop({'name': name, 'description': description});
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Pillar', style: GoogleFonts.inter(fontSize: 14)),
      content: SingleChildScrollView( // Wrap content in SingleChildScrollView
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.4, // Set a max height constraint
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start, // Aligns children to the start (left)
            children: [
              Text('Name', style: GoogleFonts.inter(fontSize: 14)), // Heading for Plan Name
              Container(
                height: 35, // Set the desired height
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0), // Optional: for rounded corners
                ),
                child: TextField(
                  controller: _name2Controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(), // Add border
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.0), // Customize border color when focused
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0), // Reduce padding to make the field shorter
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Text('Description', style: GoogleFonts.inter(fontSize: 14)), // Heading for Description
              TextField(
                controller: _description2Controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(), // Add border
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 1.0), // Customize border color when focused
                  ),
                ),
                maxLines: 3, // Allows for multiple lines
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey, // Text color
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // Reduced vertical padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(color: Colors.grey, width: 2.0),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(), // Close dialog
          child: Text('Cancel', style: GoogleFonts.inter(fontSize: 14)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFC01562), // Button background color
            foregroundColor: Colors.white, // Text color
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // Reduced vertical padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(color: Color(0xFFC01562), width: 2.0),
            ),
          ),
          onPressed: _submit,
          child: Text('Save', style: GoogleFonts.inter(fontSize: 14)),
        ),
      ],
    );
  }
}
