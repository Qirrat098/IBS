import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  final Map<String, List<String>> droppedItemsMap;

  MapScreen({required this.droppedItemsMap});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _textController = TextEditingController();

  void _addNewElement(String principle) {
    setState(() {
      if (widget.droppedItemsMap[principle] == null) {
        widget.droppedItemsMap[principle] = [];
      }
      widget.droppedItemsMap[principle]!.add(_textController.text);
      _textController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Strategy Map'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.white,
          fontSize: 16,
        ),
        backgroundColor: Color(0xFF333452),
        toolbarHeight: 35.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/home_strategy'); // Navigate to the "home" page
        },
        backgroundColor: Color(0xFFC01562),
        label: Text(
          'Save',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Set the border radius to 0 for square shape
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Strategy Pillar',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 35, // Reduce height of the TextField
                            child: TextField(
                              controller: _textController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Add new element',
                                contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        ElevatedButton(
                          onPressed: () {
                            _addNewElement('Strategy Pillar');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFC01562), // Button color
                            side: BorderSide(color: Color(0xFFC01562)), // Border color
                            shape: CircleBorder(),
                            padding: EdgeInsets.all(0), // No padding
                            minimumSize: Size(30, 30),  // Set the minimum size to shrink the button
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Remove extra padding around the button
                          ),
                          child: Icon(Icons.add, color: Colors.white, size: 18), // Small icon
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    ...widget.droppedItemsMap['Strategy Pillar']?.map((element) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            element,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black54,
                            ),
                          ),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text('Delete'),
                                onTap: () {
                                  setState(() {
                                    widget.droppedItemsMap['Strategy Pillar']!.remove(element);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    }).toList() ?? [],
                  ],
                ),
              ),
              ...widget.droppedItemsMap.keys.where((key) => key != 'Strategy Pillar').map((principle) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            principle,
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: Text('Delete'),
                                onTap: () {
                                  setState(() {
                                    widget.droppedItemsMap.remove(principle);
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 8.0),
                      ...widget.droppedItemsMap[principle]!.map((element) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              element,
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black54,
                              ),
                            ),
                            PopupMenuButton(
                              icon: Icon(Icons.more_vert),
                              itemBuilder: (context) => [
                                PopupMenuItem(
                                  child: Text('Delete'),
                                  onTap: () {
                                    setState(() {
                                      widget.droppedItemsMap[principle]!.remove(element);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        );
                      }).toList(),
                      SizedBox(height: 16.0),
                    ],
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
