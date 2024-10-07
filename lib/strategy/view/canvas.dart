import 'package:flutter/material.dart';
import 'package:project_scitforte/strategy/view/strategymap.dart';

class StrategyPlanner extends StatefulWidget {
  @override
  _StrategyPlannerState createState() => _StrategyPlannerState();
}

class _StrategyPlannerState extends State<StrategyPlanner> {
  List<String> _strategyPrinciples = [
    'Current Position       ',
    'Strategic Foundation   ',
    'Organizational Strategy',
    'Strategic Direction    ',
  ];

  List<String> _strategicElements = [
    'Strategic Issue',
    'External Analysis',
    'SWOT',
    'Core Purpose',
    'Key Differentiators',
    'Competitive Advantage',
    'BHAG',
    'Core Competencies',
    'Key Capabilities',
    'Sandbox',
  ];

  List<String> _droppedItems = [];
  Map<String, List<String>> _droppedItemsMap = {};

  List<Color> _principleColors = [
    Colors.blue[100]!,
    Colors.red[100]!,
    Colors.green[100]!,
    Colors.yellow[100]!,
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Strategy Planner'),
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w400,
          color: Colors.black,
          fontSize: 16,
        ),
        toolbarHeight: 35.0, // Decreased height, you can adjust this value as needed
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView( // Wrap the entire body in a scrollable view
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildPrinciplesColumn(),
                  _buildElementsColumn(),
                ],
              ),
              SizedBox(height: 10),
              _buildDropTarget(),
              SizedBox(height: 7),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MapScreen(droppedItemsMap: _droppedItemsMap,),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFC01562),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrinciplesColumn() {
    return Expanded( // Use Expanded for flexibility
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to start
        children: [
          SizedBox(height: 8.0),
          Text(
            'Strategic Principles',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.0),
          ..._strategyPrinciples
              .asMap()
              .entries
              .map((entry) {
            return Draggable<String>(
              data: entry.value,
              child: _buildStrategyPrincipleItem(entry.value,
                  _principleColors[entry.key % _principleColors.length]),
              feedback: _buildStrategyPrincipleItem(entry.value,
                  _principleColors[entry.key % _principleColors.length]),
              childWhenDragging: Container(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildElementsColumn() {
    return Expanded( // Use Expanded for flexibility
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align to start
        children: [
          SizedBox(height: 0.0),
          Text(
            'Strategic Elements',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Container(
            height: 176, // Set a fixed height for the scrollable area
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align to start
                children: _strategicElements.map((element) {
                  return Draggable<String>(
                    data: element,
                    child: _buildStrategicElementItem(element),
                    feedback: _buildStrategicElementItem(element),
                    childWhenDragging: Container(),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropTarget() {
    return DragTarget<String>(
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          if (!_droppedItemsMap.containsKey(data)) {
            _droppedItemsMap[data] = [];
          }
          if (_strategyPrinciples.contains(data)) {
            _droppedItemsMap[data] = [];
          } else {
            _droppedItemsMap[_strategyPrinciples[0]]?.add(data);
          }
        });
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 350, // Fixed height for the drop area
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to start
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(child: Text(' Drop items here')),
                    IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _droppedItemsMap.clear();
                        });
                      },
                    ),
                  ],
                ),
                ..._droppedItemsMap.keys.map((key) {
                  return _buildDroppedItem(key, _droppedItemsMap[key]!);
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDroppedItem(String key, List<String> items) {
    return ExpansionTile(
      title: Text(key),
      children: [
        ...items.map((item) {
          return ListTile(
            title: Text(item),
          );
        }),
        DragTarget<String>(
          onWillAccept: (data) => true,
          onAccept: (data) {
            setState(() {
              _droppedItemsMap[key]?.add(data);
            });
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStrategyPrincipleItem(String text, Color color) {
    return Card(
      elevation: 0, // Remove the elevation to make it look flat
      color: color,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 6.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 12.0),
        ),
      ),
    );
  }

  Widget _buildStrategicElementItem(String text) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 6.0),
      decoration: BoxDecoration(
        border: Border(left: BorderSide(
            color: Color(0xFFC01562), width: 4)), // Add a colored line
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 12),
      ),
    );
  }

}