// class Design4persons extends StatefulWidget {
//   final void Function(List<String>) onSeatsSelected;
//
//   Design4persons({required this.onSeatsSelected});
//
//   @override
//   _Design4personsState createState() => _Design4personsState();
// }
//
// class _Design4personsState extends State<Design4persons> {
//   List<String> seatStatus4 = [
//     'assets/images/notbookedseat.jpg',
//     'assets/images/notbookedseat.jpg',
//     'assets/images/notbookedseat.jpg',
//     'assets/images/notbookedseat.jpg',
//   ];
//   List<String> selectedSeats = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         width: 200,
//         height: 250,
//         child: Column(
//           children: [
//             _buildSeatRow(0,),
//             Spacer(),
//             Container(
//               width: 250,
//               height: 60,
//               child: Card(
//                 child: Center(child: Text("Table")),
//               ),
//             ),
//             Spacer(),
//             _buildSeatRow(2,),
//             SizedBox(height: 10),
//             Text(
//               "Seat: ${selectedSeats.join(', ')}",
//               style: TextStyle(fontSize: 20),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSeatRow(int startIndex) {
//     return Row(
//       children: [
//         Spacer(),
//         Expanded(
//           child: GestureDetector(
//             onTap: () {
//               _updateSeatStatus(startIndex);
//             },
//             child: Column(
//               children: [
//                 Image.asset(
//                   seatStatus4[startIndex],
//                   width: 40,
//                   height: 40,
//                 ),
//                 Text("${startIndex + 1}")
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           width: 50,
//         ),
//         Expanded(
//           child: GestureDetector(
//             onTap: () {
//               _updateSeatStatus(startIndex + 1);
//             },
//             child: Column(
//               children: [
//                 Image.asset(
//                   seatStatus4[startIndex + 1],
//                   width: 40,
//                   height: 40,
//                 ),
//                 Text("${startIndex + 2}")
//               ],
//             ),
//           ),
//         ),
//         Spacer(),
//       ],
//     );
//   }
//
//
//   void _updateSeatStatus(int seatIndex) {
//     final seatNumber = "S${seatIndex + 1}";
//
//     setState(() {
//       if (seatStatus4[seatIndex] == 'assets/images/notbookedseat.jpg') {
//         seatStatus4[seatIndex] = 'assets/images/Bookedseat.jpg';
//         selectedSeats.add(seatNumber);
//       } else {
//         seatStatus4[seatIndex] = 'assets/images/notbookedseat.jpg';
//         selectedSeats.remove(seatNumber);
//       }
//     });
//     final sortedSeats = List<String>.from(selectedSeats)..sort();
//     widget.onSeatsSelected(sortedSeats);
//   }
//
// }

// class Design4persons2 extends StatefulWidget {
//   final void Function(List<String>) onSeatsSelected;
//
//   Design4persons2({required this.onSeatsSelected});
//
//   @override
//   _Design4persons2State createState() => _Design4persons2State();
// }
//
// class _Design4persons2State extends State<Design4persons2> {
//   List<String> tappedCards = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300,
//       width: 200,
//       child: Column(
//         children: [
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () => handleCardTap("s1"),
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   child: Card(
//                     color: tappedCards.contains("s1") ? Colors.blue : null,
//                     child: Center(child: Text("s1")),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => handleCardTap("s2"),
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   child: Card(
//                     color: tappedCards.contains("s2") ? Colors.blue : null,
//                     child: Center(child: Text("s2")),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             children: [
//               GestureDetector(
//                 onTap: () => handleCardTap("s3"),
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   child: Card(
//                     color: tappedCards.contains("s3") ? Colors.blue : null,
//                     child: Center(child: Text("s3")),
//                   ),
//                 ),
//               ),
//               GestureDetector(
//                 onTap: () => handleCardTap("s4"),
//                 child: Container(
//                   height: 50,
//                   width: 50,
//                   child: Card(
//                     color: tappedCards.contains("s4") ? Colors.blue : null,
//                     child: Center(child: Text("s4")),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: tappedCards.length,
//               itemBuilder: (context, index) {
//                 return Text(tappedCards[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void handleCardTap(String text) {
//     setState(() {
//       if (tappedCards.contains(text)) {
//         tappedCards.remove(text);
//       } else {
//         tappedCards.add(text);
//       }
//
//       // Notify the parent widget about the selected seats
//       widget.onSeatsSelected(tappedCards);
//     });
//   }
// }
