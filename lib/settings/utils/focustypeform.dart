import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/focus_area_controller.dart';
import '../view/focusarea_type.dart';





Future<void>  show_focusInformationDialog(BuildContext context)async {
  return await showDialog(context: context,
      builder: (context) {
        String _selectedColorCode = '0x8533FFED';
        final _formKey = GlobalKey<FormState>();
        final focustypeController  _focustypeController  = Get.find();
        String? _name;


        List<String> _colorCodes = [
          '0x8533FFED', // blue
          '0x7D5BF55C', // green
          '0xA6D62B59', // red
          '0x7DF2F55B', // yellow
          '0xA6E08DF9', // purple
        ];



        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            ),

            content: Container(

              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              height:
              MediaQuery
                  .of(context)
                  .size
                  .height * 0.3,
              child:
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create new type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Focus Area Type Name',
                            hintText: 'Focus Area Type Name',
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter focus area type Name';
                            }
                            return null;
                          },
                          onSaved: (value) => _name = value!
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButton<String>(
                        value: _selectedColorCode,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedColorCode = newValue!;
                          });
                        },
                        items: _colorCodes.map((String colorCode) {
                          return DropdownMenuItem<String>(
                            value: colorCode,
                            child: Text(_getColorNameFromCode(colorCode)),
                          );
                        }).toList(),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    focusareatype(title: '')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0x5A6268),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)
                                )
                            ),
                            child: Text('Cancel',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _focustypeController .addfocuses(
                                  Focusinfo(
                                  name: '$_name',
                                  colorcode:_getColorFromCode(_selectedColorCode),
                                ),
                                );
                                //Get.back();
                                // print('Strategy Name: $_Strategy');
                                // print('Parent Strategy: $_parentStrategy');
                                // print('Team: $_team');
                                // print('Timeframe: $_timeframe');
                                // print('Strategy Type: $_strategyType');
                                // print('Status: $_status');
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      focusareatype(title: ''))
                              );

                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFDE307E),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)
                                )
                            ),
                            child: const Text('Save',
                              style: TextStyle(
                                color: Colors.white,


                              ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      });
}

String _getColorNameFromCode(String colorCode) {
  switch (colorCode) {
    case '0x8533FFED':
      return 'Blue';
    case '0x7D5BF55C':
      return 'Green';
    case '0xA6D62B59':
      return 'Red';
    case '0x7DF2F55B':
      return 'Yellow';
    case '0xA6E08DF9':
      return 'Purple';
    default:
      return 'Unknown';
  }
}

Color _getColorFromCode(String colorCode) {
  return Color(int.parse(colorCode));
}
