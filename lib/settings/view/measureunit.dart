import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/measure_unit_controller.dart';
import '../utils/measureunitform.dart';


class measureunit extends StatefulWidget {
  measureunit({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _measureunit  createState() => _measureunit ();
}

class _measureunit extends State<measureunit> {


  final measureunitController _measureunitController = Get.put(measureunitController  ());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton:  FloatingActionButton(
        onPressed: () async {
          await show_measureunitDialog(context);
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
                  'Unit type',
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
              // Add this to make the ListView scrollable
              child:  ListView.builder(
                shrinkWrap: true, // Add this to avoid the ListView overflow error
                itemCount:  _measureunitController.units.length,
                itemBuilder: (context, index)
                {
                  Measureunit unit =  _measureunitController.units[index];
                  return
                    ListTile(
                      leading:
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child:Text(unit.name,
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
                              width: MediaQuery.of(context).size.width * 0.3,
                              child:Text(unit.unit,
                                style: TextStyle(
                                    fontSize: 16
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
                      IconButton(
                        icon: Icon(Icons.delete , size: 20),
                        onPressed: () {
                          setState(() {
                            _measureunitController.removetype(index);

                          });


                        },
                      ),
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

