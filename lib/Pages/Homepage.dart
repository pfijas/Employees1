

import 'dart:convert';

import 'package:employees/Models/Dinning.dart';
import 'package:employees/Pages/Dashboard.dart';
import 'package:employees/Utils/GlobalFn.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Category.dart';
import 'ItemsTab.dart';
import 'Tables.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  final String? employeeName;

  const Homepage({
    Key? key, this.employeeName,
  }) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  String? DeviceId = "";
  SQLMessage? sqlMessage;
  List<ExtraAddOn>? extraddon;
  List<Category>? category;
  List<Items>? items;
  List<Voucher>? voucher;
  Future<Dinning>? dinningData;
  int? selectedCategoryId;
  List<String> selectedItemrate = [];
  Map<String, int> itemQuantities = {};
  List<String> selectedItemsname = [];

  void _removeItem(String itemName) {
    setState(() {
      selectedItemsname.remove(itemName);
      selectedItemrate.remove(
          itemRates); // Assuming you also want to remove it from selectedItemrate
      itemQuantities.remove(itemName);
    });
  }

  double calculateOverallTotal() {
    double overallTotal = 0.0;
    for (int i = 0; i < selectedItemsname.length; i++) {
      String rate = selectedItemrate.elementAt(i);
      int quantity = itemQuantities[selectedItemsname.elementAt(i)] ?? 0;
      double total = double.parse(rate) * quantity;
      overallTotal += total;
    }
    return overallTotal;
  }

  // Add this function in your _HomepageState class
  void showExtraAddonDialog(BuildContext context, ExtraAddOn extraAddon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Extra Add-On')),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Item ID: ${extraAddon.itemId}'),
              Text('Name: ${extraAddon.name}'),
              Text('Rate: ${extraAddon.sRate}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showExtraAddonDialog2(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Extra Add-On')),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Item ID: '),
              Text('Name:'),
              Text('Rate:'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    dinningData = fetchData2();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0); // Set the correct length (4 in this case)
  }

  Future<Dinning> fetchData2() async {
    DeviceId = await fnGetDeviceId();
    final String? baseUrl = await fnGetBaseUrl();
    String apiUrl = '${baseUrl}api/Dinein/alldata';

    try {
      apiUrl = '$apiUrl?DeviceId=$DeviceId';
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        Dinning dinning = Dinning.fromJson(json.decode(response.body));
        sqlMessage = dinning.data?.sQLMessage;

        if (sqlMessage?.code == "200") {
          extraddon = dinning.data?.extraAddOn;
          category = dinning.data?.category;
          items = dinning.data?.items;
          voucher = dinning.data?.voucher;
        }
        return dinning; // Return the fetched data
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      throw e; // Rethrow the exception to propagate it
    }
  }

  Map<String, double> itemRates = {};

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        hintColor: Colors.black87,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              int currentIndex = tabController.index;
              if (currentIndex == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboardpage(),
                  ),
                );
              }
            },
          ),
          title: Text(widget.employeeName ?? 'Homepage'), // Use the employeeName as the title
          centerTitle: true,
          bottom: TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.black87,
            labelColor: Colors.white,
            tabs: [
              Tab(text: "Tables"),
              Tab(text: "CATEGORY"),
              Tab(text: "ITEMS"),
            ],
          ),
        ),
        body: FutureBuilder<Dinning>(
          future: dinningData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.data == null) {
              return Center(
                  child: Text(
                      'No data available')); // Adjust the message as needed
            } else {
              Dinning dinning = snapshot.data!;
              List<Tables>? tables = dinning.data?.tables;

              return TabBarView(
                controller: tabController,
                children: [
                  Center(
                    child: TablesTab(
                      tabIndex: 0,
                      tables:tables,
                      tabController:tabController,
                    ),
                  ),
                  Center(
                    child: CategoryTab(
                      category: category,
                      tabIndex: 1,
                      tabController: tabController,
                      onCategorySelected: (categoryId) {
                        setState(() {
                          selectedCategoryId = categoryId;
                        });
                      },
                    ),
                  ),
                  Center(
                    child: ItemsTab(
                      tabIndex: 2,
                      items: items,
                      selectedCategoryId: selectedCategoryId,
                      onItemSelected: (itemName, rate, quantity) {
                        setState(() {
                          if (itemName != null) {
                            // Check if the itemName is already selected
                            if (!selectedItemsname.contains(itemName)) {
                              selectedItemsname.add(itemName);
                              selectedItemrate.add(rate?.toString() ?? '');
                            } else {
                              // If the itemName is already selected, increase the quantity
                              int currentIndex =
                              selectedItemsname.indexOf(itemName);
                              itemQuantities[itemName] = quantity;
                              selectedItemrate[currentIndex] =
                                  rate?.toString() ?? '';
                            }
                          }
                        });
                      },
                      onQuantitiesUpdated: (updatedQuantities) {
                        // Handle updated itemQuantities in the Homepage widget
                        setState(() {
                          itemQuantities = updatedQuantities;
                        });
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
        bottomNavigationBar: SingleChildScrollView(
          child: Container(
            child: Card(
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "KOT:",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Divider(thickness: 2, color: Colors.black87),
                    Container(
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        "Item",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        "Quadity",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        "Rate",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 30,),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        "Total",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 80),
                                  ],
                                ),
                                Container(
                                  height: 400,
                                  child: ListView.builder(
                                    itemCount: selectedItemsname.length,
                                    itemBuilder: (context, index) {
                                      String rate =
                                      selectedItemrate.elementAt(index);
                                      String itemName =
                                      selectedItemsname.elementAt(index);
                                      int quantity =
                                          itemQuantities[itemName] ?? 0;
                                      double total =
                                          double.parse(rate) * quantity;

                                      return ListTile(
                                        title: Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                showExtraAddonDialog2(
                                                  context,
                                                );
                                                print(
                                                    "Selected itemName: $itemName");
                                                print("extraddon: $extraddon");
                                              },
                                              child: Text("$itemName"),
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 70),
                                              child: Text("$quantity"),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 80),
                                              child: Text(rate),
                                            ),
                                            Text("$total"),
                                            SizedBox(width: 20),
                                            IconButton(
                                              iconSize: 30,
                                              icon: const Icon(Icons.delete),
                                              onPressed: () {
                                                _removeItem(itemName);
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Text("Total : ",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      SizedBox(width: 5),
                                      Text(calculateOverallTotal().toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          )),
                                      SizedBox(
                                        width: 80,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Container(height: 300),
                    Container(
                      child: Row(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.0),
                            ),
                            elevation: 5,
                            child: IconButton(
                              iconSize: 30,
                              icon: const Icon(
                                Icons.add,
                              ),
                              onPressed: () {
                                // Implement your logic
                              },
                            ),
                          ),
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17.0),
                            ),
                            elevation: 5,
                            child: IconButton(
                              iconSize: 30,
                              icon: const Icon(
                                Icons.remove,
                              ),
                              onPressed: () {
                                // Implement your logic
                              },
                            ),
                          ),
                          SizedBox(
                            width: 100,
                          ),
                          Card(
                            color: Colors.black87,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("NOTE",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedItemsname.clear();
                                selectedItemrate.clear();
                              });
                            },
                            child: Card(
                              color: Colors.black87,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  "CLEAR",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Icon(Icons.print, size: 35),
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: InkWell(
                              onTap: () {
                                //handleKOTCardTap();
                              },
                              child: Card(
                                color: Colors.black87,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    "   KOT  ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          // ),
        ),
      ),
    ));
  }
}
