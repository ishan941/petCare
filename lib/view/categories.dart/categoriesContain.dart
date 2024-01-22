import 'package:flutter/material.dart';

class CategoriesContain extends StatefulWidget {
  final String? categoryTitle;

  CategoriesContain({Key? key, this.categoryTitle}) : super(key: key);

  @override
  _CategoriesContainState createState() => _CategoriesContainState();
}

class _CategoriesContainState extends State<CategoriesContain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.categoryTitle ?? "Search Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            Text(
              "Category: ${widget.categoryTitle ?? 'Unknown'}",
              style: TextStyle(fontSize: 24),
            ),
            
            if (widget.categoryTitle == "Dog") ...[
              Text("Dog-specific content"),
            ] else if (widget.categoryTitle == "Cat") ...[
              Text("Cat-specific content"),
            ] else ...[
              Text("General content for unknown categories"),
            ],
          ],
        ),
      ),
    );
  }
}
