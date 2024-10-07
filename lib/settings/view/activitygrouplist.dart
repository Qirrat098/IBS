import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import '../controllers/activitycontroller.dart';
import '../utils/activitytypeform.dart';

class GroupListScreen extends StatelessWidget {
  final GroupListController _controller = Get.put(GroupListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle:  SystemUiOverlayStyle(
            statusBarColor: Colors.black45,
          ),
          backgroundColor:
          Color.fromRGBO(51, 51, 81,1),


          title: Text('Settings',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15
            ),
          ),
          actions: [

            IconButton(
              icon: Icon(Icons.message, color: Colors.white,),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.grid_view, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) =>LoginScreen ()),
                // );
              },
            ),
          ],
        ),
      body:
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
              Text(
                'Activity List',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FloatingActionButton(
                mini: true,
                onPressed: () async {
                  await showactivityDialog(context);
                },
                child: Icon(
                  Icons.add,
                  color: Colors.deepPurple,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ],
            ),
          ),

      Expanded(
        child: GroupedListView<Elementgrp, String>(
            useStickyGroupSeparators: true,
            elements: _controller.elements,
            groupBy: (element) => element.group,
            groupSeparatorBuilder: (value) => Container(
              height: MediaQuery.of(context).size.height*0.07,
              padding: const EdgeInsets.all(16),
              color: Colors.deepPurple[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  value,
                  style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold),
                ),
                // Row(
                //
                //   children: [
                //     IconButton(
                //         icon: Icon(Icons.delete),
                //         onPressed: () {
                //           // setState(() {
                //           //   _roleController.removetype(index);
                //           //
                //           // });
                //         }
                //     ),
                //     IconButton(
                //       icon: Icon(Icons.edit), onPressed: () {
                //
                //     },
                //
                //     )
                //   ],
                // ),


              ],

            ),
            ),
            itemBuilder: (context, element) => Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              child: Container(

                height: MediaQuery.of(context).size.height*0.07,
              child: ListTile(


                leading: Container(
                    width: MediaQuery.of(context).size.width*0.6,
                    child: Text(element.name)),

                title: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // setState(() {
                          //   _roleController.removetype(index);
                          //
                          // });
                        }
                    ),
                    IconButton(
                      icon: Icon(Icons.edit), onPressed: () {

                    },

                    )

                  ],




                ),
              ),
            ),
            ),
          ),
      ),
            ]
            )
    );
  }
}