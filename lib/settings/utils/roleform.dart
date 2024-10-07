import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/rolecontroller.dart';
import '../view/roleview.dart';




Future<void>  showrolesDialog(BuildContext context)async {
  return await showDialog(context: context,
      builder: (context){
        final _formKey = GlobalKey<FormState>();
        final roleController _rolecontroller = Get.find();
        Map<String, Map<String, bool>> _permissions = {
          'Strategy': {
            'View': false,
            'Create': false,
            'Edit': false,
            'Delete': false,
          },
          'Strategy Map': {
            'View': false,
            'Create': false,
            'Edit': false,
            'Delete': false,
          },
          'Strategy Document': {
            'View': false,
            'Create': false,
            'Edit': false,
            'Delete': false,
          },
          'Strategy Type': {
            'View': false,
            'Create': false,
            'Edit': false,
            'Delete': false,
          },
          'Time Horizon': {
            'View': false,
            'Create': false,
            'Edit': false,
            'Delete': false,
          },
        };
        String? _name;



        return StatefulBuilder(builder: (context, setState) {
          @override
          void dispose() {
            _rolecontroller.dispose();
            //super.dispose();
          }

          void _togglePermission(String page, String permission) {
            setState(() {
              _permissions[page]![permission] =
              !_permissions[page]![permission]!;
            });
          }

          // void _checkAll() {
          //   setState(() {
          //     _permissions.forEach((key, value) {
          //       value.forEach((key, value) {
          //         _permissions[key]![key] = true;
          //       });
          //     });
          //   });
          // }


                    return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            ),

            content:  Container(

              width: MediaQuery.of(context).size.width * 1.0,
              height: MediaQuery.of(context).size.height * 0.8,
              child:
              SingleChildScrollView(
                child:
                Form(
                  key: _formKey,

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create a New Role',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //SizedBox(height: 8),
                        TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Role Name',
                              hintText: 'Enter role name',
                            ),

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a role name';
                              }
                              return null;
                            },
                            onSaved: (value) => _name = value!
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Checkbox(
                              value: false, // Replace with appropriate state
                              onChanged: (value) {

                              },
                            ),
                            Text('Default'),
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 36,
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              'Strategy',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          // Limit the width of the table
                          width: MediaQuery.of(context).size.width * 0.7,
                          // Limit the height of the table
                          height: MediaQuery.of(context).size.width * 0.6,
                          child: SingleChildScrollView(
                            // Make table scrollable if content overflows
                            child: DataTable(


                              // Add fixed column width
                              columnSpacing: 2,
                              columns: [
                                DataColumn(label: Text('Page')),
                                DataColumn(label: Text('View')),
                                DataColumn(label: Text('Create')),
                                DataColumn(label: Text('Edit')),
                                DataColumn(label: Text('Delete')),
                              ],
                              rows: _permissions.entries.map((entry) {
                                final page = entry.key;
                                final permissions = entry.value;
                                return DataRow(
                                  cells: [
                                    DataCell(Text(page)),
                                    DataCell(
                                      Checkbox(
                                        value: permissions['View']!,
                                        onChanged: (value) {
                                          _togglePermission(page, 'View');
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      Checkbox(
                                        value: permissions['Create']!,
                                        onChanged: (value) {
                                          _togglePermission(page, 'Create');
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      Checkbox(
                                        value: permissions['Edit']!,
                                        onChanged: (value) {
                                          _togglePermission(page, 'Edit');
                                        },
                                      ),
                                    ),
                                    DataCell(
                                      Checkbox(
                                        value: permissions['Delete']!,
                                        onChanged: (value) {
                                          _togglePermission(page, 'Delete');
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: (){
                                setState(() {
                             _permissions.forEach((key, value) {
                              value.forEach((key, value) {
                              _permissions[key]![key] = true;
                              });

          }
          );
          });
                },
                              child: Text('Check All'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.05,
                                    MediaQuery.of(context).size.width * 0.05),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                            ),
                            ),

                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _rolecontroller.addrole(Roleinfo (
                                    name: '$_name',

                                  )
                                  );
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>roles(title: '',)),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.05,
                                    MediaQuery.of(context).size.width * 0.05),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Save',
                                style: TextStyle(
                                  color: Colors.deepPurple,


                                ),),
                            ),

                            ElevatedButton(
                              onPressed: () {
                                // Close the dialog
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancel'),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.05,
                                    MediaQuery.of(context).size.width * 0.05),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            //),
          );


        });
      });
}

