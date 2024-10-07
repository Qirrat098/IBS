import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/project_status_controller.dart';
import '../utils/projectstatusform.dart';



class projectstatus extends StatefulWidget {
  projectstatus({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _projectstatusState createState() => _projectstatusState();
}

class _projectstatusState extends State<projectstatus> {

  final projectstatusController _projectstatusController = Get.put(projectstatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        floatingActionButton:  FloatingActionButton(
          onPressed: () async {
            await showprojecttatusDialog(context);
          },
          backgroundColor: Color(0xFFC01562),
          child: Icon(Icons.add, size: 30, color: Colors.white), // Adjust the icon size if needed
        ),
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
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
                    'Project Status',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintText: 'Search...',
            //     ),
            //   ),
            // ),
            Expanded(
              child: SingleChildScrollView(

                child:  ListView.builder(
                  shrinkWrap: true, // Add this to avoid the ListView overflow error
                  itemCount: _projectstatusController.projects.length,
                  itemBuilder: (context, index)
                  {
                    PStatus project = _projectstatusController.projects[index];
                    return
                      ListTile(
                        leading:
                        Container(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child:Text(project.name,
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),
                        ),



                        title:
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: project.colorcode,
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child:Text(project.status,
                                  style: TextStyle(
                                      fontSize: 20
                                  ),
                                ),
                              ),
                            ],

                          ),
                        ),


                        trailing:
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  _projectstatusController.removetype(index);

                                });
                                Container(
                                  child: Icon(Icons.edit),
                                );


                              },
                            ),
                          ],
                        ),
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,,


                      );

                  },

                ),
              ),
            )

          ],
        )
    );
  }

}

