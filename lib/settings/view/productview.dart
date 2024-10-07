import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:project_scitforte/settings/controllers/product_controller.dart';
import 'package:project_scitforte/settings/utils/productform.dart';

class productListScreen extends StatefulWidget {
  @override
  State<productListScreen> createState() => _productListScreenState();
}

class _productListScreenState extends State<productListScreen> {
  final productgroupListScreen _productListScreen = Get.put(productgroupListScreen());
  Productgrp? selectedProduct; // Variable to hold the selected product

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showproductDialog(context);
        },
        backgroundColor: Color(0xFFC01562),
        child: Icon(Icons.add, size: 30, color: Colors.white), // Adjust the icon size if needed
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.black45),
        backgroundColor: Color.fromRGBO(51, 51, 81, 1),
        actions: [
          IconButton(icon: Icon(Icons.message, color: Colors.white, size: 20), onPressed: () {}),
          IconButton(icon: Icon(Icons.notifications, color: Colors.white, size: 20), onPressed: () {}),
          IconButton(icon: Icon(Icons.grid_view, color: Colors.white, size: 20), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white, size: 20),
            onPressed: () {
              // Handle exit action here
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Product Category',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Expanded(
            child: GroupedListView<Productgrp, String>(
              useStickyGroupSeparators: true,
              elements: _productListScreen.products,
              groupBy: (products) => products.group,
              groupSeparatorBuilder: (value) => Container(
                height: MediaQuery.of(context).size.height * 0.07,
                padding: const EdgeInsets.all(14),
                color: Colors.deepPurple[200],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      value,
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              itemBuilder: (context, element) => Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                child: ListTile(
                  leading: Expanded(
                    child: Text(
                      element.name,
                      style: TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis, // Optional: Use ellipsis for long text
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _productListScreen.removeElement; // Call removeElement method
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit action here
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
