import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/measure_unit_controller.dart';

import '../view/measureunit.dart';






Future<void>  show_measureunitDialog(BuildContext context)async {
  return await showDialog(context: context,
      builder: (context) {

        final _formKey = GlobalKey<FormState>();
        final measureunitController _measureunitController  = Get.find();
        String? _name;
        String? _units;



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
                            labelText: 'Unit Name',
                            hintText: 'Enter unit name',
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a unit name';
                            }
                            return null;
                          },
                          onSaved: (value) => _name = value!
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            labelText: 'Unit Type',
                            suffixStyle: TextStyle(
                                fontSize: 10
                            )),
                        value: _units,
                        // hint: const Text('Strategy Type'),
                        items: const [
                          DropdownMenuItem(
                            value: 'select',
                            child: Text('Select'),
                          ),
                          DropdownMenuItem(
                            value: 'type1',
                            child: Text('kg'),
                          ),
                          DropdownMenuItem(
                            value: 'type2',
                            child: Text('grm'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _units = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value == 'select') {
                            return 'Please select a unit type';
                          }
                          return null;
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>
                                    measureunit(title: '')),
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
                                _measureunitController.addunits(
                                  Measureunit(
                                    name: '$_name',
                                    unit: '$_units',
                                  ),
                                );
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      measureunit(title: ''))
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


