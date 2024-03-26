import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constBread.dart';

class CategoriesContain extends StatefulWidget {
  final String? categoryTitle;

  CategoriesContain({Key? key, this.categoryTitle}) : super(key: key);

  @override
  _CategoriesContainState createState() => _CategoriesContainState();
}

class _CategoriesContainState extends State<CategoriesContain> {
  String? selectedDogBreed, selectedCatBreed, selectedFishBreed;
  List<String> hellolist = ["1", "1"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.categoryTitle ?? "Search Page"),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Category: ${widget.categoryTitle ?? 'Unknown'}",
              style: TextStyle(fontSize: 24),
            ),
            if (widget.categoryTitle == "Dog") ...[
              category_Dog(),
            ] else if (widget.categoryTitle == "Cat") ...[
              Category_Cat()
            ] else if (widget.categoryTitle == "Fish") ...[
              Category_Fish()
            ],
          ],
        ),
      ),
    );
  }

  Widget category_Dog() {
    return Column(
      children: [
        // Text(
        //   "Dog-specific content",
        // ),
        // DropdownButton<String>(
        //   hint: Text("Select a dog breed"),
        //   value: selectedDogBreed,
        //   onChanged: (value) {
        //     setState(() {
        //       selectedDogBreed = value!;
        //     });
        //   },
        //   items: dogBreedList.map((breed) {
        //     return DropdownMenuItem<String>(
        //       value: breed,
        //       child: Text(breed),
        //     );
        //   }).toList(),
        // ),
        
      ],
    );
  }

  Widget Category_Cat() {
    return Column(
      children: [
        Text("Cat-specific content"),
        DropdownButton<String>(
          hint: Text("Select a cat breed"),
          value: selectedCatBreed,
          onChanged: (value) {
            setState(() {
              selectedCatBreed = value!;
            });
          },
          items: catBreedList.map((breed) {
            return DropdownMenuItem<String>(
              value: breed,
              child: Text(breed),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget Category_Fish() {
    return Column(
      children: [
        DropdownButton<String>(
          hint: Text("Select a fish breed"),
          value: selectedFishBreed,
          onChanged: (value) {
            setState(() {
              selectedFishBreed = value!;
            });
          },
          items: fishBreedList.map((breed) {
            return DropdownMenuItem<String>(
              value: breed,
              child: Text(breed),
            );
          }).toList(),
        ),
      ],
    );
  }
}
