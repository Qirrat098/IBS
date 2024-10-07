import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/taxcontroller.dart';
import '../view/taxview.dart';







Future<void>  show_taxDialog(BuildContext context)async {
  return await showDialog(context: context,
      builder: (context) {

        final _formKey = GlobalKey<FormState>();
        final taxController _taxController  = Get.find();
        String? _name;
        String? _taxrate;



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
                  .height * 0.4,
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
                            labelText: 'Tax Name',
                            hintText: 'Enter tax name',
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a tax name';
                            }
                            return null;
                          },
                          onSaved: (value) => _name = value!
                      ),
                      TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Tax rate',
                            hintText: 'Enter tax rate',
                          ),

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a tax rate';
                            }
                            return null;
                          },
                          onSaved: (value) => _taxrate = value!
                      ),
                      const SizedBox(height: 16.0),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                                      taxview(title: '',))
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
                                _taxController.addtaxes(
                                  Tax(
                                    name: '$_name',
                                    taxrate: '$_taxrate',
                                  ),
                                );
                              }
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>
                              taxview(title: '',))
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


