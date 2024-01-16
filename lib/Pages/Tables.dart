import 'package:flutter/material.dart';
import '../Models/Dinning.dart';

class TablesTab extends StatefulWidget {
  final int tabIndex;
  final List<Tables>? tables;
  final void Function(String?, double?)? ontablenamesel;

  TablesTab({required this.tabIndex, this.tables, this.ontablenamesel, required TabController tabController});

  @override
  _MyTabContentState createState() => _MyTabContentState();
}

class _MyTabContentState extends State<TablesTab> {
  Map<String, List<String>> selectedSeatsMap = {};

  @override
  Widget build(BuildContext context) {
    if (widget.tabIndex == 0) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: widget.tables?.length ?? 0,
        itemBuilder: (context, index) {
          Color cardColor;
          switch (widget.tables?[index].tableStatus) {
            case 'Free':
              cardColor = Colors.green;
              break;
            case 'Full':
              cardColor = Colors.red;
              break;
            case 'Seated':
              cardColor = Colors.yellow;
              break;
            default:
              cardColor = Colors.white;
          }

          int? capacity = widget.tables?[index].chair;

          // Determine which design to use based on the capacity
          Widget design;
          if (capacity == 1) {
            design = Design1person(onSeatsSelected: (seats) {
              selectedSeatsMap[widget.tables![index].tableName!] = seats;
            });
          } else if (capacity == 2) {
            design = Design2persons(onSeatsSelected: (seats) {
              selectedSeatsMap[widget.tables![index].tableName!] = seats;
            });
          } else if (capacity == 4) {
            design = Design4persons(
              onSeatsSelected: (seats) {
                selectedSeatsMap[widget.tables![index].tableName!] = seats;
              },
            );
          } else if (capacity == 6) {
            design = Design6persons(onSeatsSelected: (seats) {
              selectedSeatsMap[widget.tables![index].tableName!] = seats;
            });
          } else {
            // Default design for other capacities
            design = DefaultDesign();
          }

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            elevation: 5,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      '${widget.tables?[index].tableName ?? ''}',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                      child: Text('Capacity: ${widget.tables?[index].chair}')),
                  Center(child: Text('Guest: ${widget.tables?[index].guest}')),
                  Spacer(),
                  Container(
                    width: double.infinity,
                    height: 30,
                    child: InkWell(
                      onTap: () {
                        _buildPopupDialog(
                          context,
                          widget.tables?[index],
                          design,
                          selectedSeatsMap[widget.tables![index].tableName!],
                        );
                      },
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          color: cardColor,
                          child: Center(
                              child: Text(
                                  '${widget.tables?[index].tableStatus}'))),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return Text("Content for Tab ${widget.tabIndex}");
    }
  }

