import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/actionstatuscontroller.dart';
import '../utils/actionstatusform.dart';


class actionstatus extends StatefulWidget {
  actionstatus({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _actionstatusState createState() => _actionstatusState();
}

class _actionstatusState extends State<actionstatus> {

  final actionstatusController _actionstatusController = Get.put(actionstatusController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        floatingActionButton:  FloatingActionButton(
          onPressed: () async {
            await showactivestatusDialog(context);
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
                    'Active Status',
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

                child:  ListView.builder(
                  shrinkWrap: true, // Add this to avoid the ListView overflow error
                  itemCount: _actionstatusController.status.length,
                  itemBuilder: (context, index)
                  {
                    AStatus status = _actionstatusController.status[index];
                    return
                      ListTile(
                        leading:
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child:Text(status.name,
                            style: TextStyle(
                                fontSize: 16
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
                                  borderRadius: BorderRadius.circular(4.0),
                                  color: status.colorcode,
                                ),
                              ),

                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child:Text(status.status,
                                  style: TextStyle(
                                      fontSize: 16
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
                              icon: Icon(Icons.delete , size: 20),
                              onPressed: () {
                                setState(() {
                                  _actionstatusController.removetype(index);

                                });
                                Container(
                                  child: Icon(Icons.edit , size:20),
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

