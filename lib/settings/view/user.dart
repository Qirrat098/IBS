import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import '../controllers/usercontroller.dart';
import '../utils/userinfo.dart';


class createuser extends StatefulWidget {
  const createuser({super.key});

  @override
  State<createuser> createState() => _createuserState();
}

class _createuserState extends State<createuser> {

  final userController _userController  = Get.put(userController());
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
       floatingActionButton:  FloatingActionButton(
         onPressed: () async {
           await userInformationDialog(context);
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
                  'Company user',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              // Add this to make the ListView scrollable
              child: ListView.builder(
                shrinkWrap: true, // Add this to avoid the ListView overflow error
                itemCount: _userController.users.length,
                itemBuilder: (context, index)
                {
                User user = _userController.users[index];
                  return ListTile(
                      leading:
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Text(user.name,
                          style: TextStyle(
                              fontSize: 16
                          ),
                        ),
                      ),


                      title:
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              child: Text(
                                user.email,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),

                            Container(
                              child: Icon(Icons.edit , size: 20),
                            )
                          ],

                        ),
                      ),

                      trailing:
                      IconButton(onPressed: () {

                        setState(() {
                          _userController.removeuser(index);

                        });
                      },
                          icon: Icon (Icons.delete,
                            color: Colors.black , size: 20,
                          )
                      )
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,,

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
