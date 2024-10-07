import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/actionstatuscontroller.dart';
import '../view/action_status.dart';



Future<void>  showactivestatusDialog(BuildContext context)async {
  return await showDialog(context: context,
      builder: (context){
        final _formKey = GlobalKey<FormState>();
        final  actionstatusController _actionstatusController= Get.find();
        String _selectedColorCode = '0xFF0000FF';
        String? _name;
        String? _status;
        List<String> _colorCodes = [
          '0xFF0000FF',
          '0xFF008000',
          '0xFFFF0000',
          '0xFFFFFF00',
          '0xFF800080',
        ];


        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            ),

            content:  Container(

              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
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
                            labelText: 'Action status',
                            hintText: 'Enter action status',
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a action status';
                            }
                            return null;
                          },
                          onSaved: (value) => _name = value!
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            labelText: 'Is Active',
                            suffixStyle: TextStyle(
                                fontSize: 10
                            )

                        ),
                        value: _status,
                        // hint: const Text('Parent Strategy'),
                        items: const [

                          DropdownMenuItem(
                            value: 'option1',
                            child: Text('Yes'),
                          ),
                          DropdownMenuItem(
                            value: 'option2',
                            child: Text('No'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _status = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value == 'select') {
                            return 'Please select a parent strategy';
                          }
                          return null;
                        },
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

                      const SizedBox(height: 16.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>actionstatus(title: '',)),
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
                                _actionstatusController.addstatus(AStatus (
                                  name: '$_name',
                                  colorcode:_getColorFromCode(_selectedColorCode),
                                  status: '$_status',
                                )
                                );
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>actionstatus(title: '',)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
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
      case '0xFF0000FF':
        return 'Blue';
      case '0xFF008000':
        return 'Green';
      case '0xFFFF0000':
        return 'Red';
      case '0xFFFFFF00':
        return 'Yellow';
      case '0xFF800080':
        return 'Purple';
      default:
        return 'Unknown';
    }
  }

  Color _getColorFromCode(String colorCode) {
    return Color(int.parse(colorCode));
  }
