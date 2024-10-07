import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/activitycontroller.dart';
import '../view/activitygrouplist.dart';

Future<void>  showactivityDialog(BuildContext context)async {
  return await showDialog(context: context,
      builder: (context) {
        final _formKey = GlobalKey<FormState>();
        final _groupController = TextEditingController();
        final _nameController = TextEditingController();
        final GroupListController _controller = Get.put(GroupListController());


        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
          ),
          title: Text('Add Item'),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _groupController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      labelText: 'Group',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a group';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height:16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(

                        onPressed: () {
                          Navigator.pop(context);
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
                            _controller.addElement(
                                _groupController.text, _nameController.text);
                            _groupController.clear();
                            _nameController.clear();
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(
                                    builder: (context) => GroupListScreen()));
                          }
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


                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     child: Text('Cancel'),
          //   ),
          //   ElevatedButton(
          //     onPressed: () {
          //       if (_formKey.currentState!.validate()) {
          //         _controller.addElement(
          //             _groupController.text, _nameController.text);
          //         _groupController.clear();
          //         _nameController.clear();
          //         Navigator.pop(context);
          //         Navigator.push(context,
          //             MaterialPageRoute(
          //                 builder: (context) => GroupListScreen()));
          //       }
          //     },
          //     child: Text('Save'),
          //   ),
          //
          // ],
        );
      }
  );
}
