import 'package:flutter/material.dart';
import '../Models/Dinning.dart';

class ItemsTab extends StatefulWidget {
  final int tabIndex;
  final List<Items>? items;
  final int? selectedCategoryId;
  final void Function(Map<String, int>)? onItemQuantitiesUpdated;
  final void Function(Map<String, int>)? onQuantitiesUpdated;
  final void Function(int?)? onCategorySelected;
  final void Function(String?, double?, int)? onItemSelected;

  ItemsTab({
    required this.tabIndex,
    this.items,
    this.selectedCategoryId,
    this.onCategorySelected,
    this.onItemSelected,
    this.onItemQuantitiesUpdated,
    required this.onQuantitiesUpdated, // Remove the duplicate line
  });

  @override
  _ItemsTabState createState() => _ItemsTabState();
}

class _ItemsTabState extends State<ItemsTab> {
  Map<String, int> itemQuantities = {};

  @override
  Widget build(BuildContext context) {
    if (widget.tabIndex == 2) {
      List<Items> selectedCatItems = (widget.items ?? [])
          .where((item) => item.catId == widget.selectedCategoryId)
          .toList();

      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: selectedCatItems.length,
        itemBuilder: (context, index) {
          String itemName = selectedCatItems[index].name ?? '';
          double rate = selectedCatItems[index].sRate ?? 0.0;

          return InkWell(
            onTap: () {
              int currentQuantity = itemQuantities[itemName] ?? 0;
              widget.onItemSelected?.call(itemName, rate, currentQuantity + 1);
              setState(() {
                itemQuantities[itemName] = currentQuantity + 1;
                widget.onQuantitiesUpdated?.call(itemQuantities);
              });
            },
            child: Card(
              elevation: 3,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${selectedCatItems[index].name ?? ''}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Add more widgets here for additional details or actions
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
