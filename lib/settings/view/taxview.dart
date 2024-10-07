import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/taxcontroller.dart';
import '../utils/taxform.dart';



class taxview extends StatefulWidget {
  taxview({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _taxview  createState() => _taxview();
}

class _taxview extends State<taxview> {


  final taxController _taxController = Get.put(taxController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton:  FloatingActionButton(
        onPressed: () async {
          await show_taxDialog(context);
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
                  'Tax',
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
              child:  ListView.builder(
                shrinkWrap: true, // Add this to avoid the ListView overflow error
                itemCount:  _taxController.taxes.length,
                itemBuilder: (context, index)
                {
                  Tax tax =  _taxController.taxes[index];
                  return
                    ListTile(
                      leading:
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child:Text(tax.name,
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
                              child:Text(tax.taxrate,
                                style: TextStyle(
                                    fontSize: 16
                                ),
                              ),
                            ),

                            Container(
                              child: Icon(Icons.edit , size:20),
                            )
                          ],

                        ),
                      ),


                      trailing:
                      IconButton(
                        icon: Icon(Icons.delete , size: 20),
                        onPressed: () {
                          setState(() {
                            _taxController.removetype(index);

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

