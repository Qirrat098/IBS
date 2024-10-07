import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/usercontroller.dart';
import '../view/user.dart';


Future<void>  userInformationDialog(BuildContext context)async {
  return await showDialog(context: context,
      builder: (context){
        final _formKey = GlobalKey<FormState>();
        final userController  _userController = Get.find();
        String? _name;
        String? _email;
        String? _role;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            ),

            content:  Container(

              width: MediaQuery.of(context).size.width * 0.8,
              height:
              MediaQuery.of(context).size.height * 0.45,
              child:
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create new user',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'User Name',
                            hintText: 'Enter user name',
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a user name';
                            }
                            return null;
                          },
                          onSaved: (value) => _name = value!
                      ),
                      const SizedBox(height: 16.0),
                      TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'User Email',
                            hintText: 'Enter user email',
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a user email';
                            }
                            return null;
                          },
                          onSaved: (value) => _email = value!
                      ),
                      const SizedBox(height: 16.0),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                            labelText: 'Role',
                            suffixStyle: TextStyle(
                                fontSize: 10
                            )
                        ),

                        value: _role,
                        // hint: const Text('Team'),
                        items: const [
                          DropdownMenuItem(
                            value: 'select',
                            child: Text('Select'),
                          ),
                          DropdownMenuItem(
                            value: 'role1',
                            child: Text('Role 1'),
                          ),
                          DropdownMenuItem(
                            value: 'role2',
                            child: Text('Role 2'),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _role = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value == 'select') {
                            return 'Please select a team';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(

                            onPressed: () {
                              Navigator.pop(
                                context,
                                MaterialPageRoute(builder: (context) =>createuser()),
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
                                _userController.adduser(
                                    User(
                                  name: '$_name',
                                  email: '$_email',
                                  role: '$_role',

                                )
                                );
                                //Get.back();
                                // print('Strategy Name: $_Strategy');
                                // print('Parent Strategy: $_parentStrategy');
                                // print('Team: $_team');
                                // print('Timeframe: $_timeframe');
                                // print('Strategy Type: $_strategyType');
                                // print('Status: $_status');u
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>createuser()),
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