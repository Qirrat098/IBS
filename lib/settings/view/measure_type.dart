import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/measure_type_controller.dart';
import '../utils/measure_type_form.dart';


class measuretype extends StatefulWidget {
  measuretype({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _measuretype  createState() => _measuretype();
}

class _measuretype  extends State<measuretype> {


  final measuretypeController  _measuretypeController  = Get.put(measuretypeController ());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton:  FloatingActionButton(
        onPressed: () async {
          await show_measureInformationDialog(context);
        },
        backgroundColor: Color(0xFFC01562),
        child: Icon(Icons.add, size: 30, color: Colors.white), // Adjust the icon size if needed
      ),
      appBar: AppBar(
        systemOverlayStyle:  SystemUiOverlayStyle(
          statusBarColor: Colors.black45,
        ),
        backgroundColor:
        Color.fromRGBO(51, 51, 81,1),
        actions: [
          IconButton(
            icon: Icon(Icons.message, color: Colors.white,  size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white ,  size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.grid_view, color: Colors.white,  size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white,  size: 20),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) =>LoginScreen ()),
              // );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Measure type',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 8, right: 8),
              child: ListView.builder(
                shrinkWrap: true, // Avoids ListView overflow error
                itemCount:_measuretypeController.measures.length,
                itemBuilder: (context, index) {
                  Measureinfo measure = _measuretypeController.measures[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4.0), // Space around each item
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.deepPurple.shade50,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 6.0), // Add padding inside each item
                      child: ListTile(
                        leading: Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: Text(
                            measure.name,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.25,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: measure.colorcode,
                                ),
                              ),
                              Icon(Icons.edit, size: 20),
                            ],
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, size: 20),
                          onPressed: () {
                            setState(() {
                              _measuretypeController .removetype(index);
                            });
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