  void _buildPopupDialog(BuildContext context, Tables? selectedTable,
      Widget design, List<String>? selectedSeats) {
    selectedSeats ??= [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(selectedTable?.tableName ?? ''),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              design,
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                // Do something with selectedTable and selectedSeats
                print("Selected Table: ${selectedTable?.tableName}");
                print("Selected Seats: ${selectedSeats?.join(', ')}");

                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class Design1person extends StatefulWidget {
  final void Function(List<String>) onSeatsSelected;

  Design1person({required this.onSeatsSelected});

  @override
  _Design1personState createState() => _Design1personState();
}

class _Design1personState extends State<Design1person> {
  List<String> seatStatus1 = ['assets/images/notbookedseat.jpg'];
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 150,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _updateSeatStatus(0);
              },
              child: Column(
                children: [
                  Image.asset(
                    seatStatus1[0],
                    width: 40,
                    height: 40,
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: 150,
              height: 60,
              child: Card(
                child: Center(child: Text("Table")),
              ),
            ),
            Spacer(),
            Text(
              "Seat: ${selectedSeats.join(', ')}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSeatStatus(int seatIndex) {
    setState(() {
      if (seatStatus1[seatIndex] == 'assets/images/notbookedseat.jpg') {
        seatStatus1[seatIndex] = 'assets/images/Bookedseat.jpg';
        selectedSeats.add("S${seatIndex + 1}");
      } else {
        seatStatus1[seatIndex] = 'assets/images/notbookedseat.jpg';
        selectedSeats.remove("S${seatIndex + 1}");
      }
      widget.onSeatsSelected(selectedSeats);
    });
  }
}

class Design2persons extends StatefulWidget {
  final void Function(List<String>) onSeatsSelected;

  Design2persons({required this.onSeatsSelected});

  @override
  _Design2personsState createState() => _Design2personsState();
}

class _Design2personsState extends State<Design2persons> {
  List<String> seatStatus2 = [
    'assets/images/notbookedseat.jpg',
    'assets/images/notbookedseat.jpg',
  ];
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 250,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                _updateSeatStatus(0);
              },
              child: Image.asset(
                seatStatus2[0],
                width: 40,
                height: 40,
              ),
            ),
            Spacer(),
            Container(
              width: 150,
              height: 60,
              child: Card(
                child: Center(child: Text("Table")),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                _updateSeatStatus(1);
              },
              child: Image.asset(
                seatStatus2[1],
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Seat: ${selectedSeats.join(', ')}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void _updateSeatStatus(int seatIndex) {
    setState(() {
      if (seatStatus2[seatIndex] == 'assets/images/notbookedseat.jpg') {
        seatStatus2[seatIndex] = 'assets/images/Bookedseat.jpg';
        selectedSeats.add("S${seatIndex + 1}");
      } else {
        seatStatus2[seatIndex] = 'assets/images/notbookedseat.jpg';
        selectedSeats.remove("S${seatIndex + 1}");
      }
    });
    widget.onSeatsSelected(selectedSeats);
  }
}

class Design4persons extends StatefulWidget {
  final void Function(List<String>) onSeatsSelected;

  Design4persons({required this.onSeatsSelected});

  @override
  _Design4personsState createState() => _Design4personsState();
}

class _Design4personsState extends State<Design4persons> {
  List<String> seatStatus4 = [
    'assets/images/notbookedseat.jpg',
    'assets/images/notbookedseat.jpg',
    'assets/images/notbookedseat.jpg',
    'assets/images/notbookedseat.jpg',
  ];
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 250,
        child: Column(
          children: [
            _buildSeatRow(
              0,
            ),
            Spacer(),
            Container(
              width: 250,
              height: 60,
              child: Card(
                child: Center(child: Text("Table")),
              ),
            ),
            Spacer(),
            _buildSeatRow(
              2,
            ),
            SizedBox(height: 10),
            Text(
              "Seat: ${selectedSeats.join(', ')}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatRow(int startIndex) {
    return Row(
      children: [
        Spacer(),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _updateSeatStatus(startIndex);
            },
            child: Column(
              children: [
                Image.asset(
                  seatStatus4[startIndex],
                  width: 40,
                  height: 40,
                ),
                Text("${startIndex + 1}")
              ],
            ),
          ),
        ),
        SizedBox(
          width: 50,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _updateSeatStatus(startIndex + 1);
            },
            child: Column(
              children: [
                Image.asset(
                  seatStatus4[startIndex + 1],
                  width: 40,
                  height: 40,
                ),
                Text("${startIndex + 2}")
              ],
            ),
          ),
        ),
        Spacer(),
      ],
    );
  }

  void _updateSeatStatus(int seatIndex) {
    final seatNumber = "S${seatIndex + 1}";

    setState(() {
      if (seatStatus4[seatIndex] == 'assets/images/notbookedseat.jpg') {
        seatStatus4[seatIndex] = 'assets/images/Bookedseat.jpg';
        selectedSeats.add(seatNumber);
      } else {
        seatStatus4[seatIndex] = 'assets/images/notbookedseat.jpg';
        selectedSeats.remove(seatNumber);
      }
    });
    final sortedSeats = List<String>.from(selectedSeats)..sort();
    widget.onSeatsSelected(sortedSeats);
  }
}

class Design6persons extends StatefulWidget {
  final void Function(List<String>) onSeatsSelected;

  Design6persons({required this.onSeatsSelected});

  @override
  _Design6personsState createState() => _Design6personsState();
}

class _Design6personsState extends State<Design6persons> {
  List<String> seatStatus6 = [
    'assets/images/notbookedseat.jpg',
    'assets/images/notbookedseat.jpg',
    'assets/images/notbookedseat.jpg',
    'assets/images/notbookedseat.jpg',
    'assets/images/notbookedseat.jpg',
    'assets/images/notbookedseat.jpg',
  ];
  List<String> selectedSeats = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 240,
      child: Column(
        children: [
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  _updateSeatSelected(0);
                },
                child: Image.asset(
                  seatStatus6[0],
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  _updateSeatSelected(1);
                },
                child: Image.asset(
                  seatStatus6[1],
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  _updateSeatSelected(2);
                },
                child: Image.asset(
                  seatStatus6[2],
                  width: 40,
                  height: 40,
                ),
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          Container(
            width: 250,
            height: 60,
            child: Card(
              child: Center(child: Text("Table")),
            ),
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () {
                  _updateSeatSelected(3);
                },
                child: Image.asset(
                  seatStatus6[3],
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  _updateSeatSelected(4);
                },
                child: Image.asset(
                  seatStatus6[4],
                  width: 40,
                  height: 40,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  _updateSeatSelected(5);
                },
                child: Image.asset(
                  seatStatus6[5],
                  width: 40,
                  height: 40,
                ),
              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Seat: ${selectedSeats.join(', ')}",
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  void _updateSeatSelected(int seatIndex) {
    setState(() {
      if (seatStatus6[seatIndex] == 'assets/images/notbookedseat.jpg') {
        seatStatus6[seatIndex] = 'assets/images/Bookedseat.jpg';
        selectedSeats.add("S${seatIndex + 1}");
      } else {
        seatStatus6[seatIndex] = 'assets/images/notbookedseat.jpg';
        selectedSeats.remove("S${seatIndex + 1}");
      }
    });
    widget.onSeatsSelected(selectedSeats);
  }
}

class DefaultDesign extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      width: 100,
      height: 100,
      child: Center(
        child: Text('Empty.....'),
      ),
    );
  }
}
