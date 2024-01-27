import 'package:flutter/material.dart';
import 'package:project_petcare/helper/constBread.dart';
import 'package:project_petcare/model/categories.dart';
import 'package:project_petcare/provider/categoryprovider.dart';
import 'package:provider/provider.dart';

class CategoriesDetails extends StatefulWidget {
  final Categories? categories;

  CategoriesDetails({Key? key, this.categories}) : super(key: key);

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  String? selectedCatBreed, selectedDogBreed, selectedFishBreed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CategoriesProvider>(
        builder: (context, categoriesProvider, child) => Column(
          children: [
            Container(
              height: 100,
            ),
            Container(
              child: Column(
                children: [
                  Image.network(widget.categories!.categoriesImage!),
                  Text(widget.categories!.categoriesName!),
                  _buildCategoryContent(widget.categories!.categoriesName!),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryContent(String category) {
    if (category == "Dog") {
      return _categoryDog();
    } else if (category == "Cat") {
      return _categoryCat();
    } else if (category == "Fish") {
      return _categoryFish();
    } else {
      return Text("Unknown category");
    }
  }

  Widget _categoryDog() {
    return Column(
      children: [
        Text("Dog-specific content"),
        DropdownButton<String>(
          hint: Text("Select a dog breed"),
          value: selectedDogBreed,
          onChanged: (value) {
            setState(() {
              selectedDogBreed = value!;
            });
          },
          items: dogBreedList.map((breed) {
            return DropdownMenuItem<String>(
              value: breed,
              child: Text(breed),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _categoryCat() {
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

  Widget _categoryFish() {
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
