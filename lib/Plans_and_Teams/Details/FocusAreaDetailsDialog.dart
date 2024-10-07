import 'package:flutter/material.dart';

class AddPlanDetailsDialog extends StatefulWidget {
  final String focusAreaName;

  AddPlanDetailsDialog({required this.focusAreaName});

  @override
  _AddPlanDetailsDialogState createState() => _AddPlanDetailsDialogState();
}

class _AddPlanDetailsDialogState extends State<AddPlanDetailsDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController commencementController = TextEditingController();
  final TextEditingController retirementController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? selectedType;

  final Map<String, Color> typeColors = {
    'Management': Colors.blue,
    'Operational': Colors.green,
    'Functional': Colors.orange,
    'No Type': Colors.grey,
  };

  Future<void> _selectDate(TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now())
      setState(() {
        controller.text = "${picked.toLocal()}".split(' ')[0];
      });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Plan Details', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Focus Area: ${widget.focusAreaName}', style: TextStyle(fontSize: 14)),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 5),
            Container(
              height: 40, // Fixed height for the TextField
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0), // Reduce height
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Commencement Date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 5),
            Container(
              height: 40, // Fixed height for the TextField
              child: GestureDetector(
                onTap: () => _selectDate(commencementController),
                child: AbsorbPointer(
                  child: TextField(
                    controller: commencementController,
                    decoration: InputDecoration(
                      labelText: '',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // Reduce height
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today , size: 18),
                        onPressed: () => _selectDate(commencementController),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Retirement Date', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 5),
            Container(
              height: 40, // Fixed height for the TextField
              child: GestureDetector(
                onTap: () => _selectDate(retirementController),
                child: AbsorbPointer(
                  child: TextField(
                    controller: retirementController,
                    decoration: InputDecoration(
                      labelText: '',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // Reduce height
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today , size: 18),
                        onPressed: () => _selectDate(retirementController),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Description', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 5),
            Container(
              height: 80, // Fixed height for the TextField
              child: TextField(
                controller: descriptionController,
                maxLines: 3, // Allows multiple lines
                decoration: InputDecoration(
                  labelText: 'Type description',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0), // Reduce height
                ),
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Type', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                SizedBox(height: 5),
                Container(
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedType,
                      isExpanded: true,
                      items: typeColors.entries.map((entry) {
                        String type = entry.key;
                        Color color = entry.value;

                        return DropdownMenuItem<String>(
                          value: type,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: color,
                              ),
                              SizedBox(width: 10),
                              Text(type),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedType = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.grey,
            padding: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(color: Colors.grey, width: 2.0),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color(0xFFC01562),
            padding: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
              side: BorderSide(color: Color(0xFFC01562), width: 2.0),
            ),
          ),
          onPressed: () {
            String name = nameController.text;
            String commencement = commencementController.text;
            String retirement = retirementController.text;
            String description = descriptionController.text;
            String type = selectedType ?? '';

            if (name.isNotEmpty && commencement.isNotEmpty && retirement.isNotEmpty && description.isNotEmpty && type.isNotEmpty) {
              Navigator.of(context).pop(
                  '$name ($commencement - $retirement), $description, Type: $type'
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('All fields are required'))
              );
            }
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
