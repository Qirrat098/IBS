import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


import '../view/canvas.dart';
import 'color.dart';
import '../controller/controller.dart';
import '../view/home.dart';
Future<void>  showstrategyDialog(BuildContext context)async {
  return await showDialog(context: context,
      builder: (context){
        final _formKey = GlobalKey<FormState>();
        final StrategyController _StrategyController = Get.find();
        String? _Strategy;
        String? _parentStrategy;
        String? _team;
        String? _timeframe;
        String? _strategyType;
        String? _status;


        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
            ),

            content:  Container(

              width: MediaQuery.of(context).size.width * 0.8,
              height:
              MediaQuery.of(context).size.height * 0.6,
              child:
              SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Create new strategy',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text('Strategy'  ,
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        height: 35, // Set the desired height
                        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Set the border color
                            width: 1.0, // Set the border width
                          ),
                          borderRadius: BorderRadius.circular(0), // Optional: for rounded corners
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 5),
                              border: InputBorder.none, // Remove default border
                              labelText: '',
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: 'Enter strategy name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a strategy name';
                              }
                              return null;
                            },
                            onSaved: (value) => _Strategy  = value!, // Save strategy name
                          ),
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      Text('Parent Strategy',
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 35, // Set the desired height
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Set the border color
                            width: 1.0, // Set the border width
                          ),
                          borderRadius: BorderRadius.circular(0), // Optional: for rounded corners
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _parentStrategy,
                            isExpanded: true, // Ensure the dropdown button takes the full width
                            hint: Text(
                              'Nothing selected',
                              style: GoogleFonts.inter(fontSize: 14), // Adjust hint text style
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _parentStrategy = newValue!;
                              });
                            },
                            items: <String>['Marketing', 'Finance']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0), // Add horizontal padding
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal, // Ensure text is not bold
                                      fontSize: 13, // Decrease font size of options
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14.0),
                      Text('Team'  ,
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 35, // Set the desired height
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Set the border color
                            width: 1.0, // Set the border width
                          ),
                          borderRadius: BorderRadius.circular(0), // Optional: for rounded corners
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _team,
                            isExpanded: true, // Ensure the dropdown button takes the full width
                            hint: Text(
                              'Nothing selected',
                              style: GoogleFonts.inter(fontSize: 14), // Adjust hint text style
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _team = newValue!;
                              });
                            },
                            items: <String>['Team1 ', 'Team2 ']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0), // Add horizontal padding
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13, // Decrease font size of options
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 14.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the row items
                    children: [
                  Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Time Frame',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _timeframe,
                            isExpanded: true,
                            hint: Text(
                              ' select',
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _timeframe = newValue!;
                              });
                            },
                            items: <String>[
                              'One Week',
                              'Two Weeks',
                              'One Month',
                              'Three Months',
                              'Six Months',
                              'One Year'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16.0), // Spacing between the dropdowns
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Status',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _status,
                            isExpanded: true,
                            hint: Text(
                              ' select',
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _status = newValue!;
                              });
                            },
                            items: <String>[
                              'Active',
                              'Inactive'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                    ],
                  ),
                      const SizedBox(height: 14.0),
                      Text(
                        'Strategy Type',
                        style: GoogleFonts.inter(
                          fontSize: 13.5,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 35, // Set the desired height
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Set the border color
                            width: 1.0, // Set the border width
                          ),
                          borderRadius: BorderRadius.circular(0), // Optional: for rounded corners
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _strategyType,
                            isExpanded: true, // Ensure the dropdown button takes the full width
                            hint: Text(
                              'Nothing selected',
                              style: GoogleFonts.inter(fontSize: 14), // Adjust hint text style
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                _strategyType = newValue!;
                              });
                            },
                            items: <String>['Type1 ', 'Type2 ']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0), // Add horizontal padding
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13, // Decrease font size of options
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(

                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>MyHomePage(title: '',)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0x5A6268),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)
                                )
                            ),
                            child: Text('Cancel',
                              style: TextStyle(
                                  color: Colors.white
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _StrategyController.addStudent(Strategy (
                                    name: '$_Strategy',
                                    parentStrategy:'$_parentStrategy',
                                    team:'$_team',
                                    status:'$_status',
                                    plans:'0',
                                    StrategyType: ' $_strategyType',
                                    Timeframe: '$_timeframe',


                                )
                                );
                                //Get.back();
                                // print('Strategy Name: $_Strategy');
                                // print('Parent Strategy: $_parentStrategy');
                                // print('Team: $_team');
                                // print('Timeframe: $_timeframe');
                                // print('Strategy Type: $_strategyType');
                                // print('Status: $_status');
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) =>StrategyPlanner()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)
                                )
                            ),
                            child: const Text('Save',
                              style: TextStyle(
                                color: Colors.white,


                              ),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );


        });
      });
}