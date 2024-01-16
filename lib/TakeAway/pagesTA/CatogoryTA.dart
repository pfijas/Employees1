import 'package:flutter/material.dart';
import '../../Models/Dinning.dart';

class CategoryTabTA extends StatefulWidget {
  final List<Category>? category;
  final List<Items>? items;
  final int tabIndex;
  final TabController tabController;
  int? selectedCategoryId;
  final void Function(int?)? onCategorySelected; // Add this line

  CategoryTabTA({
    required this.category,
    required this.tabIndex,
    required this.tabController,
    required this.onCategorySelected,
    this.items,
  });

  @override
  _CategoryTabTAState createState() => _CategoryTabTAState();
}

class _CategoryTabTAState extends State<CategoryTabTA> {
  int? tappedCategoryId;
  bool isContainerVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: double.infinity,
            width: 300,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: widget.category?.length ?? 0,
              itemBuilder: (context, index) {
                String itemName = widget.category?[index].catName ?? '';
                return InkWell(
                  onTap: () {
                    setState(() {
                      tappedCategoryId = widget.category?[index].catId;
                      widget.tabController.animateTo(1);

                    });
                    widget.selectedCategoryId = tappedCategoryId;
                    widget.onCategorySelected?.call(widget.selectedCategoryId);
                    print("Selected Category Id: ${widget.selectedCategoryId}");
                  },
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ID: ${widget.category?[index].catId ?? ''}',
                              ),
                              isContainerVisible
                                  ? Container(
                                      child: Text(
                                        '$itemName',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              // Add more details as needed
                            ],
                          ),
                          // Add more widgets here for additional details or actions
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Divider(
          //   thickness: 1,
          // ),
          // Container(
          //   height: double.infinity,
          //   width: 550,
          //   child: _SecondContainer(
          //     tabIndex: widget.tabIndex, // Pass the tabIndex parameter here
          //     selectedCategoryId: tappedCategoryId,
          //     items: widget.items,
          //   ),
          // ),
        ],
      ),
    );
  }
}

// class _SecondContainer extends StatefulWidget {
//   final int tabIndex;
//   final List<Items>? items;
//   final int? selectedCategoryId;
//   final void Function(Map<String, int>)? onItemQuantitiesUpdated;
//   final void Function(Map<String, int>)? onQuantitiesUpdated; // Add this line
//   final void Function(int?)? onCategorySelected;
//   final void Function(String?, double?, int)? onItemSelected;
//
//   _SecondContainer({
//     Key? key,
//     required this.selectedCategoryId,
//     required this.items,
//     required this.tabIndex,
//     this.onItemQuantitiesUpdated,
//     this.onQuantitiesUpdated,
//     this.onCategorySelected,
//     this.onItemSelected,
//   }) : super(key: key);
//
//   @override
//   __SecondContainerState createState() => __SecondContainerState();
// }
//
// class __SecondContainerState extends State<_SecondContainer> {
//   Map<String, int> itemQuantities = {};
//
//   @override
//   Widget build(BuildContext context) {
//     print("All Items: ${widget.items}");
//
//     List<Items> selectedCatItems = (widget.items ?? [])
//         .where((item) => item.catId == widget.selectedCategoryId)
//         .toList();
//
//     print("Selected Category ID in Second Container: ${widget.selectedCategoryId}");
//     print("All Items for Selected Category: ${widget.items}");
//     print("Selected Items for Selected Category: $selectedCatItems");
//     print("Number of Items for Selected Category: ${selectedCatItems.length}");
//
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 6,
//         crossAxisSpacing: 8.0,
//         mainAxisSpacing: 8.0,
//       ),
//       itemCount: selectedCatItems.length, // Check this parameter
//       itemBuilder: (context, index) {
//         String itemName = selectedCatItems[index].name ?? '';
//         double rate = selectedCatItems[index].sRate ?? 0.0;
//
//         return InkWell(
//           onTap: () {
//             int currentQuantity = itemQuantities[itemName] ?? 0;
//             widget.onItemSelected?.call(itemName, rate, currentQuantity + 1);
//             setState(() {
//               itemQuantities[itemName] = currentQuantity + 1;
//               widget.onQuantitiesUpdated?.call(itemQuantities);
//             });
//           },
//           child: Card(
//             elevation: 3,
//             margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         '$itemName',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Add more widgets here for additional details or actions
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
