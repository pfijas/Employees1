import 'package:flutter/material.dart';

import '../Models/Dinning.dart';

class CategoryTab extends StatefulWidget {
  final List<Category>? category;
  final int tabIndex;
  final TabController tabController;
  int? selectedCategoryId;
  final void Function(int?)? onCategorySelected; // Add this line

  CategoryTab({required this.category, required this.tabIndex, required this.tabController, required this.onCategorySelected});

  @override
  _CategoryTabState createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  @override
  Widget build(BuildContext context) {
    if (widget.tabIndex == 1) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: widget.category?.length ?? 0,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            widget.tabController.animateTo(2);
            widget.selectedCategoryId = widget.category?[index].catId;
            widget.onCategorySelected?.call(widget.selectedCategoryId);
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
                        '${widget.category?[index].catName ?? ''}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text('ID: ${widget.category?[index].catId ?? ''}'),
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
    );
    } else {
      // Display a placeholder for other tabs
      return Text("Content for Tab ${widget.tabIndex}");
    }
  }
}
