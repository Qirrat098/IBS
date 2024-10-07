

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import '../../drawer_menu.dart';
import '../controller/controller.dart';

import 'package:project_scitforte/strategy/utils/utils.dart';

import '../../login_signup/login.dart';



class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final StrategyController _strategyController = Get.put(StrategyController());
  TextEditingController controller = TextEditingController();
  bool _isIconClicked = false;
  bool displayClassList = false;

  void _handleIconClick() {
    setState(() {
      _isIconClicked = true;
    });

    Timer(Duration(seconds: 1), () {
      setState(() {
        _isIconClicked = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showstrategyDialog(context);
        },
        backgroundColor: Color(0xFFC01562),
        child: Icon(Icons.add, size: 30, color: Colors.white), // Adjust the icon size if needed
      ),
        appBar: AppBar(
          backgroundColor: Color(0xFF333452),
          elevation: 0,
          toolbarHeight: 45.0,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DrawerMenu()),
              );
            },
          ),
          actions: [

            IconButton(
              icon: Icon(Icons.message, color: Colors.white, size: 20),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white , size: 20),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.grid_view, color: Colors.white , size: 20),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.white , size: 20),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: Color(0xFFF8F9FA),
                  child: Padding(
                    padding: EdgeInsets.all(10.0), // Decreased padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            padding: EdgeInsets.only(top: 0),
                            child: Text(
                              'Strategy',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Container(
                    height: 35,
                    width: 310,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.grey ,
                            fontSize: 14, fontWeight: FontWeight.normal),
                        contentPadding: EdgeInsets.symmetric(vertical: 4 , horizontal: 0),
                        prefixIcon: GestureDetector(
                          onTap: _handleIconClick,
                          child: Icon(
                            Icons.search,
                            size: 20,
                            color: _isIconClicked ? Colors.blue : Colors.grey,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(
                            color: Color(0xFFE7E8E8),
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                          borderSide: BorderSide(
                            color: Color(0xFFE7E8E8),
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.5), // Black border with 2 width
                          borderRadius: BorderRadius.circular(0), // Optional: Add rounded corners if needed
                        ),
                        child: CustomPaint(
                                painter: TableBorderPainter(
                                borderRadius: BorderRadius.circular(0),
                                color: Colors.grey[300]!,
                                 ),
                          child: DataTable(
                            columnSpacing: 35,
                            headingRowHeight: 45,
                            headingTextStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
                            headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey[100]!),
                            columns: [
                              DataColumn(label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Name', style: TextStyle(fontSize: 13)),
                              ),),
                              DataColumn(label:  Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Parent Strategy', style: TextStyle(fontSize: 13)),
                              ),),
                              DataColumn(label:  Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Team', style: TextStyle(fontSize: 13)),
                              ),),
                              DataColumn(label:  Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Plans', style: TextStyle(fontSize: 13)),
                              ),),
                              DataColumn(label: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Status', style: TextStyle(fontSize: 13)),
                              ),),
                              DataColumn(label:  Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                child: Text('Action', style: TextStyle(fontSize: 13)),
                              ),),
                            ],
                            rows: _strategyController.strategy.map((strategy) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(strategy.name)),
                                  DataCell(Text(strategy.parentStrategy)),
                                  DataCell(Text(strategy.team)),
                                  DataCell(Text(strategy.plans)),
                                  DataCell((Text(strategy.status, style: TextStyle(color: strategy.status == 'Active' ? Colors.green : Colors.red))),
                                  ),
                                  DataCell(
                                    PopupMenuButton(
                                      icon: Icon(Icons.more_vert),
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          child: ListTile(
                                            leading: Icon(Icons.edit),
                                            title: Text('Edit'),
                                            onTap: () {},
                                          ),
                                          value: 'option1',
                                        ),
                                        PopupMenuItem(
                                          child: ListTile(
                                            leading: Icon(Icons.delete),
                                            title: Text('Delete'),
                                            onTap: () {
                                              setState(() {
                                                _strategyController.removeStudent(_strategyController.strategy.indexOf(strategy));
                                              });
                                            },
                                          ),
                                          value: 'option2',
                                        ),
                                      ],
                                      onSelected: (value) {
                                        print('Selected option: $value');
                                      },
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                       ),
                      ),
                ),

                     ],
                  ),

        ),


          //],

    );
  }

}

class TableBorderPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final Color color;

  TableBorderPainter({required this.borderRadius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final radius = borderRadius.resolve(TextDirection.ltr);
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Draw the rounded border
    final rrect = RRect.fromRectAndRadius(rect, radius.topLeft);
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}