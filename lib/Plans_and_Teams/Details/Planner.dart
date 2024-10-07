import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_scitforte/Plans_and_Teams/Details/plan_form.dart';
import 'AddFocusAreaDialog.dart';
import 'EditFocusPlan.dart';
import 'FocusAreaDetailsDialog.dart';
import 'KeyTargetDialog.dart';
import 'Strategy_form.dart';

class PlannerScreen extends StatefulWidget {
  @override
  _PlannerScreenState createState() => _PlannerScreenState();
}

class _PlannerScreenState extends State<PlannerScreen> {
  List<Map<String, String>> plans = []; // List for Plan Elements
  List<Map<String, String>> strategyPillars = []; // List for Strategy Pillars
  List<Map<String, dynamic>> keyTargets = []; // List for Key Targets
  List<String> focusAreas = [];
  List<Map<String, String>> planDetails = [];


  void _showAddPlanDialog() async {
    final newPlan = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return PlanFormDialog();
      },
    );

    if (newPlan != null && newPlan.isNotEmpty) {
      setState(() {
        plans.add(newPlan);
      });
    }
  }

  void _showStrategyPillarDialog() async {
    final newPillar = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return StrategyFormDialog();
      },
    );

    if (newPillar != null && newPillar.isNotEmpty) {
      setState(() {
        strategyPillars.add(newPillar);
      });
    }
  }
  void _showCreateTargetDialog() async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return CreateTargetDialog();
      },
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        keyTargets.add(result);
      });
    }
  }

  void _showTargetDetails(Map<String, dynamic> target) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Target Details', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Target Name: ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      TextSpan(
                        text: target['targetName'] ?? 'No Target Name',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Items: ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      TextSpan(
                        text: target['items'] != null && target['items'].isNotEmpty
                            ? target['items'].map((item) => '${item['name']}: ${item['description']}').join('\n')
                            : 'No Items',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close', style: GoogleFonts.inter(fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  void _editItem(int targetIndex, int itemIndex) {
    // Get the current target and item details
    final target = keyTargets[targetIndex];
    final item = target['items'][itemIndex];

    // Temporary variables to hold edited values
    String editedName = item['name'];
    String editedDescription = item['description'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: editedName),
                onChanged: (value) {
                  editedName = value;
                },
                decoration: InputDecoration(labelText: 'Item Name'),
              ),
              TextField(
                controller: TextEditingController(text: editedDescription),
                onChanged: (value) {
                  editedDescription = value;
                },
                decoration: InputDecoration(labelText: 'Item Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without saving
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  keyTargets[targetIndex]['items'][itemIndex] = {
                    'name': editedName,
                    'description': editedDescription,
                  };
                });
                Navigator.of(context).pop(); // Close the dialog and save changes
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _viewTargetDetails(int index) {
    // Implement viewing target details logic here
    // You can show a dialog or a new screen with target details
  }

  void _editTarget(int index) {
    // Implement editing target logic here
    // Show a dialog to edit the target name, item names, and descriptions
  }

  void _deleteTarget(int index) {
    setState(() {
      keyTargets.removeAt(index);
    });
  }

  void _deleteItem(int targetIndex, int itemIndex) {
    setState(() {
      keyTargets[targetIndex]['items'].removeAt(itemIndex);
    });
  }

  void _showPlanDetails(Map<String, String> plan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Plan Details', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Name: ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      TextSpan(
                        text: plan['name'] ?? 'No Name',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Description: ',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                      ),
                      TextSpan(
                        text: plan['description'] ?? 'No Description',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close', style: GoogleFonts.inter(fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _editPlan(int index) {
    // Handle editing of the plan
  }

  void _deletePlan(int index) {
    setState(() {
      plans.removeAt(index);
    });
  }

  void _deleteStrategyPillar(int index) {
    setState(() {
      strategyPillars.removeAt(index);
    });
  }

  void _showAddFocusAreaDialog() async {
    String? selectedFocusArea = await showDialog(
      context: context,
      builder: (context) => AddFocusAreaDialog(focusAreas: focusAreas),
    );

    if (selectedFocusArea != null && selectedFocusArea.isNotEmpty) {
      String? planDetail = await showDialog(
        context: context,
        builder: (context) => AddPlanDetailsDialog(focusAreaName: '',),
      );

      if (planDetail != null && planDetail.isNotEmpty) {
        setState(() {
          focusAreas.add(selectedFocusArea);
          planDetails.add({
            'focusArea': selectedFocusArea,
            'details': planDetail,
          });
        });
      }
    }
  }

  void _showEditDialog(int index) async {
    final editedDetail = await showDialog<Map<String, String>>(
      context: context,
      builder: (BuildContext context) {
        return EditPlanDetailsDialog(
          initialDetail: planDetails[index],
        );
      },
    );

    if (editedDetail != null) {
      setState(() {
        planDetails[index] = editedDetail;
      });
    }
  }

  void _deleteDetail(int index) {
    setState(() {
      planDetails.removeAt(index);
    });
  }

  void _showAddObjectiveDialog() async {
    final TextEditingController _controller = TextEditingController();

    bool? result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Name Your Objective',
            style: TextStyle(
              fontSize: 16, // Adjust font size for title
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Container(
            height: 60, // Adjust container height if needed
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Objective Name',
                labelStyle: TextStyle(fontSize: 14), // Adjust label font size
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.zero, // Square borders
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero, // Square borders when focused
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.zero, // Square borders when enabled
                ),
              ),
              style: TextStyle(fontSize: 14), // Adjust input text font size
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Cancel
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF5A6268), // Button color
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Square corners
                  ),
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 14), // Adjust button text font size
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Save
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFC01562), // Button color
                  padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Square corners
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(fontSize: 14), // Adjust button text font size
                ),
              ),
            ),
          ],
        );
      },
    );

    if (result == true && _controller.text.isNotEmpty) {
      setState(() {
        planDetails.add({'focusArea': _controller.text});
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExpansionTile(
              title: Row(
                children: [
                  Text('Plan Elements', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100, // Adjust height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: plans.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 150, // Adjust width as needed
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF0A2C54)), // Set border color similar to the image
                                borderRadius: BorderRadius.circular(8), // Rounded corners
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2), // Shadow color
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 2), // Shadow position
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top Section with Text and Icons
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0A2C54), // Top section background color
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text displaying the name
                                        Text(
                                          plans[index]['name'] ?? '', // Displaying the name from the list
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // Icons
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(2.0), // Reduced padding around the icon
                                              child: PopupMenuButton<String>(
                                                onSelected: (value) {
                                                  if (value == 'view') {
                                                    _showPlanDetails(plans[index]);
                                                  } else if (value == 'edit') {
                                                    _editPlan(index);
                                                  } else if (value == 'delete') {
                                                    _deletePlan(index);
                                                  }
                                                },
                                                itemBuilder: (BuildContext context) {
                                                  return [
                                                    PopupMenuItem<String>(
                                                      value: 'view',
                                                      child: Text('View Description'),
                                                    ),
                                                    PopupMenuItem<String>(
                                                      value: 'edit',
                                                      child: Text('Edit Plan'),
                                                    ),
                                                    PopupMenuItem<String>(
                                                      value: 'delete',
                                                      child: Text('Delete'),
                                                    ),
                                                  ];
                                                },
                                                child: Icon(Icons.more_vert, size: 16, color: Colors.white), // Icon for the menu
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Body Content below the top section
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        plans[index]['description'] ?? '', // Displaying description
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black87,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Align the button to the bottom right
                      SizedBox(height:13),
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
                            onPressed: _showAddPlanDialog,
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Row(
                children: [
                  Text('Strategy Pillars', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100, // Adjust height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: strategyPillars.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 150, // Adjust width as needed
                              margin: EdgeInsets.only(right: 8.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFF0A2C54)), // Border color
                                borderRadius: BorderRadius.circular(8), // Rounded corners
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2), // Shadow color
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: Offset(0, 2), // Shadow position
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Top Section with Text and Icons
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0A2C54), // Top section background color
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Text displaying the name
                                        Text(
                                          strategyPillars[index]['name'] ?? '', // Displaying the name from the list
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // Icons
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.all(2.0), // Reduced padding around the icon
                                              child: PopupMenuButton<String>(
                                                onSelected: (value) {
                                                  if (value == 'view') {
                                                    _showPlanDetails(strategyPillars[index]);
                                                  } else if (value == 'edit') {
                                                    _editPlan(index);
                                                  } else if (value == 'delete') {
                                                    _deleteStrategyPillar(index);
                                                  }
                                                },
                                                itemBuilder: (BuildContext context) {
                                                  return [
                                                    PopupMenuItem<String>(
                                                      value: 'view',
                                                      child: Text('View Description'),
                                                    ),
                                                    PopupMenuItem<String>(
                                                      value: 'edit',
                                                      child: Text('Edit Pillar'),
                                                    ),
                                                    PopupMenuItem<String>(
                                                      value: 'delete',
                                                      child: Text('Delete'),
                                                    ),
                                                  ];
                                                },
                                                child: Icon(Icons.more_vert, size: 16, color: Colors.white), // Icon for the menu
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Body Content below the top section
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        strategyPillars[index]['description'] ?? '', // Displaying description
                                        style: GoogleFonts.inter(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black87,
                                        ),
                                        overflow: TextOverflow.visible,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Align the button to the bottom right
                      SizedBox(height:13),
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
                            onPressed: _showStrategyPillarDialog,
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ExpansionTile(
              title: Row(
                children: [
                  Text(
                    'Key Targets',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black, // Change to your desired color
                    ),
                  ),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.all(16.0),
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.0),
                      Container(
                        height: 144, // Adjust height as needed
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: keyTargets.length,
                          itemBuilder: (context, index) {
                            final target = keyTargets[index];
                            return Stack(
                              children: [
                                Container(
                                  width: 200, // Adjust width as needed
                                  margin: EdgeInsets.only(right: 8.0),
                                  padding: EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFF0A2C54)), // Border color
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        target['targetName'] ?? '',
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0A2C54), // Heading text color
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 5),
                                      Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: target['items']?.length ?? 0,
                                          itemBuilder: (context, itemIndex) {
                                            final item = (target['items'] as List<Map<String, String>>?)?[itemIndex];
                                            return Stack(
                                              children: [
                                                // ExpansionTile wrapped in a Container to make space for icons
                                                Container(
                                                  margin: EdgeInsets.only(right: 50), // Adjust margin to make space for icons
                                                  child: ExpansionTile(
                                                    title: Text(
                                                      item?['name'] ?? '',
                                                      style: GoogleFonts.inter(fontSize: 13),
                                                    ),
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Text(
                                                          item?['description'] ?? '',
                                                          style: GoogleFonts.inter(fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // Positioned Edit Icon
                                                Positioned(
                                                  right: -15,
                                                  top: 10,
                                                  child: IconButton(
                                                    icon: Icon(Icons.edit, size: 16, color: Colors.grey),
                                                    onPressed: () {
                                                      _editItem(index, itemIndex); // Correctly passing itemIndex
                                                    },
                                                  ),
                                                ),
                                                // Positioned Delete Icon
                                                Positioned(
                                                  right: 8,
                                                  top: 9, // Adjusted top position for spacing
                                                  child: IconButton(
                                                    icon: Icon(Icons.delete, size: 16, color: Colors.blue),
                                                    onPressed: () {
                                                      _deleteItem(index, itemIndex); // Correctly passing itemIndex
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Positioned "More Vert" Icon
                                Positioned(
                                  right: 15,
                                  top: 10,
                                  child: PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == 'view') {
                                        _showTargetDetails(target);
                                      } else if (value == 'edit') {
                                        _editTarget(index);
                                      } else if (value == 'delete') {
                                        _deleteTarget(index);
                                      }
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem<String>(
                                          value: 'view',
                                          child: Text('View Items'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'edit',
                                          child: Text('Edit Target'),
                                        ),
                                        PopupMenuItem<String>(
                                          value: 'delete',
                                          child: Text('Delete Target'),
                                        ),
                                      ];
                                    },
                                    child: Icon(Icons.more_vert, size: 18, color: Color(0xFF0A2C54)), // Color for the more icon
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 12),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFFC01562),
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Color(0xFFC01562), width: 2.0),
                              ),
                            ),
                            onPressed: _showCreateTargetDialog,
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            ExpansionTile(
              title: Row(
                children: [
                  Text(
                    'Plan Detail',
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              children: [
                Container(
                  padding: EdgeInsets.all(12.0),
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...planDetails.asMap().entries.map((entry) {
                        int index = entry.key;
                        Map<String, String> detail = entry.value;

                        return Container(
                          margin: EdgeInsets.only(bottom: 8.0), // Space between tiles
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          child: Stack(
                            children: [
                              ExpansionTile(
                                title: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/focus.jpeg',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        detail['focusArea']!,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 20, // Set the width of the circle
                                          height: 20, // Set the height of the circle
                                          decoration: BoxDecoration(
                                            color: Color(0xFFC01562), // Circle color
                                            shape: BoxShape.circle,
                                          ),
                                          child: IconButton(
                                            icon: Icon(Icons.add, size: 16, color: Colors.white), // Adjust icon size if needed
                                            onPressed: () {
                                              _showAddObjectiveDialog();
                                            },
                                            padding: EdgeInsets.zero, // Remove default padding
                                            constraints: BoxConstraints(),
                                          ),
                                        ),
                                        SizedBox(width: 8), // Adjust spacing as needed
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              // Your content here
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                right: -12,
                                top: 3,
                                child: IconButton(
                                  icon: Icon(Icons.more_vert, size: 20),
                                  onPressed: () {
                                    _showBottomSheet(context, index);
                                  },
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
                            onPressed: _showAddFocusAreaDialog,
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
  void _showBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                  _showEditDialog(index); // Call the edit dialog function
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete'),
                onTap: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                  _deleteDetail(index); // Call the delete function
                },
              ),
            ],
          ),
        );
      },
    );
  }
}



