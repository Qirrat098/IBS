import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_scitforte/settings/view/page2.dart';
import 'package:project_scitforte/settings/view/plan_type.dart';
import 'package:project_scitforte/settings/view/productview.dart';
import 'package:project_scitforte/settings/view/project_status.dart';
import 'package:project_scitforte/settings/view/project_type.dart';
import 'package:project_scitforte/settings/view/roleview.dart';
import 'package:project_scitforte/settings/view/strategy_type.dart';
import 'package:project_scitforte/settings/view/taxview.dart';
import 'package:project_scitforte/settings/view/user.dart';

import '../../drawer_menu.dart';
import '../../login_signup/navbar.dart';
import 'action_status.dart';
import 'action_type.dart';
import 'activitygrouplist.dart';
import 'focusarea_type.dart';
import 'measure_type.dart';
import 'measureunit.dart';
import 'objective_type.dart';

class home_setting extends StatefulWidget {
  const home_setting({super.key});

  @override
  State<home_setting> createState() => _home_settingState();
}

class _home_settingState extends State<home_setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          systemOverlayStyle:  SystemUiOverlayStyle(
            statusBarColor: Colors.black45,
          ),
          backgroundColor:
          Color.fromRGBO(51, 51, 81,1),

          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.white ,  size: 20),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DrawerMenu()),
              );
            },
          ),
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


        body:
        SingleChildScrollView(
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
                              'Settings',
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                strategytype(title: '')),
                          );
                        }, child:_buildStrategyPrincipleItem('Strategy type')
                        ),

                        TextButton(onPressed: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              plantype(title: '')),
                        );
                        }, child:_buildStrategyPrincipleItem('Plan type')
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              focusareatype(title: '')),
                        );
                        }, child:_buildStrategyPrincipleItem('Focus area type')
                        ),

                        TextButton(onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                             objectivetype(title: '')),
                        );
                        }, child:_buildStrategyPrincipleItem('Objective type')
                        ),

                        TextButton(onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              projecttype(title: '')),
                        );
                        }, child:_buildStrategyPrincipleItem('Project type')
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                measuretype(title: '')),
                          );
                        }, child:_buildStrategyPrincipleItem('Measure type')
                        ),
                        TextButton(onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              actiontype(title: '')),
                        );
                        }, child:_buildStrategyPrincipleItem('Action type')
                        ),
                        TextButton(onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              measureunit(title: '')),
                        );
                        }, child:_buildStrategyPrincipleItem('Measure unit')
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              CalendarPage2()),
                        );
                        }, child:_buildStrategyPrincipleItem('Time horizon')
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              GroupListScreen()),
                        );
                        }, child:_buildStrategyPrincipleItem('Activity type')
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              productListScreen()),
                        );
                        }, child:_buildStrategyPrincipleItem('Product category and Sub Category')
                        ),
                        TextButton(onPressed: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => createuser()),
                        );
                        }, child:_buildStrategyPrincipleItem('Users')
                        ), TextButton(onPressed: (){
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => taxview(title: '',)),
                        );
                        }, child:_buildStrategyPrincipleItem('Tax')
                        ),
                        TextButton(onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                        actionstatus(title: '',),)
                        );
                        }, child:_buildStrategyPrincipleItem('Active Status')
                        ),
                        TextButton(onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              projectstatus (title: '')),
                        );
                        }, child:_buildStrategyPrincipleItem('Project status')
                        ),
                        TextButton(onPressed: (){Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>
                              roles(title: '',)),
                        );
                        }, child:_buildStrategyPrincipleItem('Roles')
                        ),
                      ],
                      //      )
                      // )

                    ),
                  ),




                ]


            )

        )
    );
  }
}

Widget _buildStrategyPrincipleItem(String text) {

  return Container(
    width: 500,
    // height: 200,
    padding: EdgeInsets.all(8.0),
    margin: EdgeInsets.only(bottom: 2.0,left: 0),
    decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]!),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.blueGrey.withOpacity(0.1),
              spreadRadius:3,
              blurRadius: 7
          )
        ]
    ),
    child: Text(
      text,
      style: TextStyle(fontSize: 14, color: Colors.black , fontWeight: FontWeight.w400),
    ),


  );

}
