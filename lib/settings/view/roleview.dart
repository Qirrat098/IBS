import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../login_signup/login.dart';
import '../controllers/rolecontroller.dart';
import '../utils/roleform.dart';



class roles extends StatefulWidget {
  roles({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _rolesState createState() => _rolesState();
}

class _rolesState extends State<roles> {

  final roleController _roleController = Get.put(roleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        floatingActionButton:  FloatingActionButton(
          onPressed: () async {
            await showrolesDialog(context);
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
                    'Roles',
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

                child:  ListView.builder(
                  shrinkWrap: true, // Add this to avoid the ListView overflow error
                  itemCount: _roleController.roles.length,
                  itemBuilder: (context, index)
                  {
                    Roleinfo status = _roleController.roles[index];
                    return
                      ListTile(
                        leading:
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child:Text(status.name,
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),
                        ),

                     title:
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              icon: Icon(Icons.delete , size: 20),
                              onPressed: () {
                                setState(() {
                                  _roleController.removetype(index);

                                });
                                }
                                ),
                               IconButton(
                                 icon: Icon(Icons.edit , size: 20), onPressed: () {

                               },

                               )

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

