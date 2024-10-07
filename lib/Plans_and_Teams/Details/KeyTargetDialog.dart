import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateTargetDialog extends StatefulWidget {
  @override
  _CreateTargetDialogState createState() => _CreateTargetDialogState();
}

class _CreateTargetDialogState extends State<CreateTargetDialog> {
  final TextEditingController _targetNameController = TextEditingController();
  final List<Map<String, String>> _items = [];

  void _addItem() {
    setState(() {
      _items.add({'name': '', 'description': ''});
    });
  }

  void _saveTarget() {
    final targetName = _targetNameController.text;
    if (targetName.isNotEmpty) {
      Navigator.of(context).pop({
        'targetName': targetName,
        'items': _items,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75), // Set max height
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create New Target',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.0),
                Container(
                  height: 35, // Set the desired height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0), // Optional: for rounded corners
                  ),
                  child: TextField(
                    controller: _targetNameController,
                    decoration: InputDecoration(
                      labelText: 'Target Name',
                      labelStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
                    ),
                  ),
                ),
                SizedBox(height: 7.0),
                Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.0),
                ..._items.map((item) {
                  int index = _items.indexOf(item);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 35, // Set the desired height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0), // Optional: for rounded corners
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Item Name',
                                labelStyle: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _items[index]['name'] = value;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Container(
                            height: 35, // Set the desired height
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0), // Optional: for rounded corners
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: 'Item Description',
                                labelStyle: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                ),
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _items[index]['description'] = value;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFC01562),
                        padding: EdgeInsets.zero, // Removes extra padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(color: Color(0xFFC01562), width: 2.0),
                        ),
                      ),
                      onPressed: _addItem ,
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: _saveTarget,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Color(0xFFC01562),
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20), // Reduced vertical padding
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Color(0xFFC01562), width: 2.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 4),
                        Text("Save", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
